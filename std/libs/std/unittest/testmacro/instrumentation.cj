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

extend Tokens {
    func ifEmpty(default: Tokens): Tokens {
        if (this.size == 0) {
            default
        } else {
            this
        }
    }
}

class InstrumentedBench <: InstrumentedFunction {
    init(
        original: FuncDecl
    ) {
        super(
            original,
            prefix: "Bench"
        )
        let testCaseDslSize = original.loadSingle(TESTCASE_MACRO)?.size ?? 0
        if (testCaseDslSize > 0) {
            throw MacroException("For benchmarks only ${BENCH_MACRO} can contain strategies.")
        }

        let measurementInfo = Token(TokenKind.IDENTIFIER, "measurementInfo")
        configuration.add((measurementInfo, quote(m___.info) |> parseExpr))
    }

    public override func caseInitializerName(strategyVar: Tokens): Tokens {
        quote($strategyVar.intoBenchmark )
    }

    public func invocationLambda(funIdent: Tokens, argNames: Array<String>, argTypes: Array<Tokens>): Tokens {
        let namesTokens = argNames |> map{ x => Token(IDENTIFIER, x) } |> collectArray<Token>
        let reset = TokensBuilder()
        let get = TokensBuilder()

        for (i in 0..namesTokens.size) {
            let name = namesTokens[i]
            let ty = argTypes[i]
            reset.append(quote(
                var $name = ImmutableInputProvider<$ty>.createOrExisting($name)
                $name.reset(max___)
            ))
            get.append(quote(
                var $name = $name.get(q___)
            ))
        }

        let destructuring = nestedTuple(namesTokens).ifEmpty(quote(_))

        quote({ prov___, count___: Int64, max___: Int64 =>

                m___.setup()
                let $destructuring = prov___
                do {
                    $(reset.toTokens())
                    let tmp_ = m___.measure()
                    for (q___ in 0..max___) {
                        $(get.toTokens())
                        if (q___ < count___) {
                            $funIdent($(commaSeparated(namesTokens)))
                        }
                    }
                    return m___.measure() - tmp_
                } while (false)
                0.0
            })
    }

    public override func initCaseCode(tb!: TokensBuilder): TokensBuilder {
        tb.append(quote(for (m___ in m__))).curlyBraces { tb =>
            super.initCaseCode(tb: tb)
            ()
        }
    }
}

open class InstrumentedFunction {
    let original: FuncDecl
    var dataDSL: ArrayList<(String, Tokens)> = ArrayList()
    let types: Array<(String, Array<Tokens>)>
    let configuration: ArrayList<(Token, Expr)> = ArrayList()

    InstrumentedFunction(
        original: FuncDecl,
        let prefix!: String = ""
    ) {
        this.original = original

        this.configuration.add(all: loadFuncConfiguration(original))

        this.types = loadTypesDSL(original)

        this.dataDSL.add(all: parseDSLMacro(original.loadSingle(TESTCASE_MACRO)))
        // @Bench contains DSL if benchmarking
        this.dataDSL.add(all: parseDSLMacro(original.loadSingle(BENCH_MACRO)))
    }

    func isGeneric(): Bool {
        return this.original.isGenericDecl
    }

    func substitute(mapping: HashMap<String, Tokens>, code: Tokens): Tokens {
        let result = TokensBuilder()
        for (token in code) {
            if (token.kind == IDENTIFIER && mapping.contains(token.value)) {
                result.append(mapping[token.value])
            } else {
                result.append(token)
            }
        }
        return result.toTokens()
    }

    public open func caseInitializerName(strategyVar: Tokens): Tokens {
        quote( $strategyVar.intoUnitTestCase )
    }

    public open func invocationLambda(funIdent: Tokens, argNames: Array<String>, argTypes: Array<Tokens>): Tokens {
        let namesTokens = argNames |> map{ x => Token(IDENTIFIER, x) } |> collectArray<Token>
        let argType = nestedTuple(argTypes).ifEmpty(quote(Unit))
        let destructuring = nestedTuple(namesTokens).ifEmpty(quote(_))
        quote({ x___: $argType =>
                let $destructuring = x___
                $funIdent($(commaSeparated(namesTokens))); ()
            })
    }

