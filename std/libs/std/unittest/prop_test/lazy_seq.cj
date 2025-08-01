/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.prop_test

/**
 * We have to implement our own custom collections due to
 * Cangjie issues #2725
 **/

/**
 * LazyNode is a node of a single-linked lazily computed list of type T
 * @see LazySeq
 */
class LazyNode<T> {
    /* First element of the sequence */
    public let head: T

    /* Lazily computed other elements of the sequence */
    /*package-private*/ var lazyTail: Lazy<LazyNode<T>>

    /* We expose tail as a property for easier access */
    public prop tail: ?LazyNode<T> {
        get() {
            lazyTail.get()
        }
    }
    /* Create a sequence starting with `head` and continuing with `tail` */
    init(head: T, tail: () -> ?LazyNode<T>) {
        this.head = head
        this.lazyTail = Lazy(tail)
    }

    /* Create a sequence starting with `head` and continuing with `tail` */
    init(head: T, tail: Lazy<LazyNode<T>>) {
        this.head = head
        this.lazyTail = tail
    }

    /* Create a sequence containing only `head` */
    init(head: T) {
        this.head = head
        this.lazyTail = Lazy()
    }

    /* concatenation of two sequences */
    func concat(other: ?LazyNode<T>): LazyNode<T> {
        LazyNode<T>(head) {
            tail?.concat(other) ?? other
        }
    }

    /* mix: return a sequence which elements are a mix between elements of this and other */
    func mixWith(other: ?LazyNode<T>): LazyNode<T> {
        LazyNode<T>(head) {
            match (other) {
                case Some(that) => that.mixWith(tail)
                case None => tail
            }
        }
    }

    /**
     * a cycled version of this sequence (dangerous: this will iterate infinitely!)
     */
    func cycle(): LazyNode<T> {
        let result = LazyNode<T>(head)
        result.lazyTail = Lazy {
            tail?.concat(result)
        }
        result
    }

    /* mix: return a sequence which elements are a mix between elements of l1 and l2 */
    static func mix(l1: ?LazyNode<T>, l2: ?LazyNode<T>): Lazy<LazyNode<T>> {
        match (l1) {
            case Some(e1) => Lazy { e1.mixWith(l2) }
            case None => Lazy { l2 }
        }
    }

    /* mix: return a sequence which elements are a mix between elements of l1, l2, l3 */
    static func mix(l1: ?LazyNode<T>, l2: ?LazyNode<T>, l3: ?LazyNode<T>): Lazy<LazyNode<T>> {
        match (l1) {
            case Some(n1) =>
                Lazy { LazyNode<T>(n1.head, LazyNode<T>.mix(l2, l3, n1.tail)) }
            case None => mix(l2, l3)
        }
    }

    /* mix: return a sequence which elements are a mix between elements of l1, l2, l3, l4 */
    static func mix(l1: ?LazyNode<T>, l2: ?LazyNode<T>, l3: ?LazyNode<T>, l4: ?LazyNode<T>): Lazy<LazyNode<T>> {
        match (l1) {
            case Some(n1) =>
                Lazy { LazyNode<T>(n1.head, LazyNode<T>.mix(l2, l3, l4, n1.tail)) }
            case None => mix(l2, l3, l4)
        }
    }

    /* mix: return a sequence which elements are a mix between elements of l1, l2, l3, l4, l5 */
    static func mix(l1: ?LazyNode<T>, l2: ?LazyNode<T>, l3: ?LazyNode<T>,
                    l4: ?LazyNode<T>, l5: ?LazyNode<T>): Lazy<LazyNode<T>> {
        match (l1) {
            case Some(n1) =>
                Lazy { LazyNode<T>(n1.head, LazyNode<T>.mix(l2, l3, l4, l5, n1.tail)) }
            case None => mix(l2, l3, l4, l5)
        }
    }

    /* Add an element to the beginning of this sequence, return new sequence  */
    func prepend(element: T): LazyNode<T> {
        LazyNode<T>(element, Lazy(this))
    }

    /* Apply `body` to each element of this sequence, return a sequence of results  */
    func map<U>(body: (T) -> U): LazyNode<U> {
        LazyNode<U>(body(head)) {
            tail?.map(body)
        }
    }

    /* Create a lazy sequence from an iterator: this may be used to memoize elements of some iterator */
    public static func ofIterator(iterable: Iterator<T>): Lazy<LazyNode<T>> {
        func proceed(iterator: Iterator<T>): Lazy<LazyNode<T>> {
            Lazy<LazyNode<T>> {
                match (iterator.next()) {
                    case Some(h) => LazyNode(h, proceed(iterator))
                    case None => None
                }
            }
        }
        proceed(iterable)
    }
}

/**
 * Iterator implementation for LazyNode
 */
class LazyNodeIterator<T> <: Iterator<T> {
    LazyNodeIterator(private var current: ?LazyNode<T>) {
    }

