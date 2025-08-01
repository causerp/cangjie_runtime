/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares the Matcher class.
 */
package std.regex

/**
 * An engine that performs match operations on a CharSequence
 * by interpreting a pattern
 */
@Deprecated[message: "APIs in Matcher have been moved to Regex."]
public class Matcher {
    private var input: String
    private var regex: Regex

    // the interval of string that is to be matched
    private var begin: Int64 = 0
    private var end: Int64

    private var iterator: FindIterator

    private var replacedOption: Option<String> = None
    private var replaceRegexOption: Option<Regex> = None
    private var replaceIteraorOption: Option<FindIterator> = None
    private var replaceOffsetOption: Option<Int64> = None

    public init(regex: Regex, input: String) {
        this.regex = regex
        this.input = input
        this.iterator = FindIterator(regex, input, group: true)
        end = input.size
    }

    /**
     * Attempts to match the entire region against the pattern.
     * @return MatchData's Option where the entire region matches this matcher's pattern.
     */
    public func fullMatch(): Option<MatchData> {
        let inputCString = unsafe { LibC.mallocCString(input) }
        if (inputCString.isNull()) {
            throw RegexException("Failed to mallocCString.")
        }
        let pcre2md = unsafe { CJ_REGEX_CreateMatchData(this.regex.re) }
        if (pcre2md.isNull()) {
            release(inputCString)
            throw RegexException("Create match_data for pattern `${this.regex.pattern}` failed.")
        }
        let result: Option<MatchData>
        try {
            result = regex.find(input, inputCString, pcre2md, this.begin, group: true)
        } finally {
            release(inputCString)
            release(pcre2md)
        }
        if (let Some(md) <- result) {
            if (md.matchString().size != this.input.size) {
                return None
            }
        }
        return result
    }

    /**
     * Attempts to match the region against the pattern from beginning.
     * @return MatchData's Option where the entire region matches this matcher's pattern.
     */
    public func matchStart(): Option<MatchData> {
        let inputCString = unsafe { LibC.mallocCString(input) }
        if (inputCString.isNull()) {
            throw RegexException("Failed to mallocCString.")
        }
        let pcre2md = unsafe { CJ_REGEX_CreateMatchData(this.regex.re) }
        if (pcre2md.isNull()) {
            release(inputCString)
            throw RegexException("Create match_data for pattern `${this.regex.pattern}` failed.")
        }
        let result: Option<MatchData>
        try {
            result = regex.find(input, inputCString, pcre2md, this.begin, group: true)
        } finally {
            release(inputCString)
            release(pcre2md)
        }
        if (let Some(md) <- result) {
            if (this.input.startsWith(md.matchString())) {
                return md
            }
        }
        return None
    }

    private func checkBounds(mdOption: Option<MatchData>): Bool {
        if (let Some(md) <- mdOption) {
            let position = md.matchPosition()
            if (this.begin <= position.start && this.end >= position.end) {
                return true
            }
        }
        return false
    }

    /**
     * Attempts to find the next subsequence of the input sequence that matches
     * the pattern.
     *
     * This method starts at the beginning of this matcher's region, or, if
     * a previous invocation of the method was successful and the matcher has
     * not since been reset, at the first character not matched by the previous
     * match.
     *
     * @return MatchData's Option where the entire region  matches this matcher's pattern.
     *
     */
    public func find(): Option<MatchData> {
        let mdOption = iterator.next()
        if (checkBounds(mdOption)) {
            return mdOption
        }
        return None
    }

    /**
     * Resets this matcher and then attempts to find the next subsequence of
     * the input sequence that matches the pattern, starting at the specified.
     * @param index The the input sequence that matches from index.
     * @return MatchData's Option where the entire region  matches this matcher's pattern.
     *
     * @throws IndexOutOfBoundsException if index is less than 0 or index is greater than or equal to input.size.
     */
    public func find(index: Int64): Option<MatchData> {
        if (index < 0 || index >= input.size) {
            throw IndexOutOfBoundsException("Invalid index: ${index} against size: ${input.size}.")
        }
        setRegion(index, this.input.size)
        return find()
    }

    /**
     * Reset the region and find all match data in range of this matcher's region.
     */
    public func findAll(): Option<Array<MatchData>> {
        let list = regex.findAll(input, group: true)
        return if (list.isEmpty()) {
            None
        } else {
            list
        }
    }

    /**
     * Get number of records that match the regular expression.
     * @return number of records.
     */
    public func allCount(): Int64 {
        return regex.allCount(input, this.begin, this.end)
    }