    public func writeCaseTokens(
        funIdent: Tokens, funIdentName: String, caseName: String, argNames: Array<String>,
        argTypes: Array<Tokens>, tb!: TokensBuilder
    ): TokensBuilder {
        tb.scope { tb =>
            let configurationVariableName = Token(IDENTIFIER, "caseConfig")
            buildConfiguration(configuration.toArray(), configurationVariableName, tb)

            if (argTypes.isEmpty() && prefix == "") {
                simpleTestCase(funIdent, funIdentName, caseName, configurationVariableName, tb)
            } else {
                paramCase(funIdent, funIdentName, caseName, configurationVariableName, argNames, argTypes, tb)
            }
        }
        tb
    }

    func paramCase(
        funIdent: Tokens, funIdentName: String, caseName: String, configurationVariableName: Token,
        argNames: Array<String>, argTypes: Array<Tokens>, tb: TokensBuilder
    ) {
        let strategyVariableName = Token(IDENTIFIER, funIdentName + prefix + "DataStrategy")

        buildDataStrategy(dataDSL, argNames, argTypes, strategyVariableName, builder: tb)

        let lambda = invocationLambda(funIdent, argNames, argTypes)

        let initializer = caseInitializerName(strategyVariableName.toTokens())

        tb.append(quote(
            suiteBuilder.add(
                $initializer(
                    caseName: $caseName,
                    doRun: $lambda,
                    configuration: $configurationVariableName
                )
            )
        ))
    }

    private func simpleTestCase(
        funIdent: Tokens, funIdentName: String, caseName: String, configurationVariableName: Token, tb: TokensBuilder
    ) {
        let funcVariableName = Token(IDENTIFIER, funIdentName + "TestFunc")
        tb.append(quote(
            let $funcVariableName = {=> $funIdent(); () }
            suiteBuilder.add(
                UnitTestCase.create(
                    $caseName,
                    configuration: $configurationVariableName,
                    body: $funcVariableName
                )
            )
        ))
    }

    /**
     * @param funIdent: Tokens -- function name with full suffix (e.g. type arguments): id, foo<String>
     * @param funIdentName: String -- unique identifier for test case (new for each set of type parameters)
     * @param caseName: String -- displayable name for report
     * @param typeArgs: Collection<Tokens> -- type arguments for function, empty if function is not generic
     * @param tb: TokensBuilder -- builder to write code to
     */
    func initSingleCaseCode(
        funIdent: Tokens, funIdentName: String, caseName: String,
        typeArgs!: Collection<Tokens> = [], tb!: TokensBuilder = TokensBuilder()
    ) {
        let funParams = original.funcParams
        let originalTypeParams = getGenericParams(original)

        let typeMapping = originalTypeParams |>
            map<Token, String> { it => it.value } |>
            zip<String, Tokens>(typeArgs) |>
            collectHashMap

        let argNames = funParams |>
            map<FuncParam, String> { it => it.identifier.value } |>
            collectArray
        let argTypes = funParams |>
            map<FuncParam, Tokens> { it => substitute(typeMapping, it.paramType.toTokens()) } |>
            collectArray

        writeCaseTokens(funIdent, funIdentName, caseName, argNames, argTypes, tb: tb)
        return tb
    }

    public open func initCaseCode(tb!: TokensBuilder): TokensBuilder {
        let funIdent: Token = original.identifier
        let funIdentName: String = funIdent.value
        if (!isGeneric()) {
            initSingleCaseCode(funIdent.toTokens(), funIdentName, funIdentName, tb: tb)
        } else {
            let genericArgs = getGenericParams(original)
            let typeSubst = HashMap(this.types)
            let counter = Box(0)
            let genericArgsArray = collectArray(genericArgs)
            walkTypeParameters(genericArgsArray, typeSubst, ArrayList<Tokens>()) { combination =>
                let funCode = funIdent + quote(<$(commaSeparated(combination))>)
                let caseId = "${funIdent.value}${counter.value}"
                initSingleCaseCode(funCode, caseId, typesToString(funCode), typeArgs: combination, tb: tb)
                counter.value++
            }
            // we first walk the type arguments, and then check type substitution
            // because if there are problems with both, missing arguments are more important
            checkTypeSubstitution(genericArgsArray, typeSubst)
            tb
        }
    }