    /* get next element in sequence */
    public func next(): ?T {
        match (current) {
            case Some(node) =>
                current = node.tail
                node.head
            case _ => None
        }
    }
}

/*
 * A lazily computed sequence of values of type T.
 * Useful to compute and memoize values while iterating.
 * This is completely immutable and every operation produces a new sequence.
 * Implementation note: recursion is OK in most of the methods of this class
 * because it will not cause a stack overflow during iteration.
 */
public class LazySeq<T> <: Iterable<T> {
    private LazySeq(private var root: Lazy<LazyNode<T>>) {
    }

    /*
     * Construct a sequence from an iterable. This is private, use of() function instead
     */
    private init(iterable: Iterable<T>) {
        this.root = LazyNode.ofIterator(iterable.iterator())
    }

    /*
     * Construct a sequence from an iterable.
     * If the iterable is already a LazySeq, do not do anything to avoid producing unnesessary wrappers.
     */
    public static func of(iterable: Iterable<T>) {
        match (iterable) {
            case self: LazySeq<T> => self
            case _ => LazySeq(iterable)
        }
    }
    /*
     * Construct a sequence from an array.
     * A little bit optimized compared to the generic Iterable version.
     */
    public static func of(array: Array<T>) {
        var self = LazySeq<T>()
        var index = array.size - 1
        while (index >= 0) {
            self = self.prepend(array[index])
            index--
        }
        self
    }

    /**
     * Make a sequence of one element `element`
     */
    public init(element: T) {
        this.root = Lazy(LazyNode(element))
    }

    /**
     * Make an empty sequence
     */
    public init() {
        this.root = Lazy()
    }

    /**
     * Iterator implementation
     */
    public func iterator(): Iterator<T> {
        LazyNodeIterator(root.get())
    }

    /*
     * Append another sequence to this sequence
     * Note: this is actually O(1) because of laziness
     * @param `other` other sequence to append
     */
    public func concat(other: LazySeq<T>): LazySeq<T> {
        let newRoot = match (this.root.get()) {
            case None => return other
            case Some(root) =>
                Lazy { root.concat(other.root.get()) }
        }
        LazySeq(newRoot)
    }

    /*
     * Append an element to the beginning of this sequence
     */
    public func prepend(element: T): LazySeq<T> {
        LazySeq(Lazy(LazyNode(element, this.root)))
    }

    /*
     * Append an element to the end of this sequence
     */
    public func append(element: T): LazySeq<T> {
        concat(LazySeq<T>(element))
    }

    /*
     * Mix elements of this sequence with another sequence.
     * Example: {1,2,3,4}.mixWith({5,6,7}) -> {1,5,2,6,3,7,4}
     */
    public func mixWith(other: LazySeq<T>): LazySeq<T> {
        let newRoot = match (this.root.get()) {
            case None => return other
            case Some(root) => Lazy {root.mixWith(other.root.get())}
        }
        LazySeq(newRoot)
    }

    /*
     * Mix two sequences.
     * Example: mix({1,2,3,4}, {5,6,7}) -> {1,5,2,6,3,7,4}
     */
    public static func mix(l1: LazySeq<T>, l2: LazySeq<T>) {
        let newRoot = Lazy<LazyNode<T>>.flat {
            LazyNode<T>.mix(l1.root.get(), l2.root.get())
        }
        LazySeq(newRoot)
    }

    /*
     * Mix three sequences.
     */
    public static func mix(l1: LazySeq<T>, l2: LazySeq<T>, l3: LazySeq<T>) {
        let newRoot = Lazy<LazyNode<T>>.flat {
            LazyNode<T>.mix(l1.root.get(), l2.root.get(), l3.root.get())
        }
        LazySeq(newRoot)
    }

    /*
     * Mix four sequences.
     */
    public static func mix(l1: LazySeq<T>, l2: LazySeq<T>, l3: LazySeq<T>, l4: LazySeq<T>) {
        let newRoot = Lazy<LazyNode<T>>.flat {
            LazyNode<T>.mix(l1.root.get(), l2.root.get(), l3.root.get(), l4.root.get())
        }
        LazySeq(newRoot)
    }

    /*
     * Mix five sequences.
     */
    public static func mix(l1: LazySeq<T>, l2: LazySeq<T>, l3: LazySeq<T>, l4: LazySeq<T>, l5: LazySeq<T>) {
        let newRoot = Lazy<LazyNode<T>>.flat {
            LazyNode<T>.mix(l1.root.get(), l2.root.get(), l3.root.get(), l4.root.get(), l5.root.get())
        }
        LazySeq(newRoot)
    }

    /*
     * Apply a function to each element of this sequence, return the sequence of results.
     * Note: this is O(1) because of laziness
     */
    public func map<U>(body: (T) -> U): LazySeq<U> {
        let newRoot = Lazy<LazyNode<U>> {
            this.root.get()?.map(body)
        }
        LazySeq(newRoot)
    }
}
