/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.regex

type Pcre2CodePtr = CPointer<Unit>

type Pcre2MatchDataPtr = CPointer<Unit>

type Pcre2OvectorPtr = CPointer<UIntNative>

@C
struct CompileResult {
    CompileResult(let re: Pcre2CodePtr, let errorCode: Int32, let errorOffset: UIntNative) {}
}

@C
struct NameTableInfo {
    NameTableInfo(let nameCount: UInt32, let nameEntrySize: UInt32, let nameTable: CPointer<UInt8>) {}
}

@FastNative
foreign func CJ_REGEX_Compile(pattern: CString, options: UInt32): CPointer<CompileResult>

@FastNative
foreign func CJ_REGEX_CreateMatchData(re: Pcre2CodePtr): Pcre2MatchDataPtr

@FastNative
foreign func CJ_REGEX_Match(re: Pcre2CodePtr, cinput: CString, length: UIntNative, offset: UIntNative,
    matchData: Pcre2MatchDataPtr): Int32

@FastNative
foreign func CJ_REGEX_GetOvector(matchData: Pcre2MatchDataPtr): Pcre2OvectorPtr

@FastNative
foreign func CJ_REGEX_GetErrorMsg(errorCode: Int32): CString

@FastNative
foreign func CJ_REGEX_GetNameTableInfo(re: Pcre2CodePtr): CPointer<NameTableInfo>

@FastNative
foreign func CJ_REGEX_FreeCode(re: Pcre2CodePtr): Unit

@FastNative
foreign func CJ_REGEX_FreeMatchData(md: Pcre2MatchDataPtr): Unit

@FastNative
foreign func CJ_REGEX_Count(re: Pcre2CodePtr, cinput: CString, length: UIntNative, offset: UIntNative, end: UIntNative,
    matchData: Pcre2MatchDataPtr): Int64