    public func toTokens() {
        original.toTokens()
    }
}

struct ClassDescriptor {
    ClassDescriptor(
        let className!: Token, let modifiers!: Tokens, let members!: ArrayList<Decl>,
        let inject!: Array<Tokens>, let superTypes!: Array<Tokens>
    ) {}

    init(decl: ClassDecl) {
        className = decl.identifier
        modifiers = filterModifiers(decl.modifiers.toTokens())
        members = decl.body.decls
        inject = []
        superTypes = decl.superTypes |>
            map { it: TypeNode => it.toTokens() } |>
            collectArray
    }

    prop isTestTemplate: Bool {
        get() {
            modifiers.contains { modifier => modifier.kind == ABSTRACT }
        }
    }

    private static func filterModifiers(modifiers: Tokens): Tokens {
        let result = ArrayList<Token>()
        for (modifier in modifiers) {
            match (modifier.kind) {
                case PUBLIC => () // XXX: this is current behaviour, we just mimic that
                case _ => result.add(modifier)
            }
        }
        return Tokens(result)
    }
}

class InstrumentedClass {
    InstrumentedClass(
        let original: ClassDescriptor,
        let configuration: Array<(Token, Expr)>,
        let testFunctions: ArrayList<InstrumentedFunction>,
        let typeParameters: Tokens,
        let genericConstraints: ArrayList<GenericConstraint>,
        let types: Array<(String, Array<Tokens>)>,
        let measurements: Array<Expr>
    ) {}

    init(original: ClassDecl) {
        this.original = ClassDescriptor(original)
        this.configuration = loadClassConfiguration(original)
        this.measurements = loadMeasurements(original)

        this.testFunctions = ArrayList()

        this.typeParameters = getGenericParams(original)
        this.genericConstraints = original.genericConstraint

        this.types = loadTypesDSL(original, typeParameters)

        this.instrumentClassItems(original.body.decls)
    }

    init(original: FuncDecl, dslTokens: Tokens, originalTokens!: Tokens) {
        let className = Token(IDENTIFIER, "TestCase_" + original.identifier.value)
        let fakeClass = ClassDescriptor(className: className, modifiers: Tokens(), members: ArrayList<Decl>(), inject: [originalTokens], superTypes: [])
        this.original = fakeClass

        this.configuration = loadFuncConfiguration(original)
        this.measurements = loadMeasurements(original)

        // a generic @Test-annotated function will produce a non-generic class with a generic function inside
        this.genericConstraints = ArrayList<GenericConstraint>()
        this.typeParameters = Tokens()
        this.types = []

        this.testFunctions = ArrayList()

        this.instrumentClassItems([original])

        if (this.testFunctions.isEmpty()) {
            let test = InstrumentedFunction(original)
            test.dataDSL.add(all: parseDSLMacro(dslTokens))
            this.testFunctions.add(test)
        } else if (dslTokens.size > 0) {
            throw MacroException("For benchmarks only ${BENCH_MACRO} can contain strategies.")
        }
    }

    private prop hasBenchmarks: Bool {
        get() {
            testFunctions |> any<InstrumentedFunction> { foo => foo is InstrumentedBench }
        }
    }

    private func instrumentClassItems(items: Iterable<Decl>) {
        for (decl in items) {
            let funcDecl = decl as FuncDecl ?? continue
            if (funcDecl.isConstructor) {
                continue
            }

            if (funcDecl.has(TESTCASE_MACRO)) {
                testFunctions.add(InstrumentedFunction(funcDecl))
            }
            if (funcDecl.has(BENCH_MACRO)) {
                testFunctions.add(InstrumentedBench(funcDecl))
            }
        }
    }

