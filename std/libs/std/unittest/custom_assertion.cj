/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.collection.*
import std.unittest.common.*

enum PrettyTreeStruct <: PrettyPrintable {
    Leaf(AssertExpectCheckResult)
    | Node(String, ArrayList<PrettyTreeStruct>)

    public func pprint(pp: PrettyPrinter): PrettyPrinter {
        let pt = PrettyTree()
        match (this) {
            case Leaf(aecr) =>
                match (aecr.kind) {
                    case Assert => pt.append("Assert Failed: ")
                    case Expect => pt.append("Expect Failed: ")
                }
                pt.append(aecr)
            case Node(s, ppbles) => appendNode(pt, s, ppbles)
        }
        pt.pprint(pp)
        return pp
    }

    private func appendNode(pt: PrettyTree, s: String, ppbles: ArrayList<PrettyTreeStruct>) {
        pt.appendLine(s)
        pt.indentWithPrefix("│   ") {
            let iterator = ppbles.iterator()
            var val: Option<PrettyTreeStruct> = iterator.next()
            while (let Some(ppble) <- val) {
                val = iterator.next()
                if (val.isNone()) {
                    pt.appendLastWithPrefix("└── ", ppble)
                } else {
                    pt.appendWithPrefix("├── ", ppble)
                }
            }
        }
    }
}

/**
 * Wrapper for PrettyText to write nice trees
 */
private class PrettyTree <: PrettyPrinter & PrettyPrintable {
    let pt: PrettyText = PrettyText()

    private var treeIndent = ""
    private var needTreeIndent = false
    private let indentaions: ArrayList<String> = ArrayList([""])
    private var depth = 0

    protected override func put(s: String): Unit {
        if (needTreeIndent) {
            pt.put(treeIndent)
            needTreeIndent = false
        }
        pt.put(s)
    }
    protected override func setColor(color: Color): Unit {
        pt.setColor(color)
    }

    protected override func putNewLine(): Unit {
        if (needTreeIndent) {
            pt.put(treeIndent)
            needTreeIndent = false
        }
        pt.putNewLine()
        needTreeIndent = true
    }

    /**
     * Recollect current prefix
     */
    private prop prefix: String {
        get() {
            let sb = StringBuilder()
            for (i in indentaions) {
                sb.append(i)
            }
            sb.toString()
        }
    }

    /**
     * Recollect current prefix without last indent
     */
    private prop prefixNoLast: String {
        get() {
            let sb = StringBuilder()
            for (i in indentaions |> take(indentaions.size - 1)) {
                sb.append(i)
            }
            sb.toString()
        }
    }

    /**
     * Store indented prefix in array and execute nested printers
     * Remove indented prefix in the end
     */
    public func indentWithPrefix(prefix: String, body: () -> Unit): PrettyTree {
        indentaions.add(prefix)
        treeIndent = this.prefix
        depth += 1
        try {
            body()
        } finally {
            depth -= 1
            treeIndent = this.prefixNoLast
            indentaions.remove(at: indentaions.size - 1)
        }
        return this
    }

    /*
     * Prints line, replacing last indent with the specified one
     */
    public func appendWithPrefix(prefix: String, text: String): PrettyTree {
        if (needTreeIndent) {
            needTreeIndent = false
            put(this.prefixNoLast + prefix)
        }
        put(text)
        return this
    }

    /**
     * Prints line, replacing last indent with the specified one
     * Replaces finished indent prefix with whitespaces
     */
    public func appendLastWithPrefix(prefix: String, text: String): PrettyTree {
        if (needTreeIndent) {
            needTreeIndent = false
            put(this.prefixNoLast + prefix)
        }
        put(text)
        indentaions[depth] = " " * indentaions[depth].size
        treeIndent = this.prefix
        return this
    }

    /*
     * Prints PrettyPrintable, replacing last indent with the specified one
     */
    public func appendWithPrefix<PP>(prefix: String, value: PP): PrettyTree where PP <: PrettyPrintable {
        if (needTreeIndent) {
            needTreeIndent = false
            put(this.prefixNoLast + prefix)
        }
        value.pprint(this)
        return this
    }

    /**
     * Prints PrettyPrintable, replacing last indent with the specified one
     * Replaces finished indent prefix with whitespaces
     */
    public func appendLastWithPrefix<PP>(prefix: String, value: PP): PrettyPrinter where PP <: PrettyPrintable {
        if (needTreeIndent) {
            needTreeIndent = false
            put(this.prefixNoLast + prefix)
        }
        indentaions[depth] = " " * indentaions[depth].size
        treeIndent = this.prefix
        value.pprint(this)
        return this
    }

    public func pprint(pp: PrettyPrinter): PrettyPrinter {
        pt.pprint(pp)
        return pp
    }
}

/**
 * Assertion context base class
 *
 * If user wants to create custom assertion he must:
 * 1. Annotate function with @CustomAssertion
 * 2. Provide `AssertionCtx` as it's FIRST parameter in function parameters list
 */
public class AssertionCtx {
    private let _stringArgs: String
    // Mapping between funcion parameter names and unresolved function call arguments
    private var _argsMap: ?HashMap<String, String> = None
    // List for stacktrace of inner assertions
    let _errors: ArrayList<PrettyTreeStruct> = ArrayList()

    protected AssertionCtx(
        // Raw passed arguments, provided to function
        private let _passedArgs!: Array<String> = [],
        // Stores the assertion function which this context was built for
        private let _caller!: String = String.empty
    ) {
        _stringArgs = _passedArgs |> collectString<String>(delimiter: ", ")
    }

    public prop caller: String {
        get() {
            _caller
        }
    }

