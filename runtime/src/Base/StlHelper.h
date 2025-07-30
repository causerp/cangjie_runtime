// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_BASE_STL_HELPER_H
#define MRT_BASE_STL_HELPER_H

#include <set>

namespace MapleRuntime {
struct FreeFunctor { // Helper function to free an element of container
    template<typename Pointer>
    void operator()(Pointer p) const
    {
        delete p;
    }
};

template<typename T>
void STLFreeAndClearContainer(T& functorContainer)
{
    std::for_each(functorContainer.begin(), functorContainer.end(), FreeFunctor());
    functorContainer.clear();
}
} // namespace MapleRuntime

#endif // MRT_BASE_STL_HELPER_H