    static func fromDecl(macroKey: MacroKey, decl: Decl, originalTokens: Tokens): InstrumentedClass {
        // checking that 'annotation style' macros are applied correctly, in particular:
        //     - they have correct target
        //     - are not repeated unless it is allowed
        //     - they are combined correctly
        // the following is checked separately:
        //     - everything related to @Test and @TestTemplate macros
        //     - particular DSLs in corresponding macros
        let dslTokensList = decl.loadRepeatable(macroKey)
        let dslTokens: Tokens = match (dslTokensList.size) {
            case 0 => throw MacroException("No ${macroKey} macro used with ${decl.identifier.value}")
            case 1 => dslTokensList[0]
            case _ => throw MacroException("${macroKey} macro is not repeatable")
        }
        match (decl) {
            case decl: ClassDecl =>
                if (dslTokens.size > 0) {
                    throw MacroException("${macroKey} macro on class does not support parameters")
                }
                InstrumentedClass(decl)
            case decl: FuncDecl =>
                InstrumentedClass(decl, dslTokens, originalTokens: originalTokens)
            case _ => throw MacroException("${macroKey} macro can only be put on class or top level function.")
        }
    }

    func buildConfigurationFunc(tb: TokensBuilder): TokensBuilder {
        tb.append(quote(private func classConfiguration(): Configuration)).curlyBraces { tb =>
            let varName = Token(IDENTIFIER, "configuration")
            buildConfiguration(this.configuration, varName, tb).append(NL)
            tb.append(quote(return $varName)).append(NL)
        }
    }

    private func buildRegistrationFunction(tb: TokensBuilder, classId: Token): TokensBuilder {
        let className = classId.value
        let registerFuncId = Token(IDENTIFIER, "register" + className)
        let extensionInterface = Token(IDENTIFIER, "TestPackageExtension_" + className)
        if (typeParameters.size == 0) {
            tb.append(quote(
                interface $extensionInterface {
                    func $registerFuncId(): Unit
                }
                extend TestPackage <: $extensionInterface {
                    @Attribute[TEST_REGISTER]
                    public func $registerFuncId() {
                        registerSuite({ => $classId().asTestSuite() })
                    }
                }
            ))
        } else {
            tb.append(quote(
                interface $extensionInterface {
                    func $registerFuncId(): Unit
                }
                extend TestPackage <: $extensionInterface {
                    @Attribute[TEST_REGISTER]
                    public func $registerFuncId() {
            ))
            let genericArgs = this.typeParameters
            let arrayArg = collectArray(genericArgs)
            let typeSubst = HashMap(this.types)
            walkTypeParameters(arrayArg, typeSubst, ArrayList<Tokens>()) { combination =>
                let fullId = quote($classId<$(commaSeparated(combination))>)
                let fullName = typesToString(fullId)
                tb.append(quote(
                    registerSuite({ => TestSuite.builder($fullId().asTestSuite()).setName($fullName).build() })
                ))
                tb.append(NL)
            }
            // we first walk the type arguments, and then check type substitution
            // because if there are problems with both, missing arguments are more important
            checkTypeSubstitution(arrayArg, typeSubst)
            tb.append(quote(
                    }
                }
            ))
            tb
        }
    }

    private func buildConstructor<Id, ParamList>(
        tb: TokensBuilder,
        id: Id,
        paramList: ParamList,
        body: ArrayList<Node>
    ): TokensBuilder where Id <: ToTokens, ParamList <: ToTokens {
        tb.append(id).append(paramList).curlyBraces { tb =>
            if (!body.isEmpty()) {
                tb.append(body).append(NL)
            }
        }
    }

    private func buildCheckInheritingTemplate(superTypes: Array<Tokens>, tb: TokensBuilder): TokensBuilder {
        // Naming instructs user to place @TestTemplate.
        tb.append(quote(private func inheritedFromClassAnnotatedByTestTemplate<T>(): TestSuite where T <: TestClass)).curlyBraces { tb =>
            if (!superTypes.isEmpty()) {
                tb.append(quote(super.asTestSuite())).append(NL)
            } else {
                tb.append(quote(throw Exception("Unreachable code"))).append(NL)
            }
        }
    }

