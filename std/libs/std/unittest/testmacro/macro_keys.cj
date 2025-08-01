/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.unittest.testmacro

import std.ast.*
import std.collection.*

let SUPPORTED_MACROS = ArrayList<MacroKey>()
let TEST_MACRO = MacroKey.create("@Test", ClassOrFunction, TestEntity, placement: TopLevel)
let TEST_BUILDER_MACRO = MacroKey.create("@TestBuilder", Function, TestEntity, conflicts: [TEST_MACRO],
    placement: TopLevel)
let TEST_TEMPLATE_MACRO = MacroKey.create("@TestTemplate", Class, TestEntity, conflicts: [TEST_MACRO],
    placement: TopLevel, allowedModifiers: [ABSTRACT])

// actual keys that are written to @Attribute section
let SKIP_MACRO = MacroKey.create("@Skip", ClassOrFunction, Configuration)
let TESTCASE_MACRO = MacroKey.create("@TestCase", Function, TestEntity,
    placement: InsideParent([TEST_MACRO, TEST_TEMPLATE_MACRO]))
let CONFIGURE_MACRO = MacroKey.create("@Configure", ClassOrFunction, Configuration, repeatable: true)
let TYPES_MACRO = MacroKey.create("@Types", ClassOrFunction, Configuration,
    conflicts: [TEST_BUILDER_MACRO, TEST_TEMPLATE_MACRO])
let TIMEOUT_MACRO = MacroKey.create("@Timeout", ClassOrFunction, Configuration)
let TAG_MACRO = MacroKey.create("@Tag", ClassOrFunction, Configuration, repeatable: true)
let MEASURE_MACRO = MacroKey.create("@Measure", ClassOrFunction, Configuration, repeatable: true, placement: TopLevel)
// @Test @Bench is allowed on top level func, we allow @Bench @TestCase on member function
let BENCH_MACRO = MacroKey.create("@Bench", Function, TestEntity)
let PARALLEL_MACRO = MacroKey.create("@Parallel", ClassOrFunction, Configuration,
    conflicts: [TEST_TEMPLATE_MACRO, TESTCASE_MACRO, BENCH_MACRO])
// lifecycle macros are only allowed on member functions that do not have any other macros
let BEFORE_EACH_MACRO = MacroKey.create("@BeforeEach", Function, Lifecycle,
    placement: InsideParent([TEST_MACRO, TEST_TEMPLATE_MACRO]))
let AFTER_EACH_MACRO = MacroKey.create("@AfterEach", Function, Lifecycle,
    placement: InsideParent([TEST_MACRO, TEST_TEMPLATE_MACRO]))
let BEFORE_ALL_MACRO = MacroKey.create("@BeforeAll", Function, Lifecycle,
    placement: InsideParent([TEST_MACRO, TEST_TEMPLATE_MACRO]))
let AFTER_ALL_MACRO = MacroKey.create("@AfterAll", Function, Lifecycle,
    placement: InsideParent([TEST_MACRO, TEST_TEMPLATE_MACRO]))

// assertion macro is only allowed on top-level functions that do not have any other macros
let ASSERTION_MACRO = MacroKey.create("@CustomAssertion", Function, Assertion, placement: TopLevel)

type Verifier = (MacroAttrs, Decl, MacroErrors) -> Unit

// NOTE: other rules related to mapping generic arguments and parsing @Types DSL are checked elsewhere
let TYPES_VERIFIER: Verifier = {
    _: MacroAttrs, decl: Decl, errors: MacroErrors =>
    if (!decl.isGenericDecl) {
        errors.add("${TYPES_MACRO} macro must be applied to a generic declaration.")
    }
}
let TEST_VERIFIER: Verifier = {
    _: MacroAttrs, decl: Decl, errors: MacroErrors =>
    match (decl) {
        case classDecl: ClassDecl where classDecl.superTypes.size > 1 =>
            errors.add("${TEST_MACRO} class can't have more than one template.")
        case _ => ()
    }
}
let TEST_TEMPLATE_VERIFIER: Verifier = {
    _: MacroAttrs, decl: Decl, errors: MacroErrors =>
    match (decl) {
        case classDecl: ClassDecl where
            !classDecl.modifiers.contains { it => it.keyword.kind == ABSTRACT } =>
            errors.add("${TEST_TEMPLATE_MACRO} should annotate abstract class.")
        case classDecl: ClassDecl where classDecl.superTypes.size > 1 =>
            errors.add("${TEST_TEMPLATE_MACRO} abstract class can't have more than one template.")
        case _ => ()
    }
}
let VERIFIERS = HashMap<MacroKey, Verifier>(
    (TYPES_MACRO, TYPES_VERIFIER),
    (TEST_MACRO, TEST_VERIFIER),
    (TEST_TEMPLATE_MACRO, TEST_TEMPLATE_VERIFIER),
)

