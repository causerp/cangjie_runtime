/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares the Regex class.
 */
package std.regex

import std.collection.*
import std.sync.*

func release(cString: CString) {
    unsafe {
        if (!cString.isNull()) {
            LibC.free(cString)
        }
    }
}

func release(pcre2md: Pcre2MatchDataPtr) {
    unsafe {
        CJ_REGEX_FreeMatchData(pcre2md)
    }
}

/**
 * Iterator for lazyFindAll() of Regex
 */
class FindIterator <: Iterator<MatchData> {
    var offset: Int64 = 0

    private let regex: Regex
    private let input: String
    private let inputCString: CString
    private let group: Bool
    private let pcre2md: Pcre2MatchDataPtr

    init(regex: Regex, input: String, group!: Bool = false) {
        this.regex = regex
        this.input = input
        this.inputCString = unsafe { LibC.mallocCString(input) }
        if (this.inputCString.isNull()) {
            throw RegexException("Failed to mallocCString.")
        }
        this.pcre2md = unsafe { CJ_REGEX_CreateMatchData(regex.re) }
        if (pcre2md.isNull()) {
            release(inputCString)
            throw RegexException("Create match_data for pattern `${regex.pattern}` failed.")
        }
        this.group = group
    }

    ~init() {
        release(inputCString)
        release(pcre2md)
    }

    public func next(): Option<MatchData> {
        let result = regex.find(input, inputCString, pcre2md, offset, group: group)
        if (let Some(md) <- result) {
            if (offset == md.matchPosition().end) {
                offset = md.matchPosition().end + 1
            } else {
                offset = md.matchPosition().end
            }
        }
        return result
    }
}

/**
 * Regular Expression.
 * Description: Used to retrieve and replace text that conforms to a certain pattern.
 */
public class Regex {
    // refers to `pcre2_code*` in PCRE2, and indicates the compiled pattern
    let re: Pcre2CodePtr

    var pattern: String
    var flags: Array<RegexFlag>

    private var namedGroups: Option<HashMap<String, Int64>> = None

    public init(pattern: String, flags: Array<RegexFlag>) {
        this.pattern = pattern
        this.flags = flags

        let options: UInt32 = RegexFlag.getValue(flags)

        unsafe {
            let patternCString = LibC.mallocCString(pattern)
            if (patternCString.isNull()) {
                throw RegexException("Failed to mallocCString.")
            }

            let resultCPointer: CPointer<CompileResult> = CJ_REGEX_Compile(patternCString, options)
            LibC.free(patternCString)
            if (resultCPointer.isNull()) {
                throw RegexException("Compilation for pattern `${pattern}` failed.")
            }

            let result: CompileResult = resultCPointer.read()
            LibC.free(resultCPointer)
            if (result.re.isNull()) {
                let errorMsgCString = CJ_REGEX_GetErrorMsg(result.errorCode)
                if (errorMsgCString.isNull()) {
                    throw RegexException("Compilation for pattern `${pattern}` failed at offset ${result.errorOffset}.")
                }
                try {
                    let errorMsg = errorMsgCString.toString()
                    throw RegexException(
                        "Compilation for pattern `${pattern}` failed at offset ${result.errorOffset}: ${errorMsg}.")
                } finally {
                    LibC.free(errorMsgCString)
                }
            }
            this.re = result.re
            keepAlive(this)
        }
    }

    @Deprecated[message: "Use member funtion `public Regex(let pattern: String, flags: Array<RegexFlag>)` instead."]
    public init(pattern: String, option: RegexOption) {
        this(pattern, option.toFlags())
    }

    ~init() {
        unsafe {
            CJ_REGEX_FreeCode(this.re)
        }
    }

    @Deprecated[message: "`Matcher` has been marked as deprecated."]
    public func matcher(input: String): Matcher {
        return Matcher(this, input)
    }