    private func buildAsTestSuiteFunction(bodyDecls: ArrayList<Decl>, tb: TokensBuilder): TokensBuilder {
        let openness = if (original.isTestTemplate) { quote(open) } else { quote() }
        tb.append(quote(public $openness override func asTestSuite(): TestSuite)).curlyBraces { tb =>
            let className = Token(STRING_LITERAL, original.className.value)
            tb.append(
                quote(
                    let suiteConfiguration = classConfiguration()
                    let suiteBuilder = TestSuite.builder($className).configure(suiteConfiguration)
                )
            )

            if (hasBenchmarks) {
                tb.append(quote(let m__: Array<Measurement> = $(arrayLiteral(measurements)) )).append(NL)
            }

            for (fun in testFunctions) {
                fun.initCaseCode(tb: tb).append(NL)
            }

            match (this.original.superTypes.size) {
                case 0 => ()
                case 1 =>
                    let templateType = this.original.superTypes[0]
                    tb.append(quote(suiteBuilder.template(inheritedFromClassAnnotatedByTestTemplate<$templateType>()))).append(NL)
                case n => throw Exception("A test class can have only one template, got ${n}")
            }

            LifecycleStages.registerLifecycleStages(bodyDecls, tb)
            tb.append(quote(return suiteBuilder.build())).append(NL)
        }
    }

    private func transformBodyDecl(
        tb: TokensBuilder,
        bodyDecl: Decl,
        hasDefaultConstructor: Box<Bool>,
        numConstructors: Box<Int64>
    ): TokensBuilder {
        match (bodyDecl) {
            case pc: PrimaryCtorDecl =>
                let pcIdent: Token = pc.identifier
                let paramList = Tokens()
                    .append(Token(TokenKind.LPAREN))
                    .append(pc.funcParams.toTokens())
                    .append(Token(TokenKind.RPAREN))
                if (pc.funcParams.isEmpty()) {
                    hasDefaultConstructor.value = true
                }
                let body = pc.block.nodes
                buildConstructor(tb, pcIdent, paramList, body)
                numConstructors.value++
            case cons: FuncDecl where cons.isConstructor =>
                let modifiers: Tokens = cons.modifiers.toTokens()
                let body = cons.block.nodes
                let paramList = Tokens()
                    .append(Token(TokenKind.LPAREN))
                    .append(cons.funcParams.toTokens())
                    .append(Token(TokenKind.RPAREN))
                if (cons.funcParams.isEmpty()) {
                    hasDefaultConstructor.value = true
                }
                buildConstructor(tb, modifiers + quote(init), paramList, body)
                numConstructors.value++
            case funcDecl: FuncDecl => LifecycleStages.transformFunction(funcDecl, tb)
            // temporary solution until insideParentContext("Test") is fixed on cjvm
            case varDecl: VarDecl where varDecl.getAttrs().size >= 1 && varDecl.getAttrs()[0].value == "Strategy" =>
                tb.append(quote(
                    $(varDecl.modifiers) prop $(varDecl.identifier) : $(varDecl.declType) { get() {
                        $varDecl
                        $(varDecl.identifier)
                    }}
                ))
            case _ => tb.append(bodyDecl).append(NL)
        }
        return tb
    }

    public func toTokens(): Tokens {
        let tb = TokensBuilder()
        var ident: Token = original.className
        let modifiers: Tokens = original.modifiers
        let body: ArrayList<Decl> = original.members
        let hasDefaultConstructor = Box(false)

        MacroStorage.markTestGenerated(tb)

        tb.append(modifiers).append(quote(class)).append(ident)
        if (this.typeParameters.size != 0) {
            tb.append(TokenKind.LT).append(commaSeparated(this.typeParameters)).append(TokenKind.GT)
        }

        tb.append(quote(<:))
        for (superType in this.original.superTypes) {
            tb.append(quote($superType &))
        }
        tb.append(quote(TestClass))

        if (!this.genericConstraints.isEmpty()) {
            tb.append(commaSeparated(this.genericConstraints))
        }
        tb.curlyBraces { tb =>
            let numConstructors = Box(0)

            for (bodyDecl in body) {
                transformBodyDecl(tb, bodyDecl, hasDefaultConstructor, numConstructors)
            }

            if (numConstructors.value == 0) {
                buildConstructor(tb, quote(init), quote(()), ArrayList<Node>())
                hasDefaultConstructor.value = true
            }

            buildConfigurationFunc(tb)

            buildAsTestSuiteFunction(body, tb)

            buildCheckInheritingTemplate(this.original.superTypes, tb)
        }

        for (inj in original.inject) {
            tb.append(inj).append(NL)
        }

        // registration mechanism only applies to test classes that have default constructors
        // --test also checks this, so the only case where the opposite can happen is
        // when users manually construct test classes, in which case auto-registration doesn't apply
        if (hasDefaultConstructor.value && !this.original.isTestTemplate) {
            tb.append(NL)
            buildRegistrationFunction(tb, ident)
        }

        return tb.toTokens()
    }
}