enum MacroKind {
    | TestEntity // declares a runnable entity like a test class, test case function, benchmark etc
    | Configuration // configures an existing runnable entity
    | Lifecycle // controls lifecycle and cannot have any other annotations apart from other lifecycle annotations
    | Assertion // registers custom assertion function and prevents other annotations being put
}

enum MacroPlacement {
    | Anywhere // can be placed anywhere
    | TopLevel // can be placed only on top level
    | InsideParent(Array<MacroKey>) // only inside one of the given parents

    public prop canBeTopLevel: Bool {
        get() {
            if (let InsideParent(_) <- this) {
                false
            } else {
                true
            }
        }
    }

    public func formatError(k: MacroKey): String {
        match (this) {
            case TopLevel =>
                "${k} can only be placed on top-level ${k.allowedTarget}."
            case InsideParent(parentKeys) =>
                let targetsFormat = match (parentKeys.size) {
                    case 0 => "nothing"
                    case 1 => parentKeys[0].toString()
                    case 2 => "${parentKeys[0]} or ${parentKeys[1]}"
                    case _ =>
                        let tail = parentKeys[1..] |> collectString<MacroKey>(delimiter: ", ")
                        "${tail}, or ${parentKeys[0]}"
                }
                "${k} must be used on a member of class annotated with ${targetsFormat}."
            case Anywhere => "" // no errors are expected for this placement
        }
    }
}

struct MacroKey <: ToString & Equatable<MacroKey> & Hashable {
    static let FORBIDDEN_MODIFIERS = [
        TokenKind.OPERATOR, TokenKind.SEALED, TokenKind.FOREIGN, TokenKind.ABSTRACT, TokenKind.UNSAFE, TokenKind.OPEN]

    private MacroKey(
        let macroName: String,
        let attrPrefix: String,
        let allowedTarget: MacroTarget,
        let repeatable: Bool,
        let kind: MacroKind,
        let conflicts: Array<MacroKey>,
        let placement: MacroPlacement,
        let allowedModifiers: Array<TokenKind>
    ) {}

    func write(decl: Tokens, args!: Tokens = Tokens()): Tokens {
        MacroStorage.saveAsAttribute(this, decl, args)
    }

    static func create(
        macroName: String,
        allowedTarget: MacroTarget,
        kind: MacroKind,
        repeatable!: Bool = false,
        conflicts!: Array<MacroKey> = [],
        placement!: MacroPlacement = Anywhere,
        allowedModifiers!: Array<TokenKind> = []
    ): MacroKey {
        let newKey = MacroKey(macroName, macroName.removePrefix("@") + "_", allowedTarget, repeatable, kind, conflicts, placement, allowedModifiers)
        SUPPORTED_MACROS.add(newKey)
        newKey
    }

    public func verifyDecl(decl: Decl) {
        let errors = MacroErrors()
        check(decl, errors, [], MacroAttrs())

        match (decl) {
            case classDecl: ClassDecl =>
                let attrs = MacroStorage.loadAllAttrs(decl)
                for (member in classDecl.body.decls) {
                    check(member, errors, [], attrs)
                }
            case _ => ()
        }
        errors.report()
    }

    public func toString(): String {
        macroName
    }

    private func isOfKind(thatKind: MacroKind): Bool {
        match ((this.kind, thatKind)) {
            case (TestEntity, TestEntity) => true
            case (Configuration, Configuration) => true
            case (Lifecycle, Lifecycle) => true
            case (Assertion, Assertion) => true
            case _ => false
        }
    }

    private func check(decl: Decl, errors: MacroErrors, implicitKeys: Array<MacroKey>, parentAttrs: MacroAttrs): Unit {
        let attrs = MacroStorage.loadAllAttrs(decl)
        for (key in implicitKeys) {
            attrs[key] = ArrayList<Tokens>()
        }
        if (attrs.isEmpty()) {
            return
        }
        checkAttrsApplicability(attrs, decl, errors)
        checkConflicts(attrs, errors)
        checkModifiers(attrs, decl, errors)
        checkPlacement(attrs, parentAttrs, errors)

        for (key in attrs.keys()) {
            if (let Some(verifier) <- VERIFIERS.get(key)) {
                verifier(attrs, decl, errors)
            }
        }
    }

    private static func checkAttrsApplicability(attrs: MacroAttrs, decl: Decl, errors: MacroErrors): Unit {
        for ((key, values) in attrs) {
            if (!key.allowedTarget.accepts(decl)) {
                errors.add("${key.macroName} macro can only be put on ${key.allowedTarget}.")
            }
            if (values.size > 1) {
                if (!key.repeatable) {
                    errors.add("${key.macroName} macro is not repeatable.")
                }
            }
        }
    }