    /**
     * Attempts to check whether input matches the pattern.
     * @param input The character sequence to be matched.
     * @return Bool indicates the check result
     */
    public func matches(input: String): Bool {
        unsafe {
            let inputCString = LibC.mallocCString(input)
            if (inputCString.isNull()) {
                throw RegexException("Failed to mallocCString.")
            }
            let pcre2md = CJ_REGEX_CreateMatchData(this.re)
            if (pcre2md.isNull()) {
                release(inputCString)
                throw RegexException("Create match_data for pattern `${pattern}` failed.")
            }
            let isMatch = CJ_REGEX_Match(this.re, inputCString, UIntNative(input.size), UIntNative(0), pcre2md) >= 0
            keepAlive(this)
            release(inputCString)
            release(pcre2md)
            return isMatch
        }
    }

    /**
     * lazy getter of namedGroups, which only depending on the compiled pattern.
     * So this method can be invoked as soon as `Regex` is initialized.
     * return Map<String, Int64> indicates the mapping from group name to group index
     */
    public func getNamedGroups(): Map<String, Int64> {
        if (let Some(map) <- namedGroups) {
            return map
        }
        unsafe {
            let nameTableInfoCPointer: CPointer<NameTableInfo> = CJ_REGEX_GetNameTableInfo(this.re)
            keepAlive(this)
            if (nameTableInfoCPointer.isNull()) {
                throw RegexException("GetNameTableInfo failed.")
            }
            let nameTableInfo = nameTableInfoCPointer.read()
            LibC.free(nameTableInfoCPointer)
            let nameCount = Int64(nameTableInfo.nameCount)
            let nameEntrySize = Int64(nameTableInfo.nameEntrySize)
            // nameTable cannot be `free()` because it's not created by `malloc()`
            let nameTable = nameTableInfo.nameTable
            let map = HashMap<String, Int64>(nameCount)
            if (nameTable.isNull()) {
                return map
            }
            var entryIndex = 0
            for (_ in 0..nameCount) {
                let high = Int64(nameTable.read(entryIndex + 0))
                let low = Int64(nameTable.read(entryIndex + 1))
                let index = (high << 8) | low
                let nameRawData = Array<UInt8>(nameEntrySize - 2, repeat: 0)
                for (i in 2..nameEntrySize) {
                    nameRawData[i - 2] = nameTable.read(entryIndex + i)
                }
                let name = String.fromUtf8Unchecked(nameRawData).trimEnd(r'\0')
                map[name] = index
                entryIndex += nameEntrySize
            }
            namedGroups = map
            return map
        }
    }

    /**
     * find the group index by group name
     */
    private func nameToIndex(name: String): Int64 {
        let map = getNamedGroups()
        return map.get(name) ?? throw IllegalArgumentException("Capture group `${name}` not found.")
    }

    /**
     * Attempts to find the first match of the input sequence from the beginning.
     * @param input The the input sequence.
     * @param group Whether enable capture group or not. Disabled by default.
     * @return Option<MatchData> indicates the match.
     */
    public func find(input: String, group!: Bool = false): Option<MatchData> {
        let inputCString = unsafe { LibC.mallocCString(input) }
        if (inputCString.isNull()) {
            throw RegexException("Failed to mallocCString.")
        }
        let pcre2md = unsafe { CJ_REGEX_CreateMatchData(this.re) }
        if (pcre2md.isNull()) {
            release(inputCString)
            throw RegexException("Create match_data for pattern `${pattern}` failed.")
        }
        let result: Option<MatchData>
        try {
            result = find(input, inputCString, pcre2md, 0, group: group)
        } finally {
            release(inputCString)
            release(pcre2md)
        }
        return result
    }

    /**
     * Method of `internal` version with parameters `inputCString` & `offset`
     * @param inputCString indicates cached CString of input sequenece
     * @param offset indicates the offset of `pcre2_match()`, which used by `FindIterator` and `Matcher`
     */
    func find(input: String, inputCString: CString, pcre2md: Pcre2MatchDataPtr, offset: Int64, group!: Bool = false): Option<MatchData> {
        unsafe {
            var md: Option<MatchData> = None
            let rc = Int64(CJ_REGEX_Match(this.re, inputCString, UIntNative(input.size), UIntNative(offset), pcre2md))
            if (rc < 0) {
                return md
            }
            // ovector cannot be `free()` because it's not created by `malloc`
            let ovector: CPointer<UIntNative> = CJ_REGEX_GetOvector(pcre2md)
            if (ovector.isNull()) {
                throw RegexException("Process matched data failed.")
            }
            let positions: Array<Position>
            if (group) {
                positions = Array<Position>(rc, {i => Position(ovector.read(2 * i), ovector.read(2 * i + 1))})
                md = MatchData(input, positions, rc, nameToIndex: nameToIndex)
            } else {
                positions = [Position(ovector.read(0), ovector.read(1))]
                md = MatchData(input, positions, rc)
            }
            keepAlive(this)
            return md
        }
    }