func loadTypesDSL(original: ClassDecl, typeParameters: Tokens): Array<(String, Array<Tokens>)> {
    match (original.loadSingle(TYPES_MACRO)) {
        case None where typeParameters.size != 0 =>
            throw MacroException(
                "Generic class ${original.identifier.value} requires a @Types macro to set up generic arguments"
            )
        case None => []
        case Some(typeDSL) => parseTypesMacro(typeDSL)
    }
}

func loadTypesDSL(original: FuncDecl): Array<(String, Array<Tokens>)> {
    match (original.loadSingle(TYPES_MACRO)) {
        case None where original.isGenericDecl =>
            throw MacroException(
                "Generic function ${original.identifier.value} requires a @Types macro to set up generic arguments"
            )
        case None => []
        case Some(typeDSL) => parseTypesMacro(typeDSL)
    }
}

private func loadConfiguration(original: Decl, configs: ArrayList<(Token, Expr)>): Unit {
    for (configEntry in original.loadRepeatable(CONFIGURE_MACRO)) {
        configs.add(all: parseConfigurationMacro(configEntry))
    }
    if (original.has(SKIP_MACRO)) {
        let token = Token(TokenKind.IDENTIFIER, "skip")
        configs.add((token, parseExpr(quote(true))))
    }
    if (original.has(PARALLEL_MACRO)) {
        let token = Token(TokenKind.IDENTIFIER, "parallel")
        configs.add((token, parseExpr(quote(true))))
    }
    if (let Some(tokens) <- original.loadSingle(TIMEOUT_MACRO)) {
        let token = Token(TokenKind.IDENTIFIER, "timeout")
        configs.add((token, parseExpr(tokens)))
    }
    if (let Some(tokens) <- concatTagsMacro(original)) {
        let token = Token(TokenKind.IDENTIFIER, "tags")
        configs.add((token, parseExpr(tokens)))
    }
}

func loadClassConfiguration(original: Decl): Array<(Token, Expr)> {
    let configs = ArrayList<(Token, Expr)>()
    loadConfiguration(original, configs)
    configs.toArray()
}

func loadFuncConfiguration(original: FuncDecl) {
    let configs = ArrayList<(Token, Expr)>()
    loadConfiguration(original, configs)
    // Encountered top-level @Test function
    if (original.loadRepeatable(TEST_MACRO).size == 1) {
        let token = Token(TokenKind.IDENTIFIER, "fromTopLevel")
        configs.add((token, parseExpr(quote(true))))
    }
    configs.toArray()
}

private func concatTagsMacro(original: Decl): ?Tokens {
    let result = original.loadRepeatable(TAG_MACRO) |>
        flatMap { tokens: Tokens =>
            let parser = DSLParser(Tokens(collectArray(tokens)))
            parser.parseBalancedDelimited(delimiter: TokenKind.COMMA, terminator: TokenKind.END) |>
                map { it: Tokens => return it[0].value }
        } |> collectHashSet

    if (result.size != 0) {
        return result.toArray().toTokens()
    }
    return None
}

private func loadMeasurements(original: Decl): Array<Expr> {
    if (original.has(MEASURE_MACRO)) {
        parseMeasurements(original.loadRepeatable(MEASURE_MACRO))
    } else {
        [quote(TimeNow()) |> parseExpr]
    }
}