    private static func checkConflicts(attrs: MacroAttrs, errors: MacroErrors): Unit {
        let entities = attrs.keys() |> filter { key: MacroKey => key.isOfKind(TestEntity) } |> collectArray
        if (entities.isEmpty()) {
            for ((key, _) in attrs where key.isOfKind(Configuration)) {
                errors.add("${key} macro must be used together with one of: ${allCompatibleEntities(key)}.")
            }
        }

        for (key1 in attrs.keys()) {
            for (key2 in attrs.keys() where key1.conflicts.contains(key2)) {
                errors.add("${key1} macro can't be used together with ${key2}.")
            }
        }

        let lifecycleKeys = attrs.keys() |> filter { it: MacroKey => it.isOfKind(Lifecycle) } |> collectArray
        let nonLifecycleKeys = attrs.keys() |> filter { it: MacroKey => !it.isOfKind(Lifecycle) } |> collectArray
        for (lifecycleKey in lifecycleKeys) {
            for (nonLifecycleKey in nonLifecycleKeys) {
                errors.add("${lifecycleKey} macro can't be used together with ${nonLifecycleKey}.")
            }
        }

        let assertionKeys = attrs.keys() |> filter { it: MacroKey => it.isOfKind(Assertion) } |> collectArray
        let nonAssertionKeysCount = attrs.keys() |> filter { it: MacroKey => !it.isOfKind(Assertion) } |> count

        if (assertionKeys.size != 0 && nonAssertionKeysCount != 0) {
            errors.add("${assertionKeys[0]} macro can't be used together with any other macro.")
        }
    }

    private func checkModifiers(attrs: MacroAttrs, decl: Decl, errors: MacroErrors) {
        for (modifier in decl.modifiers) {
            let kind = modifier.keyword.kind
            if (FORBIDDEN_MODIFIERS.containsKind(kind) && !allowedModifiers.containsKind(kind)) {
                let anyMacro = attrs.keys().iterator().next().getOrThrow()
                errors.add("${anyMacro} macro can't be used together with ${modifier.keyword.value} modifier.")
            }
        }
        if (let Some(funcDecl) <- (decl as FuncDecl)) {
            if (funcDecl.isAbstract()) {
                let anyMacro = attrs.keys().iterator().next().getOrThrow()
                errors.add("${anyMacro} macro can't annotate abstract function.")
            }
        }
    }

    private static func checkPlacement(attrs: MacroAttrs, parentAttrs: MacroAttrs, errors: MacroErrors) {
        for ((k, _) in attrs) {
            match (k.placement) {
                case TopLevel where !parentAttrs.isEmpty() =>
                    errors.add(k.placement.formatError(k))
                case InsideParent(parentKeys) =>
                    if (parentKeys |> none<MacroKey> { pkey => parentAttrs.contains(pkey) }) {
                        errors.add(k.placement.formatError(k))
                    }
                case _ => ()
            }
        }
    }

    private static func allCompatibleEntities(mustBeCompatible: MacroKey): String {
        let allOfKind = SUPPORTED_MACROS |>
            filter { it: MacroKey => it.isOfKind(TestEntity) && !it.conflictsWith(mustBeCompatible) } |>
            map  { it: MacroKey => it.toString() } |> collectArray
        String.join(allOfKind, delimiter: ", ")
    }

    public override operator func ==(that: MacroKey) {
        this.macroName == that.macroName
    }

    public override operator func !=(that: MacroKey) {
        this.macroName != that.macroName
    }

    public override func hashCode(): Int64 {
        this.macroName.hashCode()
    }

    private func conflictsWith(that: MacroKey) {
        this.conflicts.contains(that) || that.conflicts.contains(this)
    }

    static func allSupportedMacros(): Iterable<MacroKey> {
        SUPPORTED_MACROS
    }

    public prop macroIdentifier: String {
        get() { macroName.removePrefix("@") }
    }
}

enum MacroTarget <: ToString {
    | Class
    | Function
    | ClassOrFunction

    func accepts(decl: Decl): Bool {
        match ((this, decl)) {
            case (ClassOrFunction, f: FuncDecl) where !f.isConstructor => true
            case (Function, f: FuncDecl) where !f.isConstructor => true
            case (ClassOrFunction, _: ClassDecl) => true
            case (Class, _: ClassDecl) => true
            case _ => false
        }
    }

    public func toString(): String {
        match (this) {
            case Class => "class"
            case Function => "function"
            case ClassOrFunction => "class or function"
        }
    }
}

extend Decl {
    prop isConstructor: Bool {
        get() {
            this is PrimaryCtorDecl || this is FuncDecl && identifier.value == "init"
        }
    }
}

class MacroErrors {
    private let errors = HashSet<String>()

    func add(str: String): Unit {
        errors.add(str)
    }

    func report() {
        if (!errors.isEmpty()) {
            doThrow(errors.toArray())
        }
    }

    static func doThrow(lines: Array<String>): Nothing {
        throw MacroException(String.join(lines, delimiter: "\n"))
    }
}
