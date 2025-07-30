/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.sync.ReentrantMutex
import std.unittest.common.*
import std.process.Process

foreign func EnableANSITerminal(): Bool

foreign func DisableANSITerminal(): Bool

var isConsoleUtf8: Bool = true

open class TerminalPrettyPrinter <: PrettyPrinter {
    /**
     * Unfortunately, we need a global lock here to make sure EnableANSITerminal() is not called
     * more than once
     */
    private static let globalAnsiLock = ReentrantMutex()
    private static var globalAnsiEnabled: ?Bool = None

    private static var _instance: ?TerminalPrettyPrinter = None
    private static let lock = ReentrantMutex()

    private static func globalInitializeAnsi(): Bool {
        synchronized(globalAnsiLock) {
            match (globalAnsiEnabled) {
                case Some(bound) => return bound
                case _ => ()
            }
            let tryEnable = unsafe { EnableANSITerminal() }
            if (tryEnable) {
                Process.current.atExit {unsafe { DisableANSITerminal() }}
            }
            globalAnsiEnabled = tryEnable
            return tryEnable
        }
    }

    private static let ESC = "\u{1B}"
    // Colors
    private static let ESC_C_DEFAULT_MODE = "${ESC}[0m"
    private static let ESC_C_RED_MODE = "${ESC}[31m"
    private static let ESC_C_GREEN_MODE = "${ESC}[32m"
    private static let ESC_C_YELLOW_MODE = "${ESC}[33m"
    private static let ESC_C_BLUE_MODE = "${ESC}[34m"
    private static let ESC_C_MAGENTA_MODE = "${ESC}[35m"
    private static let ESC_C_CYAN_MODE = "${ESC}[36m"
    private static let ESC_C_GRAY_MODE = "${ESC}[90m"

    // Cursor
    private static func ESC_LINES_UP(lines: Int64) { "${ESC}[${lines}F" } // `lines` up and move to the column start
    private static func ESC_LINES_DOWN(lines: Int64) { "${ESC}[${lines}E" } // `lines` down and move to the column start
    private static func ESC_CURSOR_HORIZONTAL_POS(column: Int64) { "${ESC}[${column}G" } // Sets cursor column
    private static func ESC_CURSOR_RIGHT(shift: Int64) { "${ESC}[${shift}C" } // Sets cursor column
    private static let ESC_CURSOR_SAVE = "${ESC}7" // Saves cursor position & attributes
    private static let ESC_CURSOR_RESTORE = "${ESC}8" // Restores previously saved cursor position & attributes
    private static let ESC_CURSOR_HIDE = "${ESC}[?25l"
    private static let ESC_CURSOR_SHOW = "${ESC}[?25h"

    // Scrollable margins
    // sets scrollable margins. Start value begins from 1.
    private static func ESC_SET_SCROLLABLE_MARGINS(start: Int64, endInclusive: Int64) { "${ESC}[${start};${endInclusive}r" }
    // sets scrollable margins from the first line to `endInclusive`
    private static func ESC_SET_SCROLLABLE_MARGINS_END(endInclusive!: Int64) { "${ESC}[1;${endInclusive}r" }
    // sets scrollable margins from the `start` to the last line of the terminal bounds
    private static func ESC_SET_SCROLLABLE_MARGINS_START(start!: Int64) { "${ESC}[${start};r" }
    // resets scrollable margins to the whole terminal bounds
    private static let ESC_RESET_SCROLLABLE_MARGINS = "${ESC}[;r"

    // Clear
    private static let ESC_CLEAR_AHEAD = "${ESC}[0J" // Clears the whole screen after the current cursor position
    private static let ESC_CLEAR_LINE = "${ESC}[2K" // Clears the whole line

    private let areColorsEnabled: Bool
    private let areOtherAnsiEnabled: Bool

    /**
     * @p isColored: should colors be displayed (via ANSI)
     * @p isOtherAnsiAble: should other ANSI escape codes be displayed such as "move cursor", "clear screen", etc
     */
    TerminalPrettyPrinter(isColored: Bool, isOtherAnsiAble!: Bool = true) {
        let isAnsiEnabled = globalInitializeAnsi()
        this.areColorsEnabled = isColored && isAnsiEnabled
        this.areOtherAnsiEnabled = isOtherAnsiAble && isAnsiEnabled
        isConsoleUtf8 = setUtf8OutputCP()
    }

    init(configuration: Configuration) {
        this(!(configuration.get(KeyNoColor.noColor) ?? false))
    }

    /**
     * Actual terminal height. Could equal `None` in case of terminal size is unavailable for some reason.
     */
    prop terminalHeight: ?UInt64 {
        get() {
            match (unsafe { GetTerminalHeight() }) {
                case 0u64 => None
                case x => x
            }
        }
    }

