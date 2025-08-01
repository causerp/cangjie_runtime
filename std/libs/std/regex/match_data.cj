/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares the MatchData class.
 */
package std.regex

const UNCAPTURED_GROUP_INDEX: Int64 = -1

public struct Position {
    static let empty = Position(0, 0)
    Position(public let start: Int64, public let end: Int64) {}

    @OverflowWrapping
    init(start: UIntNative, end: UIntNative) {
        this.start = Int64(start)
        this.end = Int64(end)
    }
}

public struct MatchData {
    MatchData(
        let input: String,
        let positions: Array<Position>,
        let rc: Int64,
        let nameToIndex!: (String) -> Int64 = {
            _ => throw IllegalArgumentException("Capture group not enabled.")
        }
    ) {}

    /**
     * Retrive the whole matched string.
     */
    public func matchString(): String {
        let position = positions[0]
        return input[position.start..position.end]
    }

    /**
     * Retrive the subsequence of capture group by index.
     *
     * @throws IndexOutOfBoundsException if capture group not enabled, or group is less than zero or larger than groupCount()
     */
    public func matchString(group: Int64): String {
        if (positions.size == 1 && rc > 1 && group > 0) {
            throw IllegalArgumentException("Capture group not enabled.")
        }
        if (group < 0 || group >= rc) {
            throw IllegalArgumentException("Invalid group index.")
        }
        let position = positions[group]
        if (position.start == UNCAPTURED_GROUP_INDEX || position.end == UNCAPTURED_GROUP_INDEX) {
            return String.empty
        }
        return input[position.start..position.end]
    }

    /**
     * Retrive the subsequence of capture group by name.
     *
     * @throws IllegalArgumentException if capture group not enabled or group name not found
     */
    public func matchString(group: String): String {
        if (positions.size == 1 && rc > 1) {
            throw IllegalArgumentException("Capture group not enabled.")
        }
        let index = nameToIndex(group)
        let position = positions[index]
        if (position.start == UNCAPTURED_GROUP_INDEX || position.end == UNCAPTURED_GROUP_INDEX) {
            return String.empty
        }
        return input[position.start..position.end]
    }

    /**
     * Retrive the position of whole matched string.
     *
     * @throws IndexOutOfBoundsException if the length of `position` is less than 1
     */
    public func matchPosition(): Position {
        return positions[0]
    }

    /**
     * Retrive the position of the capture group subsequence by index.
     *
     * @throws IllegalArgumentException if capture group not enabled, or group is less than zero or larger than groupCount
     */
    public func matchPosition(group: Int64): Position {
        if (positions.size == 1 && rc > 1 && group > 0) {
            throw IllegalArgumentException("Capture group not enabled.")
        }
        if (group < 0 || group >= rc) {
            throw IllegalArgumentException("Invalid group index.")
        }
        return positions[group]
    }

    /**
     * Retrive the position of the capture group subsequence by index.
     *
     * @throws IllegalArgumentException if capture group not enabled or group name not found
     */
    public func matchPosition(group: String): Position {
        if (positions.size == 1 && rc > 1) {
            throw IllegalArgumentException("Capture group not enabled.")
        }
        let index = nameToIndex(group)
        return positions[index]
    }

    @Deprecated[message: "Use member function `public func groupCount(): Int64` instead."]
    public func groupNumber(): Int64 {
        return groupCount()
    }

    /**
     * Get the count of capture groups.
     */
    public func groupCount(): Int64 {
        return rc - 1
    }
}