    func allCount(input: String, begin: Int64, end: Int64): Int64 {
        unsafe {
            let inputCString = LibC.mallocCString(input)
            if (inputCString.isNull()) {
                throw RegexException("Failed to mallocCString.")
            }
            let pcre2md = CJ_REGEX_CreateMatchData(this.re)
            if (pcre2md.isNull()) {
                release(inputCString)
                throw RegexException("Create match_data for pattern `${pattern}` failed.")
            }
            let count = CJ_REGEX_Count(this.re, inputCString, UIntNative(input.size), UIntNative(begin), UIntNative(end), pcre2md)
            keepAlive(this)
            release(inputCString)
            release(pcre2md)
            return count
        }
    }

    /**
     * Find all matches of the input sequence from the beginning.
     * @param input The the input sequence.
     * @param group Whether enable capture group or not. Disabled by default.
     * @return Array<MatchData> indicates the matches.
     */
    public func findAll(input: String, group!: Bool = false): Array<MatchData> {
        let list = ArrayList<MatchData>()
        unsafe {
            let inputCString = LibC.mallocCString(input)
            if (inputCString.isNull()) {
                throw RegexException("Failed to mallocCString.")
            }
            let pcre2md = CJ_REGEX_CreateMatchData(this.re)
            if (pcre2md.isNull()) {
                release(inputCString)
                throw RegexException("Create match_data for pattern `${pattern}` failed.")
            }
            var offset = 0
            while (true) {
                let rc = Int64(CJ_REGEX_Match(this.re, inputCString, UIntNative(input.size), UIntNative(offset), pcre2md))
                if (rc < 0) {
                    break
                }
                // ovector cannot be `free()` because it's not created by `malloc`
                let ovector: CPointer<UIntNative> = CJ_REGEX_GetOvector(pcre2md)
                if (ovector.isNull()) {
                    release(inputCString)
                    release(pcre2md)
                    throw RegexException("Processing matched data failed.")
                }
                let positions: Array<Position>
                if (group) {
                    positions = Array<Position>(rc, {i => Position(ovector.read(2 * i), ovector.read(2 * i + 1))})
                    list.add(MatchData(input, positions, rc, nameToIndex: nameToIndex))
                } else {
                    positions = [Position(ovector.read(0), ovector.read(1))]
                    list.add(MatchData(input, positions, rc))
                }
                if (offset == positions[0].end) {
                    offset = positions[0].end + 1
                } else {
                    offset = positions[0].end
                }
            }
            keepAlive(this)
            release(inputCString)
            release(pcre2md)
            return if (list.size == list.capacity) {
                list.getRawArray()
            } else {
                list.toArray()
            }
        }
    }

    /**
     * Get an iterator for finding all matches of the input sequence from the beginning.
     * @param input The the input sequence.
     * @param group Whether enable capture group or not. Disabled by default.
     * @return Iterator<MatchData> indicates the iterator.
     */
    public func lazyFindAll(input: String, group!: Bool = false): Iterator<MatchData> {
        return FindIterator(this, input, group: group)
    }

    /**
     * Replaces the first subsequence of the input sequence that matches the
     * pattern with the given replacement string from the beginning.
     *
     * @param input The the input sequence.
     * @param replacement The character sequence to be replaced.
     * @return The character that has been replaced.
     */
    public func replace(input: String, replacement: String): String {
        return replace(input, replacement, 0)
    }