    /**
     * Actual terminal width. Could equal `None` in case of terminal size is unavailable for some reason.
     */
    prop terminalWidth: ?UInt64 {
        get() {
            match (unsafe { GetTerminalWidth() }) {
                case 0u64 => None
                case x => x
            }
        }
    }

    func exclusive<T>(action: (TerminalPrettyPrinter) -> T): T {
        synchronized(lock) {
            action(this)
        }
    }

    /**
     * Performs the cursor move for [lines] lines up. Scrolling-down is absent.
     */
    func up(lines: Int64) {
        if (!areOtherAnsiEnabled || lines <= 0) { return }
        put(ESC_LINES_UP(lines))
    }

    /**
     * Performs the cursor move for [lines] lines down. Scrolling-down is absent.
     */
    func down(lines: Int64) {
        if (!areOtherAnsiEnabled || lines <= 0) { return }
        put(ESC_LINES_DOWN(lines))
    }

    func toBottom() {
        down(9999) // There is no common way to ask the terminal go to the bottom
    }

    func setColumn(column!: Int64 = 1) {
        if (!areOtherAnsiEnabled) { return }
        put(ESC_CURSOR_HORIZONTAL_POS(column))
    }

    func saveCursorPos() {
        if (!areOtherAnsiEnabled) { return }
        put(ESC_CURSOR_SAVE)
        flush()
    }

    func restoreCursorPos() {
        if (!areOtherAnsiEnabled) { return }
        put(ESC_CURSOR_RESTORE)
        flush()
    }

    func hideCursor() {
        if (!areOtherAnsiEnabled) { return }
        put(ESC_CURSOR_HIDE)
        flush()
    }

    func showCursor() {
        if (!areOtherAnsiEnabled) { return }
        put(ESC_CURSOR_SHOW)
        flush()
    }

    func setScrollableMargins(start!: ?Int64 = None, end!: ?Int64 = None) {
        if (!areOtherAnsiEnabled) { return }

        match ((start, end)) {
            case (None, None) => put(ESC_RESET_SCROLLABLE_MARGINS)
            case (Some(s), None) => put(ESC_SET_SCROLLABLE_MARGINS_START(start: s))
            case (None, Some(e)) => put(ESC_SET_SCROLLABLE_MARGINS_END(endInclusive: e))
            case (Some(s), Some(e)) => put(ESC_SET_SCROLLABLE_MARGINS(s, e))
        }
        flush()
    }

    func clearAhead() {
        if (!areOtherAnsiEnabled) { return }
        put(ESC_CLEAR_AHEAD)
    }

    func clearLine() {
        if (!areOtherAnsiEnabled) { return }
        put(ESC_CLEAR_LINE)
    }

    protected override open func put(s: String): Unit {
        print(s)
    }

    protected func flush(): Unit {
        print("", flush: true)
    }

    protected override func setColor(color: Color): Unit {
        if (!areColorsEnabled) {
            return
        }

        let command = match (color) {
            case RED => ESC_C_RED_MODE
            case GREEN => ESC_C_GREEN_MODE
            case YELLOW => ESC_C_YELLOW_MODE
            case BLUE => ESC_C_BLUE_MODE
            case CYAN => ESC_C_CYAN_MODE
            case MAGENTA => ESC_C_MAGENTA_MODE
            case GRAY => ESC_C_GRAY_MODE
            case DEFAULT_COLOR => ESC_C_DEFAULT_MODE
        }
        put(command)
    }

    static prop instance: TerminalPrettyPrinter {
        get() {
            synchronized(lock) {
                match (_instance) {
                    case Some(inst) => inst
                    case None =>
                        let defaultConfig = defaultConfiguration()
                        let inst = TerminalPrettyPrinter(defaultConfig)
                        _instance = inst
                        inst
                }
            }
        }
    }

    public func fillLimitedSpace(spaceSize: Int64, body: () -> Unit): PrettyPrinter {
        if (areOtherAnsiEnabled && areColorsEnabled) {
            put(ESC_CURSOR_SAVE)
        }
        body()
        if (areOtherAnsiEnabled && areColorsEnabled) {
            put(ESC_CURSOR_RESTORE)
            put(ESC_CURSOR_RIGHT(spaceSize))
        }
        return this
    }

    static func fromDefaultConfiguration(): TerminalPrettyPrinter {
        instance
    }
}

@When[os != "Windows"]
func setUtf8OutputCP(): Bool { true }

@When[os == "Windows"]
foreign func SetConsoleOutputCP(cp: UInt32): UInt32

@When[os == "Windows"]
func setUtf8OutputCP(): Bool {
    const CP_UTF8: UInt32 = 65001
    unsafe { SetConsoleOutputCP(CP_UTF8) != 0 }
}

foreign func GetTerminalWidth(): UInt64

foreign func GetTerminalHeight(): UInt64