    /**
     * Says whether any error occured during run of assertion
     */
    public prop hasErrors: Bool {
        get() {
            return !_errors.isEmpty()
        }
    }

    /**
     * Unresolved passed arguments getter
     *
     * @param key: String - if matches with value of argument identifier in function declaration, return unresolved argument
     */
    public func arg(key: String): String { return _argsMap?[key] ?? "<${key} not found>" }

    /**
     * Comma-separated string of arguments
     */
    public prop args: String {
        get() {
            return _stringArgs
        }
    }

    /**
     * Specifies names for accessing unresolved values
     *
     * @param aliases: Array<String> - String aliases for each argument in function declaration.
     *                                 Length of provided array should match with size of paramenter list
     */
    public func setArgsAliases(aliases: Array<String>) {
        _argsMap = aliases.iterator().zip(_passedArgs.iterator()) |> collectHashMap
    }

    /**
     * Stores FailCheckResult in local stacktrace
     *
     * @throws AssertException
     */
    public func fail(message: String): Nothing {
        let checkResult = FailCheckResult(Assert, message)
        _errors.add(Leaf(checkResult))
        throw AssertException("", checkResult)
    }

    /**
     * Stores CustomCheckResult in local stacktrace
     *
     * @throws AssertException
     */
    public func fail<PP>(pt: PP): Nothing where PP <: PrettyPrintable {
        let checkResult = CustomCheckResult(Assert, PrettyText.of(pt))
        _errors.add(Leaf(checkResult))
        throw AssertException("", checkResult)
    }

    public func failExpect(message: String): Unit {
        let checkResult = FailCheckResult(Expect, message)
        _errors.add(Leaf(checkResult))
    }

    /**
     * Stores CustomCheckResult in local stacktrace
     */
    public func failExpect<PP>(pt: PP): Unit where PP <: PrettyPrintable {
        let checkResult = CustomCheckResult(Expect, PrettyText.of(pt))
        _errors.add(Leaf(checkResult))
    }
}

/**
 * If any of nested @Expect have failed, raises AssertException
 */
private func runAssert<T>(ctx: AssertionCtx, assert: (AssertionCtx) -> T): T {
    let result = assert(ctx)
    if (ctx.hasErrors) {
        throw AssertException("")
    }
    return result
}

/**
 * If any of nested @Assert threw an expection, suppresses those
 */
private func runExpect(ctx: AssertionCtx, expect: (AssertionCtx) -> Any): Unit {
    try {
        expect(ctx)
    } catch (e: AssertException) {
    }
}

/**
 * Runs custom assertion specified by @Assert[caller](passedArgs) inside of @Test/@TestCase functions
 *
 * Used by framework and not considered to be called by end user
 *
 * @param passedArgs:   Array<String>       - unresolved passed arguments
 * @param caller:       String              - name of called custom assertion with generic parameters if such specified
 * @param assert:       (AssertionCtx) -> T - capture of invocation of assertion with right arguments
 * @param optParentCtx: ?AssertionCtx       - first argument of @CustomAssertion function
 *
 * @throws AssertException if any occured in nested checks
 */
public func invokeCustomAssert<T>(passedArgs: Array<String>, caller: String, assert: (AssertionCtx) -> T,
    optParentCtx!: ?AssertionCtx = None): T {
    let ctx: AssertionCtx = AssertionCtx(_passedArgs: passedArgs, _caller: caller)

    let result: Option<T> = try {
        runAssert(ctx, assert)
    } catch (e: AssertException) {
        if (let Some(parentCtx) <- optParentCtx) {
            parentCtx._errors.add(Node(
                "@Assert[${caller}](${ctx.args}):",
                ctx._errors
            ))
            throw e
        }
        None
    }

    if (let Some(value) <- result) {
        Framework.withCurrentContext{ ctx: RunContext => ctx.checkPassed() }
        return value
    }

    let pt = PrettyText.of(Node(
        "@Assert[${caller}](${ctx.args}):",
        ctx._errors
    ))
    let checkResult = CustomCheckResult(Assert, PrettyText.of(pt))
    Framework.withCurrentContext{ ctx: RunContext => ctx.checkFailed(checkResult) }
    throw AssertException("", checkResult)
}

/**
 * Runs custom assertion specified by @Assert[caller](passedArgs) inside of @Test/@TestCase functions
 *
 * Used by framework and not considered to be called by end user
 *
 * @param passedArgs:   Array<String>         - unresolved passed arguments
 * @param caller:       String                - name of called custom assertion with generic parameters if such specified
 * @param expect:       (AssertionCtx) -> Any - capture of invocation of assertion with right arguments
 * @param optParentCtx: ?AssertionCtx         - first argument of @CustomAssertion function
 */
public func invokeCustomExpect(passedArgs: Array<String>, caller: String, expect: (AssertionCtx) -> Any,
    optParentCtx!: ?AssertionCtx = None): Unit {
    let ctx: AssertionCtx = AssertionCtx(_passedArgs: passedArgs, _caller: caller)

    runExpect(ctx, expect)

    if (let Some(parentCtx) <- optParentCtx) {
        if (ctx.hasErrors) {
            parentCtx._errors.add(Node(
                "@Expect[${caller}](${ctx.args}):",
                ctx._errors
            ))
        }
    } else {
        if (ctx.hasErrors) {
            let pt = PrettyText.of(Node(
                "@Expect[${caller}](${ctx.args}):",
                ctx._errors
            ))
            let checkResult = CustomCheckResult(Expect, PrettyText.of(pt))
            Framework.withCurrentContext{ ctx: RunContext => ctx.checkFailed(checkResult) }
        } else {
            Framework.withCurrentContext{ ctx: RunContext => ctx.checkPassed() }
        }
    }
}