    /**
     * Replaces the first subsequence of the input sequence that matches the
     * pattern with the given replacement string.
     *
     * This method will not resets this matcher,it then scans the input
     * sequence looking for a match of the pattern,at the first character not matched by the previous
     * match.
     * @param replacement The character sequence to be replaced.
     * @return The character that has been replaced.
     */
    public func replace(replacement: String): String {
        var replaced = this.replacedOption ?? input
        let replaceRegex = this.replaceRegexOption ?? Regex(regex.string(), regex.flags)
        let replaceIteraor = this.replaceIteraorOption ?? FindIterator(replaceRegex, input, group: false)
        replaceIteraor.offset = this.begin
        var replaceOffset = replaceOffsetOption ?? 0
        let sb = if (replaced.size == 0) {
            StringBuilder()
        } else {
            StringBuilder(replaced.size)
        }
        var replaceEnd = 0
        if (let Some(md) <- replaceIteraor.next()) {
            let position = md.matchPosition()
            this.begin = position.end
            let replaceStart = position.start + replaceOffset
            sb.append(replaced[0..replaceStart])
            sb.append(replacement)
            replaceEnd = position.end + replaceOffset

            let matchLength = position.end - position.start
            replaceOffsetOption = replaceOffset + replacement.size - matchLength
        } else {
            return replaced
        }
        sb.append(replaced[replaceEnd..])
        replaced = sb.toString()
        replacedOption = replaced
        return replaced
    }

    /**
     * Resets this matcher and then attempts to find the next subsequence of
     * the input sequence that matches from index.
     *
     * This method will resets this matcher,Characters that are not
     * part of the match are appended directly to the result string; the match
     * is replaced in the result by the replacement string.
     *
     * @param replacement The character sequence to be replaced.
     * @param index The the input sequence that matches from index.
     * @return The character that has been replaced.
     *
     * @throws IndexOutOfBoundsException if index is less than 0 or index is greater than or equal to input.size.
     */
    public func replace(replacement: String, index: Int64): String {
        if (index < 0 || index >= input.size) {
            throw IndexOutOfBoundsException("Invalid index: ${index} against size: ${input.size}.")
        }
        setRegion(index, input.size)
        return regex.replace(input, replacement, index)
    }

    /**
     * @param replacement The character sequence to be replaced.
     */
    public func replaceAll(replacement: String): String {
        return replaceAll(replacement, -1)
    }

    /**
     * if `limit` is greater than zero then it will replace the string at most `limit` times
     * if `limit` is non-positive, it will replace the string as many times as possible
     * if `limit` is zero, return the string
     *
     * @param replacement The character sequence to be replaced.
     * @param limit The limit of replace.
     */
    public func replaceAll(replacement: String, limit: Int64): String {
        return regex.replaceAll(input, replacement, limit)
    }

    /**
     * Split the input sequence by all subsequence that matches the pattern as the delimiters.
     *
     * @return The array of strings computed by splitting the input
     * around matches of this pattern
     */
    public func split(): Array<String> {
        return regex.split(input)
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
    public func split(limit: Int64): Array<String> {
        return regex.split(input, limit)
    }

    /**
     * Sets the region of string that will be searched to find a match.
     * @param start The index to start searching at (inclusive).
     * @param end The index to end searching at (exclusive).
     * @return  this matcher.
     *
     * @throws IndexOutOfBoundsException if beginIndex less than 0 or beginIndex greater than input.size
     * @throws IndexOutOfBoundsException if endIndex less than 0 or endIndex greater than input.size
     * @throws IndexOutOfBoundsException if beginIndex greater than endIndex
     */
    public func setRegion(beginIndex: Int64, endIndex: Int64): Matcher {
        if (beginIndex < 0 || beginIndex > input.size) {
            throw IndexOutOfBoundsException("Begin ${beginIndex}.")
        }
        if (endIndex < 0 || endIndex > input.size) {
            throw IndexOutOfBoundsException("End ${endIndex}.")
        }
        if (beginIndex > endIndex) {
            throw IndexOutOfBoundsException("End ${endIndex} must be greater than or equal to Start ${beginIndex}.")
        }

        begin = beginIndex
        end = endIndex
        iterator.offset = beginIndex

        return this
    }

    /**
     * Reports the start index and end index of the matcher's region.
     */
    public func region(): Position {
        Position(begin, end)
    }

    /**
     * Sets the limits of this matcher's region. The region is the part of the
     * input sequence that will be searched to find a match. Invoking this
     * method resets the matcher.
     * @return this matcher.
     *
     * @throws RegexException if set region failed.
     */
    public func resetRegion(): Matcher {
        begin = 0
        end = input.size
        iterator.offset = begin
        replaceOffsetOption = None
        replaceIteraorOption = None
        replaceRegexOption = None
        replacedOption = None
        return this
    }

    /**
     * Resets the Matcher's with a new string.
     *
     * @param input The new input character sequence.
     *
     * @return This matcher.
     */
    public func resetString(input: String): Matcher {
        this.input = input
        this.iterator = FindIterator(regex, input, group: true)
        resetRegion()
        return this
    }

    /**
     * get this Matcher's input.
     *
     * @return This matcher's input.
     */
    public func getString(): String {
        return this.input
    }
}