    /**
     * Replaces the first subsequence of the input sequence that matches the
     * pattern with the given replacement string from index.
     *
     * @param input The the input sequence.
     * @param replacement The character sequence to be replaced.
     * @param index The the input sequence that matches from index.
     * @return The character that has been replaced.
     *
     * @throws IndexOutOfBoundsException if index is less than 0 or index is greater than or equal to input.size.
     */
    public func replace(input: String, replacement: String, index: Int64): String {
        if (index < 0 || index >= input.size) {
            throw IndexOutOfBoundsException("Invalid index: ${index} against size: ${input.size}.")
        }

        let sb = if (input.size == 0) {
            StringBuilder()
        } else {
            StringBuilder(input.size)
        }
        var offset = 0
        let inputCString = unsafe { LibC.mallocCString(input) }
        if (inputCString.isNull()) {
            throw RegexException("Failed to mallocCString.")
        }
        let pcre2md = unsafe { CJ_REGEX_CreateMatchData(this.re) }
        if (pcre2md.isNull()) {
            release(inputCString)
            throw RegexException("Create match_data for pattern `${pattern}` failed.")
        }
        try {
            if (let Some(md) <- find(input, inputCString, pcre2md, index, group: false)) {
                let position = md.matchPosition()
                sb.append(input[offset..position.start])
                sb.append(replacement)
                offset = position.end
            }
            sb.append(input[offset..])
            return sb.toString()
        } finally {
            release(inputCString)
            release(pcre2md)
        }
    }

    /**
     * Replaces all subsequence of the input sequence that matches the
     * pattern with the given replacement string from the beginning.
     *
     * @param input The the input sequence.
     * @param replacement The character sequence to be replaced.
     * @return The character that has been replaced.
     */
    public func replaceAll(input: String, replacement: String): String {
        replaceAll(input, replacement, -1)
    }

    /**
     * Replaces all subsequence of the input sequence that matches the
     * pattern with the given replacement string from the beginning.
     *
     * if `limit` is greater than zero then it will replace the string at most `limit` times
     * if `limit` is non-positive, it will replace the string as many times as possible
     * if `limit` is zero, return the string
     *
     * @param input The the input sequence.
     * @param replacement The character sequence to be replaced.
     * @param limit The replacement limit.
     * @return The character that has been replaced.
     */
    public func replaceAll(input: String, replacement: String, limit: Int64): String {
        if (limit == 0) {
            return input
        }

        let sb = if (input.size == 0) {
            StringBuilder()
        } else {
            StringBuilder(input.size)
        }
        var offset = 0
        var count = 0
        for (md in lazyFindAll(input, group: false)) {
            if (limit > 0 && count >= limit) {
                break
            }
            let position = md.matchPosition()
            sb.append(input[offset..position.start])
            sb.append(replacement)
            offset = position.end
            count += 1
        }
        sb.append(input[offset..])
        return sb.toString()
    }

    /**
     * Split the input sequence by all subsequence that matches the pattern as the delimiters.
     *
     * @param input The the input sequence.
     * @return The array of strings computed by splitting the input
     * around matches of this pattern
     */
    public func split(input: String): Array<String> {
        let mds = findAll(input, group: false)
        let list = ArrayList<String>(mds.size + 1)
        var offset = 0
        for (i in 0..mds.size) {
            let position = mds[i].matchPosition()
            list.add(input[offset..position.start])
            offset = position.end
        }
        list.add(input[offset..])
        return unsafe { list.getRawArray() }
    }

    /**
     * Split the input sequence by all subsequence that matches the pattern as the delimiters
     *
     * if limit n is greater than zero then it will separate the string at most n times
     * if limit n is non-positive, it will separate the string as many times as possible
     *
     * @param input The the input sequence.
     * @param limit The limit of split
     * @return The array of strings computed by splitting the input
     * around matches of this pattern
     */
    public func split(input: String, limit: Int64): Array<String> {
        if (limit <= 0) {
            return split(input)
        }
        let list = ArrayList<String>(limit)
        var offset = 0
        var count = 0
        for (md in lazyFindAll(input, group: false)) {
            if (count >= limit - 1) {
                break
            }
            let position = md.matchPosition()
            list.add(input[offset..position.start])
            offset = position.end
            count += 1
        }
        list.add(input[offset..])
        return if (list.size == list.capacity) {
            unsafe { list.getRawArray() }
        } else {
            list.toArray()
        }
    }

    public func string(): String {
        return this.pattern
    }
}

let _phantom = Object()
let _rf = AtomicReference<Object>(_phantom)

func keepAlive(o: Object) {
    _rf.store(o)
    _rf.store(_phantom)
}
