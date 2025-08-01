/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.ast

import std.collection.ArrayList

public func parseDecl(input: Tokens, astKind!: String = ""): Decl {
    /* Get node info from flatbuffer */
    var node = try {
        match (astKind) {
            case "PrimaryCtorDecl" => unsafe {
                parse(
                    input,
                    {p: CPointer<UInt8> => return CJ_AST_ParsePrimaryConstructor(match (MACRO_OBJECT.get()) {
                        case Some(ptr) => ptr
                        case None => CPointer<Unit>()
                    }, p)}
                )
            }
            case "PropMemberDecl" => unsafe { parse(input, {p: CPointer<UInt8> => return CJ_AST_ParsePropMemberDecl(
                match (MACRO_OBJECT.get()) {
                    case Some(ptr) => ptr
                    case None => CPointer<Unit>()
                }, p)})
            }
            case _ => unsafe { parse(input, {p: CPointer<UInt8> => return CJ_AST_ParseDecl(match (MACRO_OBJECT.get()) {
                case Some(ptr) => ptr
                case None => CPointer<Unit>()
            }, p, CPointer<Int64>())}) }
        }
    } catch (e: Exception) {
        throw ParseASTException("\n" + e.message + "parsing decl error.")
    }

    /* Get decl info from flatbuffer */
    var astNode = generateDeclAST(node.GetRootAsDecl())
    return astNode
}

public func parseDeclFragment(input: Tokens, startFrom!: Int64 = 0): (Decl, Int64) {
    let (node, count) = unsafe {
        try {
            parseFragment(
                input,
                startFrom,
                {p: CPointer<UInt8>, sizeRef: CPointer<Int64> => return CJ_AST_ParseDecl(match (MACRO_OBJECT.get()) {
                    case Some(ptr) => ptr
                    case None => CPointer<Unit>()
                }, p, sizeRef)}
            )
        } catch (e: Exception) {
            throw ParseASTException("\n" + e.message + "parsing decl fragment error.")
        }
    }
    var astNode = generateDeclAST(node.GetRootAsDecl())
    return (astNode, count)
}

