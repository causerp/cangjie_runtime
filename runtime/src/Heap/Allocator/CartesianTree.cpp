// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "CartesianTree.h"

#include "Allocator/RegionInfo.h"

namespace MapleRuntime {
bool CartesianTree::MergeInsertInternal(Index idx, Count num, bool refreshRegionInfo)
{
    //     +-------------+       +--------------+
    //     | parent node |  n--> | current node |
    //     |             |       |              |
    // pn ---> Node* l; -------> |              |
    //     |   Node* r;  |       |              |
    //     +-------------+       +--------------+
    // suppose current node is parent node's left child, then
    // n points to the current node,
    // pn points to the 'l' field in the parent node
    Node* n = root;    // root is current node
    Node** pn = &root; // pointer to the 'root' field in this tree
    // stack of pn recording how to go from root to the current node
    LocalDeque<Node**> pnStack(sud); // this uses another deque as container
    Index m = idx + num;
    // this loop insert the new node (idx, num) at the proper place
    do {
        if (n == nullptr) {
            n = new (nodeAllocator.Allocate()) Node(idx, num, refreshRegionInfo);
            CTREE_ASSERT(n != nullptr, "failed to allocate a new node");
            *pn = n;
            IncTotalCount(num);
            break;
        }
        MergeResult res = MergeAt(*n, idx, num, refreshRegionInfo);
        if (res == MergeResult::MERGE_SUCCESS) {
            break;
        } else if (UNLIKELY(res == MergeResult::MERGE_ERROR)) {
            return false;
        }
        // MergeResult::MERGE_MISS: (idx, num) cannot be connected to n
        if (m < n->GetIndex()) {
            // should insert into left subtree
            pnStack.Push(pn);
            pn = &(n->l);
            n = n->l;
        } else if (idx > n->GetIndex() + n->GetCount()) {
            // should insert into right subtree
            pnStack.Push(pn);
            pn = &(n->r);
            n = n->r;
        } else {
            // something clashes
            CTREE_ASSERT(false, "merge insertion failed");
            return false;
        }
    } while (true);

    // this loop bubbles the inserted node up the tree to satisfy heap property
    while (!pnStack.Empty()) {
        pn = pnStack.Top();
        pnStack.Pop();
        n = *pn;
        CTREE_ASSERT(n, "merge insertion bubbling failed case 1");
        if (m < n->GetIndex()) {
            // (idx, num) was inserted into n's left subtree, do rotate l, if needed
            if (n->GetCount() < n->l->GetCount()) {
                *pn = RotateLeftChild(*n);
                CTREE_CHECK_PARENT_AND_RCHILD(*pn);
            } else {
                break;
            }
        } else if (idx > n->GetIndex() + n->GetCount()) {
            // (idx, num) was inserted into n's right subtree, do rotate r, if needed
            if (n->GetCount() < n->r->GetCount()) {
                *pn = RotateRightChild(*n);
                CTREE_CHECK_PARENT_AND_LCHILD(*pn);
            } else {
                break;
            }
        } else {
            CTREE_ASSERT(false, "merge insertion bubbling failed case 2");
            return false;
        }
    }
    return true;
}

#ifdef DEBUG_CARTESIAN_TREE
void CartesianTree::DumpTree(const char* msg) const
{
    if (Empty()) {
        return;
    }

    VLOG(REPORT, "dump %s %p in graphviz .dot:", msg, this);
    VLOG(REPORT, "digraph tree%p {", this);
    CartesianTree::Iterator it(*const_cast<CartesianTree*>(this));
    auto node = it.Next();
    while (node != nullptr) {
        VLOG(REPORT, "c-tree %p N%p [label=\"%p:%u+%u=%u\"]", this, node, node, node->GetIndex(),
             node->GetCount(), node->GetIndex() + node->GetCount());

        if (node->l != nullptr) {
            VLOG(REPORT, "c-tree %p N%p -> N%p", this, node, node->l);
        }

        VLOG(REPORT, "c-tree %p N%p -> D%p [style=invis]", this, node, node);
        VLOG(REPORT, "c-tree %p D%p [width=0, style=invis]", this, node);

        if (node->r != nullptr) {
            VLOG(REPORT, "c-tree %p N%p -> N%p", this, node, node->r);
        }

        node = it.Next();
    }
    VLOG(REPORT, "}");
}
#endif

void CartesianTree::Node::RefreshFreeRegionInfo()
{
    Index idx = GetIndex();
    Count cnt = GetCount();
    RegionInfo::InitFreeRegion(idx, cnt);
}

void CartesianTree::Node::ReleaseMemory()
{
    Index idx = GetIndex();
    Count cnt = GetCount();
    RegionInfo::ReleaseUnits(idx, cnt);
}

size_t CartesianTree::GetNodeCount() const
{
    size_t nodeCount = 0;
    Iterator it(*const_cast<CartesianTree*>(this));
    while (it.Next() != nullptr) {
        ++nodeCount;
    }
    return nodeCount;
}

bool CartesianTree::TakeUnitsImpl(Count num, Index& idx, bool refershRegionInfo)
{
    ForwardIterator it(*this);
    Node** nodePtr = it.Next(); // pointer to root node
    if (UNLIKELY(nodePtr == nullptr)) {
        return false;
    }
    Node* node = *nodePtr;
    if (node != nullptr && node->GetCount() < num) {
        DLOG(REGION, "c-tree %p fail to take %u free units", this, num);
        return false;
    }
    Node** nextNodePtr = nullptr;
    while ((nextNodePtr = it.Next()) != nullptr) {
        Node* nextNode = *nextNodePtr;
        if (nextNode != nullptr && nextNode->GetCount() < num) {
            break;
        }

        nodePtr = nextNodePtr;
    }

    node = *nodePtr;
    idx = node->GetIndex();
    auto count = node->GetCount();

    node->UpdateNode(idx + num, count - num, refershRegionInfo);
    DecTotalCount(num);

    if (node->GetCount() == 0) {
        RemoveZeroNode(*nodePtr);
    } else {
        LowerNonZeroNode(*nodePtr);
    }

    CTREE_CHECK_PARENT_AND_LCHILD(*nodePtr);
    CTREE_CHECK_PARENT_AND_RCHILD(*nodePtr);

    return true;
}

// Best-fit with lowest-address tiebreaker (iterative).
CartesianTree::Node** CartesianTree::FindBestFitLowAddrPtr(Node** nodePtr, Count num, Node** best)
{
    LocalDeque<Node**> stack(sud);
    if (nodePtr != nullptr && *nodePtr != nullptr && (*nodePtr)->GetCount() >= num) {
        stack.Push(nodePtr);
    }

    while (!stack.Empty()) {
        Node** current = stack.Top();
        stack.Pop();

        if (current == nullptr || *current == nullptr || (*current)->GetCount() < num) {
            continue;
        }

        // Current node is a candidate (count >= num).
        // Prefer: (1) smallest count, (2) lowest index as tiebreaker.
        if (best == nullptr ||
            (*current)->GetCount() < (*best)->GetCount() ||
            ((*current)->GetCount() == (*best)->GetCount() &&
             (*current)->GetIndex() < (*best)->GetIndex())) {
            best = current;
        }

        // Exact fit found — only left subtree could have same count with lower address.
        if ((*best)->GetCount() == num) {
            Node** leftChild = &((*current)->l);
            if (*leftChild != nullptr && (*leftChild)->GetCount() >= num) {
                stack.Push(leftChild);
            }
        } else {
            // Search both subtrees for a tighter fit.
            Node** rightChild = &((*current)->r);
            if (*rightChild != nullptr && (*rightChild)->GetCount() >= num) {
                stack.Push(rightChild);
            }
            Node** leftChild = &((*current)->l);
            if (*leftChild != nullptr && (*leftChild)->GetCount() >= num) {
                stack.Push(leftChild);
            }
        }
    }

    return best;
}

// Best-fit allocation with lowest-address tiebreaker.
// Picks the node whose count is closest to num to avoid unnecessary splitting,
// breaking ties by lowest address to pack live data toward the low end.
bool CartesianTree::TakeUnitsLowAddrImpl(Count num, Index& idx, bool refreshRegionInfo)
{
    Node** nodePtr = FindBestFitLowAddrPtr(&root, num, nullptr);
    if (nodePtr == nullptr) {
        DLOG(REGION, "c-tree %p fail to take %u free units (best-fit-low-addr)", this, num);
        return false;
    }

    Node* node = *nodePtr;
    idx = node->GetIndex();
    auto count = node->GetCount();

    node->UpdateNode(idx + num, count - num, refreshRegionInfo);
    DecTotalCount(num);

    if (node->GetCount() == 0) {
        RemoveZeroNode(*nodePtr);
    } else {
        LowerNonZeroNode(*nodePtr);
    }

    return true;
}

bool CartesianTree::AllocateLowestAddressFromNode(Node*& node, Count count, Index& index)
{
    Count nodeCount = node->GetCount();
    if (nodeCount < count) {
        return false;
    }

    index = node->GetIndex();
    DLOG(REGION, "c-tree %p v-alloc %u units from [%u+%u, %u)", this, count, index, nodeCount, index + nodeCount);

    node->UpdateNode(index + count, nodeCount - count, false);
    DecTotalCount(count);
    if (node->GetCount() == 0) {
        RemoveZeroNode(node);
    } else {
        LowerNonZeroNode(node);
    }
    return true;
}
} // namespace MapleRuntime