func generateDeclAST(declNode: Option<NodeFormat_Decl>): Decl {
    var decl = match (declNode) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var declBase = match (decl.GetBase()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var nodeBase = match (declBase.GetBase()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var astKind: String = nodeBase.GetAstKind()
    var astNode = match (astKind) {
        case "main_decl" => createMainDecl(decl, createDeclBase(Token(TokenKind.MAIN), declBase))
        case "func_decl" => createFuncDecl(decl, declBase)
        case "macro_decl" => createMacroDecl(decl, createDeclBase(Token(TokenKind.MACRO), declBase))
        case "class_decl" => createClassDecl(decl, createDeclBase(Token(TokenKind.CLASS), declBase))
        case "interface_decl" => createInterfaceDecl(decl, createDeclBase(Token(TokenKind.INTERFACE), declBase))
        case "extend_decl" => createExtendDecl(decl, createDeclBase(Token(TokenKind.EXTEND), declBase))
        case "enum_decl" => createEnumDecl(decl, createDeclBase(Token(TokenKind.ENUM), declBase))
        case "struct_decl" => createStrucDecl(decl, createDeclBase(Token(TokenKind.STRUCT), declBase))
        case "type_alias_decl" => createTypeAliasDecl(decl, declBase)
        case "primary_ctor_decl" => createPrimaryCtorDecl(decl, createDeclBase(Token(), declBase))
        case "var_decl" => createVarDecl(decl)
        case "var_with_pattern_decl" => createVarWithPatternDecl(decl)
        case "prop_decl" => createPropDecl(decl)
        case "macro_expand_decl" => createMacroExpandDecl(decl)
        case "func_param" => createFuncParam(decl)
        case _ => throw ParseASTException("Unsupported parse the decl node: ${astKind}.\n")
    }
    addPositionInfo(astNode, nodeBase)
    return astNode
}

func createDeclBase(keyWord: Token, declBase: NodeFormat_DeclBase): Decl {
    var annos: ArrayList<Annotation> = ArrayList<Annotation>()
    for (anno in declBase.GetAnnotations()) {
        annos.add(createAnnotation(anno))
    }
    var mods: ArrayList<Modifier> = ArrayList<Modifier>()
    for (mod in declBase.GetModifiers()) {
        mods.add(createModifier(mod))
    }
    var key = keyWord.addPosition(declBase.GetKeywordPos())
    var indentifier = Token(TokenKind.IDENTIFIER, declBase.GetIdentifier()).addPosition(declBase.GetIdentifierPos())
    var (param, constraint, constraintCommas, isGeneric) = generateGenericInfo(declBase.GetGeneric())
    var genericParam: Option<GenericParam> = param
    // Solve some special node
    if (keyWord.kind == TokenKind.EXTEND) {
        indentifier = Token()
    } else if (keyWord.kind == TokenKind.FUNC) {
        if (indentifier.value == "super") {
            key = Token(TokenKind.SUPER).addPosition(declBase.GetKeywordPos())
        }
        if (indentifier.value == "init") {
            key = Token(TokenKind.INIT).addPosition(declBase.GetKeywordPos())
        }
    }
    if ((indentifier.value == "~init")) {
        key = Token()
    }
    return Decl(annos, mods, key, indentifier, genericParam, constraint, constraintCommas, isGeneric)
}

func generateGenericInfo(generic: Option<NodeFormat_Generic>) {
    var param: Option<GenericParam> = createGenericParam(generic)
    var constraint = ArrayList<GenericConstraint>()
    var isGeneric = false
    let commas = Tokens()
    match (generic) {
        case Some(v) =>
            var flag = true
            isGeneric = true
            for (cons in v.GetGenericConstraints()) {
                constraint.add(createGenericConstraint(flag, cons))
                match (cons?.GetCommaPos()) {
                    case Some(position) where isValidPosition(position) => commas.append(
                        Token(TokenKind.COMMA).addPosition(position))
                    case _ => ()
                }
                flag = false
            }
        case None => ()
    }
    return (param, constraint, commas, isGeneric)
}

func createClassDecl(decl: NodeFormat_Decl, declNode: Decl): ClassDecl {
    var classDecl = match (decl.GetDeclAsClassDecl()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var up: Token = Token()
    if (isValidPosition(classDecl.GetUpperBoundPos())) {
        up = Token(TokenKind.UPPERBOUND).addPosition(classDecl.GetUpperBoundPos())
    }
    var superTypes: ArrayList<TypeNode> = ArrayList<TypeNode>()
    let bitands = Tokens()
    for (ty in classDecl.GetSuperTypes()) {
        superTypes.add(generateTypeAST(ty))
        match (ty?.GetBase()?.GetBitAndPos()) {
            case Some(position) where isValidPosition(position) => bitands.append(
                Token(TokenKind.BITAND).addPosition(position))
            case _ => ()
        }
    }
    var classbody = match (classDecl.GetBody()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var lcurl: Token = Token(TokenKind.LCURL).addPosition(classbody.GetLeftCurlPos())
    var declList = ArrayList<Decl>()
    var rcurl: Token = Token(TokenKind.RCURL).addPosition(classbody.GetRightCurlPos())
    for (dl in classbody.GetDecls()) {
        declList.add(generateDeclAST(dl))
    }
    return ClassDecl(declNode, up, superTypes, bitands, Body(lcurl, declList, rcurl))
}

func createStrucDecl(decl: NodeFormat_Decl, declNode: Decl): StructDecl {
    var strucDecl = match (decl.GetDeclAsStructDecl()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var up: Token = Token()
    if (isValidPosition(strucDecl.GetUpperBoundPos())) {
        up = Token(TokenKind.UPPERBOUND).addPosition(strucDecl.GetUpperBoundPos())
    }
    var superTypes: ArrayList<TypeNode> = ArrayList<TypeNode>()
    let bitands = Tokens()
    for (ty in strucDecl.GetSuperTypes()) {
        superTypes.add(generateTypeAST(ty))
        match (ty?.GetBase()?.GetBitAndPos()) {
            case Some(position) where isValidPosition(position) => bitands.append(
                Token(TokenKind.BITAND).addPosition(position))
            case _ => ()
        }
    }
    var structbody = match (strucDecl.GetBody()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var lcurl: Token = Token(TokenKind.LCURL).addPosition(structbody.GetLeftCurlPos())
    var declList = ArrayList<Decl>()
    var rcurl: Token = Token(TokenKind.RCURL).addPosition(structbody.GetRightCurlPos())
    for (dl in structbody.GetDecls()) {
        declList.add(generateDeclAST(dl))
    }
    return StructDecl(declNode, up, superTypes, bitands, Body(lcurl, declList, rcurl))
}

func createInterfaceDecl(decl: NodeFormat_Decl, declNode: Decl): InterfaceDecl {
    var interfaceDecl = match (decl.GetDeclAsInterfaceDecl()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var up: Token = Token()
    if (isValidPosition(interfaceDecl.GetUpperBoundPos())) {
        up = Token(TokenKind.UPPERBOUND).addPosition(interfaceDecl.GetUpperBoundPos())
    }
    var superTypes: ArrayList<TypeNode> = ArrayList<TypeNode>()
    let bitands = Tokens()
    for (ty in interfaceDecl.GetSuperTypes()) {
        superTypes.add(generateTypeAST(ty))
        match (ty?.GetBase()?.GetBitAndPos()) {
            case Some(position) where isValidPosition(position) => bitands.append(
                Token(TokenKind.BITAND).addPosition(position))
            case _ => ()
        }
    }
    var interfacebody = match (interfaceDecl.GetBody()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var lcurl: Token = Token(TokenKind.LCURL).addPosition(interfacebody.GetLeftCurlPos())
    var declList = ArrayList<Decl>()
    var rcurl: Token = Token(TokenKind.RCURL).addPosition(interfacebody.GetRightCurlPos())
    for (dl in interfacebody.GetDecls()) {
        declList.add(generateDeclAST(dl))
    }
    return InterfaceDecl(declNode, up, superTypes, bitands, Body(lcurl, declList, rcurl))
}

func createEnumDecl(decl: NodeFormat_Decl, declNode: Decl): EnumDecl {
    var em = match (decl.GetDeclAsEnumDecl()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var up: Token = Token()
    if (isValidPosition(em.GetUpperBoundPos())) {
        up = Token(TokenKind.UPPERBOUND).addPosition(em.GetUpperBoundPos())
    }
    var superTypes: ArrayList<TypeNode> = ArrayList<TypeNode>()
    let bitands = Tokens()
    for (ty in em.GetSuperInterfaceTypes()) {
        superTypes.add(generateTypeAST(ty))
        match (ty?.GetBase()?.GetBitAndPos()) {
            case Some(position) where isValidPosition(position) => bitands.append(
                Token(TokenKind.BITAND).addPosition(position))
            case _ => ()
        }
    }
    var lcurl: Token = Token(TokenKind.LCURL).addPosition(em.GetLeftCurlPos())
    var bitors: Tokens = Tokens()
    for (pos in em.GetBitOrPosVec()) {
        bitors.append(Token(TokenKind.BITOR).addPosition(pos))
    }
    var constructors = ArrayList<Constructor>()
    for (cst in em.GetConstructors()) {
        constructors.add(createConstructor(cst))
    }
    var members = ArrayList<Decl>()
    for (mem in em.GetMembers()) {
        members.add(generateDeclAST(mem))
    }
    var rcurl: Token = Token(TokenKind.RCURL).addPosition(em.GetRightCurlPos())
    var ellipsis: Token = Token()
    if (em.GetHasEllipsis()) {
        ellipsis = Token(TokenKind.ELLIPSIS).addPosition(em.GetEllipsisPos())
    }
    return EnumDecl(declNode, up, superTypes, bitands, lcurl, bitors, constructors, members, rcurl, ellipsis)
}

func createExtendDecl(decl: NodeFormat_Decl, declNode: Decl): ExtendDecl {
    var ed = match (decl.GetDeclAsExtendDecl()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var extendTy = match (ed.GetExtendedType()) {
        case Some(v) => generateTypeAST(v)
        case None => throw ParseASTException()
    }
    var up: Token = Token()
    if (isValidPosition(ed.GetUpperBoundPos())) {
        up = Token(TokenKind.UPPERBOUND).addPosition(ed.GetUpperBoundPos())
    }
    var superTypes: ArrayList<TypeNode> = ArrayList<TypeNode>()
    let bitands = Tokens()
    for (ty in ed.GetInterfaces()) {
        superTypes.add(generateTypeAST(ty))
        match (ty?.GetBase()?.GetBitAndPos()) {
            case Some(position) where isValidPosition(position) => bitands.append(
                Token(TokenKind.BITAND).addPosition(position))
            case _ => ()
        }
    }
    var lcurl: Token = Token(TokenKind.LCURL).addPosition(ed.GetLeftCurlPos())
    var members = ArrayList<Decl>()
    for (mem in ed.GetMembers()) {
        members.add(generateDeclAST(mem))
    }
    var rcurl: Token = Token(TokenKind.RCURL).addPosition(ed.GetRightCurlPos())
    return ExtendDecl(declNode, extendTy, up, superTypes, bitands, Body(lcurl, members, rcurl))
}

func createFuncDecl(decl: NodeFormat_Decl, declBase: NodeFormat_DeclBase): Decl {
    var fd = match (decl.GetDeclAsFuncDecl()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    let declNode = if (fd.GetIsGetter() || fd.GetIsSetter()) {
        createDeclBase(Token(), declBase)
    } else {
        createDeclBase(Token(TokenKind.FUNC), declBase)
    }
    var funcDecl = generateCommonFuncDecl(fd, declNode)
    // Deal with overload op.
    var overloadOp = getOperaterKindOrIdentTokens(fd.GetOpKind(), fd.GetBase().getOrThrow().GetIdentifierPos(), Tokens())
    funcDecl.overloadOp = overloadOp
    return funcDecl
}

func createFuncParam(decl: NodeFormat_Decl): Decl {
    return createFuncParam(decl.GetDeclAsFuncParam(), 0, 1)
}

func createFuncParam(param: Option<NodeFormat_FuncParam>, index: Int64, length: Int64): FuncParam {
    var pm = match (param) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var astKind = pm.GetNodeBase().getOrThrow().GetAstKind()
    if (astKind == "macro_expand_param") {
        var mep = match (pm.GetMacroParamAsMacroExpandParam()) {
            case Some(v) => v
            case None => throw ParseASTException("Failed to get MacroExpandParam Node")
        }
        return match (createMacroExpand(mep.GetInvocation(), isDecl: false, isFuncParam: true) as FuncParam) {
            case Some(v) => v
            case None => throw ParseASTException("Failed to create MacroExpandParam Node")
        }
    }
    var varDecl = match (pm.GetBase()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var declBase = match (varDecl.GetBase()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var keyTk = Token()
    if (pm.GetHasLetOrVar()) {
        if (varDecl.GetIsVar()) {
            keyTk = Token(TokenKind.VAR).addPosition(declBase.GetKeywordPos())
        } else {
            keyTk = Token(TokenKind.LET).addPosition(declBase.GetKeywordPos())
        }
    }
    var declNode = createDeclBase(keyTk, declBase)
    var comma = Token()
    var ty = try {
        match (pm.GetBase()) {
            case Some(v) => generateTypeAST(v.GetType())
            case None => throw Exception()
        }
    } catch (e: Exception) {
        TypeNode()
    }
    if (index != length - 1) {
        comma = Token(TokenKind.COMMA).addPosition(pm.GetCommaPos())
    }
    var not = Token()
    if (isValidPosition(pm.GetNotMarkPos())) {
        not = Token(TokenKind.NOT).addPosition(pm.GetNotMarkPos())
    }
    var colon = Token()
    if (isValidPosition(pm.GetColonPos())) {
        colon = Token(TokenKind.COLON).addPosition(pm.GetColonPos())
    }
    var assign_ = Token()
    var expr = try {
        Some<Expr>(generateExprAST(pm.GetAssignment()))
    } catch (e: Exception) {
        None<Expr>
    }
    if (let Some(v) <- expr) {
        assign_ = Token(TokenKind.ASSIGN).addPosition(varDecl.GetAssignPos())
    }
    var isMemberParam = pm.GetIsMemberParam()
    return FuncParam(declNode, not, colon, ty, assign_, expr, comma, isMemberParam)
}

func generateFuncParams(funcBody: NodeFormat_FuncBody): ArrayList<FuncParam> {
    var params = match (funcBody.GetParamList()) {
        case Some(v) => v.GetParams()
        case None => throw ParseASTException()
    }
    var funcParams = ArrayList<FuncParam>()
    for (i in 0..params.size) {
        funcParams.add(createFuncParam(params[i], i, params.size))
    }
    return funcParams
}

func generateCommonFuncDecl(funcDecl: Option<NodeFormat_FuncDecl>, declNode: Decl) {
    var fd = match (funcDecl) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var (funcParams, colon, ty, block, lParen, rParen) = createFuncBody(fd.GetFuncBody())
    var funcDeclNode = FuncDecl(declNode, lParen, funcParams, rParen, colon, ty, block)
    var fb = match (fd.GetFuncBody()) {
        case Some(v) => v
        case None => NodeFormat_FuncBody(Array<UInt8>(0, repeat: 0), 0)
    }
    var (param, constraint, commaPos, isGeneric) = generateGenericInfo(fb.GetGeneric())
    match (param) {
        case Some(v) => funcDeclNode.genericParam = v
        case None => ()
    }
    funcDeclNode.genericConstraint = constraint
    funcDeclNode.constraintCommas = commaPos
    funcDeclNode.isGenericDecl = isGeneric
    funcDeclNode.isEnumConstruct = fd.GetIsEnumConstruct()
    return funcDeclNode
}

func createFuncBody(funcBody: Option<NodeFormat_FuncBody>) {
    var fb = match (funcBody) {
        case Some(v) => v
        case None => NodeFormat_FuncBody(Array<UInt8>(0, repeat: 0), 0)
    }
    // create function parameters
    var funcParams: ArrayList<FuncParam> = generateFuncParams(fb)
    var colon = Token()
    var ty = try {
        var retTy_ = generateTypeAST(fb.GetRetType())
        colon = Token(TokenKind.COLON).addPosition(fb.GetColonPos())
        Some<TypeNode>(retTy_)
    } catch (e: Exception) {
        None<TypeNode>
    }
    var (lParen, rParen) = try {
        var paramList = fb.GetParamList().getOrThrow()
        var l = Token(TokenKind.LPAREN).addPosition(paramList.GetLeftParenPos())
        var r = Token(TokenKind.RPAREN).addPosition(paramList.GetRightParenPos())
        (l, r)
    } catch (e: Exception) {
        (Token(), Token())
    }
    // create function block
    return match (fb.GetBody()) {
        case Some(blockNode) =>
            var lCurl: Token = Token()
            if (isValidPosition(blockNode.GetLeftCurlPos())) {
                lCurl = Token(TokenKind.LCURL).addPosition(blockNode.GetLeftCurlPos())
            }
            var nodes: ArrayList<Node> = ArrayList<Node>()
            for (i in 0..blockNode.GetBody().size) {
                nodes.add(generateNode(blockNode.GetBody()[i]))
            }
            var rCurl: Token = Token()
            if (isValidPosition(blockNode.GetRightCurlPos())) {
                rCurl = Token(TokenKind.RCURL).addPosition(blockNode.GetRightCurlPos())
            }
            var unsafe_ = Token()
            if (blockNode.GetIsUnsafe()) {
                unsafe_ = Token(TokenKind.UNSAFE).addPosition(blockNode.GetUnsafePos())
            }
            var block = Block(lCurl, nodes, rCurl, unsafe_)
            (funcParams, colon, ty, block, lParen, rParen)
        case None => (funcParams, colon, ty, Block(), lParen, rParen)
    }
}

func createMainDecl(decl: NodeFormat_Decl, declNode: Decl): MainDecl {
    var md = match (decl.GetDeclAsMainDecl()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var (funcParams, colon, ty, block, lParen, rParen) = createFuncBody(md.GetFuncBody())
    return MainDecl(declNode, lParen, funcParams, rParen, colon, ty, block)
}

func createMacroDecl(decl: NodeFormat_Decl, declNode: Decl): MacroDecl {
    var mod = match (decl.GetDeclAsMacroDecl()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var (funcParams, colon, ty, block, lParen, rParen) = createFuncBody(mod.GetFuncBody())
    return MacroDecl(declNode, lParen, funcParams, rParen, colon, ty, block)
}

func createPrimaryCtorDecl(decl: NodeFormat_Decl, declNode: Decl): PrimaryCtorDecl {
    var pcd = match (decl.GetDeclAsPrimaryCtorDecl()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var (funcParams, _, _, block, lParen, rParen) = createFuncBody(pcd.GetFuncBody())
    return PrimaryCtorDecl(declNode, lParen, funcParams, rParen, block)
}

func createVarDeclNode(decl: Option<NodeFormat_VarDecl>): VarDecl {
    var varDecl = match (decl) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var declBase = match (varDecl.GetBase()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var colon = Token()
    var ty = try {
        var declTy = generateTypeAST(varDecl.GetType())
        colon = Token(TokenKind.COLON).addPosition(varDecl.GetColonPos())
        Some<TypeNode>(declTy)
    } catch (e: Exception) {
        None<TypeNode>
    }
    var assign = Token()
    var expr = try {
        var initExpr = generateExprAST(varDecl.GetInitializer())
        assign = Token(TokenKind.ASSIGN).addPosition(varDecl.GetAssignPos())
        Some<Expr>(initExpr)
    } catch (e: Exception) {
        None<Expr>
    }
    var keyWord = Token()
    if (varDecl.GetIsVar()) {
        keyWord = Token(TokenKind.VAR).addPosition(declBase.GetKeywordPos())
    } else if (varDecl.GetEmptyKeyword()) {
        keyWord = Token()
    } else if (declBase.GetIsConst()) {
        keyWord = Token(TokenKind.CONST).addPosition(declBase.GetKeywordPos())
    } else {
        keyWord = Token(TokenKind.LET).addPosition(declBase.GetKeywordPos())
    }
    var vd = VarDecl(createDeclBase(keyWord, declBase), colon, ty, assign, expr)
    vd.isEnumConstruct = varDecl.GetIsEnumConstruct()
    return vd
}

func createVarDecl(decl: NodeFormat_Decl): Decl {
    return createVarDeclNode(decl.GetDeclAsVarDecl())
}

func createVarWithPatternDecl(decl: NodeFormat_Decl): Decl {
    var varWithPattern = match (decl.GetDeclAsVarWithPatternDecl()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var declBase = match (varWithPattern.GetBase()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var pattern = Some<Pattern>(generatePatternAST(varWithPattern.GetPattern()))
    var colon = Token()
    var ty = try {
        var t = generateTypeAST(varWithPattern.GetType())
        colon = Token(TokenKind.COLON).addPosition(varWithPattern.GetColonPos())
        Some<TypeNode>(t)
    } catch (e: Exception) {
        None<TypeNode>
    }
    var assign = Token()
    var expr = try {
        var initExpr = generateExprAST(varWithPattern.GetInitializer())
        assign = Token(TokenKind.ASSIGN).addPosition(varWithPattern.GetAssignPos())
        Some<Expr>(initExpr)
    } catch (e: Exception) {
        None<Expr>
    }
    var keyWord = Token()
    if (varWithPattern.GetIsVar()) {
        keyWord = Token(TokenKind.VAR).addPosition(declBase.GetKeywordPos())
    } else if (declBase.GetIsConst()) {
        keyWord = Token(TokenKind.CONST).addPosition(declBase.GetKeywordPos())
    } else {
        keyWord = Token(TokenKind.LET).addPosition(declBase.GetKeywordPos())
    }
    return VarDecl(createDeclBase(keyWord, declBase), pattern, colon, ty, assign, expr)
}

func createPropDecl(decl: NodeFormat_Decl) {
    var propDecl = match (decl.GetDeclAsPropDecl()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var varDecl = match (propDecl.GetBase()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var declBase = match (varDecl.GetBase()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var colon = Token(TokenKind.COLON).addPosition(propDecl.GetColonPos())
    var ty = generateTypeAST(varDecl.GetType())
    var lCurl = Token(TokenKind.LCURL).addPosition(propDecl.GetLeftCurlPos())
    var getters = propDecl.GetGetters()
    var getter = None<FuncDecl>
    if (getters.size != 0) {
        var db = match (getters[0]) {
            case Some(v) => v.GetBase()
            case None => throw ParseASTException()
        }
        getter = Some<FuncDecl>(generateCommonFuncDecl(getters[0], createDeclBase(Token(), db.getOrThrow())))
    }
    var setters = propDecl.GetSetters()
    var setter = None<FuncDecl>
    if (setters.size != 0) {
        var db = match (setters[0]) {
            case Some(v) => v.GetBase()
            case None => throw ParseASTException()
        }
        setter = Some<FuncDecl>(generateCommonFuncDecl(setters[0], createDeclBase(Token(), db.getOrThrow())))
    }
    var rCurl = Token(TokenKind.RCURL).addPosition(propDecl.GetRightCurlPos())
    return PropDecl(createDeclBase(Token(TokenKind.PROP).addPosition(declBase.GetKeywordPos()), declBase), colon, ty,
        lCurl, getter, setter, rCurl)
}

func createTypeAliasDecl(decl: NodeFormat_Decl, declBase: NodeFormat_DeclBase) {
    var typeAliasDecl = match (decl.GetDeclAsTypeAliasDecl()) {
        case Some(v) => v
        case None => throw ParseASTException()
    }
    var keyWord = Token(TokenKind.TYPE).addPosition(declBase.GetKeywordPos())
    var assign: Token = Token(TokenKind.ASSIGN).addPosition(typeAliasDecl.GetAssignPos())
    var ty = generateTypeAST(typeAliasDecl.GetType())
    return TypeAliasDecl(createDeclBase(keyWord, declBase), assign, ty)
}

func createMacroExpandDecl(decl: NodeFormat_Decl) {
    var me = match (decl.GetDeclAsMacroExpandDecl()) {
        case Some(v) => v
        case None => throw ParseASTException("Failed to get MacroExpand Node")
    }
    return match (createMacroExpand(me.GetInvocation(), isDecl: true) as Decl) {
        case Some(v) => v
        case None => throw ParseASTException("Failed to create MacroExpandDecl Node")
    }
}
