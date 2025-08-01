/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.common

import std.collection.ArrayList

/**
 * Color of the pretty output for tests
 */
public enum Color <: Equatable<Color> {
    | RED
    | GREEN
    | YELLOW
    | BLUE
    | CYAN
    | MAGENTA
    | GRAY
    | DEFAULT_COLOR

    public operator func ==(that: Color): Bool {
        match (this) {
            case RED => if (let RED <- that) { true } else { false }
            case GREEN => if (let GREEN <- that) { true } else { false }
            case YELLOW => if (let YELLOW <- that) { true } else { false }
            case BLUE => if (let BLUE <- that) { true } else { false }
            case CYAN => if (let CYAN <- that) { true } else { false }
            case MAGENTA => if (let MAGENTA <- that) { true } else { false }
            case GRAY => if (let GRAY <- that) { true } else { false }
            case DEFAULT_COLOR => if (let DEFAULT_COLOR <- that) { true } else { false }
        }
    }
    public operator func !=(that: Color) { !(this == that) }
}

/**
 * Abstract class to print your output to with support for indentation, alignment and colors
 */
public abstract class PrettyPrinter {

    /**
     * PrettyPrinter constructor
     * @param indentationSize the size (in spaces) of a single indentation
     * @param startingIndent the initial number of indentations applied
     */
    public PrettyPrinter(let indentationSize!: UInt64 = 4, let startingIndent!: UInt64 = 0) {
        currentIndent = " " * Int64(indentationSize) * Int64(startingIndent)
    }
    /*
     * Implement the low-level string printing
     * @param s the String to print
     */
    protected func put(s: String): Unit
    /*
     * Implement the low-level newline printing, defaults to put("\n")
     */
    protected open func putNewLine(): Unit {
        put("\n")
    }
    /*
     * Implement the low-level color setting, if this printer does not support colors,
     * does nothing
     * @param color the color to set
     */
    protected func setColor(color: Color): Unit

    /**
     * current indentation string
     */
    private var currentIndent: String
    /**
     * flag that is set up every time an indentation is needed
     */
    private var needIndent = false
    /**
     * current color, used to track color switches
     * Note: this field has no relation to setColor function
     */
    private var currentColor: Color = DEFAULT_COLOR

    /**
     * Is this pretty-printer on the top level of indentation?
     * @return false if current indent is not empty
     */
    public prop isTopLevel: Bool {
        get() { currentIndent.isEmpty() }
    }
    /**
     * Run a block of code with indentation
     * Typical usage:
    pp.indent {
        pp.appendLine("1")
        pp.appendLine("2")
        pp.appendLine("3")
    }
     * This outputs three lines with "1", "2" and "3", all indented one indentation
     * level more than current indentation
     * @param body the code block to run with indentation
     */
    public func indent(body: () -> Unit): PrettyPrinter {
        indent(1, body)
    }

    /**
     * Run a block of code with indentation
     * Typical usage:
    pp.indent(2) {
        pp.appendLine("1")
        pp.appendLine("2")
        pp.appendLine("3")
    }
     * This outputs three lines with "1", "2" and "3", all indented 2 indentation
     * levels more than current indentation
     * @param symbols the number of indentations to indent
     * @param body the code block to run with indentation
     */
    public func indent(indents: UInt64, body: () -> Unit): PrettyPrinter {
        customOffset(indents * indentationSize, body)
    }

    /**
     * Run a block of code with fully custom indentation in addition to the current level
     * Typical usage:
    pp.customOffset(5) {
        pp.appendLine("1")
        pp.appendLine("2")
        pp.appendLine("3")
    }
     * This outputs three lines with "1", "2" and "3", all indented by exactly 5 spaces
     * more than current indentation
     *
     * This should only be used when fully custom (not representable in indentation offsets)
     * offset is needed, in all other cases use indent()
     * @param symbols the number of spaces to indent
     * @param body the code block to run with indentation
     */
    public func customOffset(symbols: UInt64, body: () -> Unit): PrettyPrinter {
        let savedIndent = currentIndent
        currentIndent += " " * Int64(symbols)
        try {
            body()
        } finally {
            currentIndent = savedIndent
        }
        return this
    }

    /**
     * Run a block of code with a different color
     * Typical usage:
    pp.colored(RED) {
        pp.appendLine("1")
        pp.appendLine("2")
        pp.appendLine("3")
    }
     * This outputs three lines with "1", "2" and "3", all in red color
     *
     * @param color the color to use
     * @param body the code block to run with color
     */
    public func colored(color: Color, body: () -> Unit): PrettyPrinter {
        if (color == currentColor) {
            body()
            return this
        }
        let previousColor = currentColor
        currentColor = color
        setColor(color)
        try {
            body()
        } finally {
            currentColor = previousColor
            setColor(previousColor)
        }
        return this
    }

    /**
     * Run a block of code. And if such behavior is supported by corresponding PrettyPrinter
     * whatever is printed inside this block of code will be
     * fitted into a space that corresponds to a space taken by `spaceSize` halfwidth characters.
     *
     * @param spaceSize size of the space output must fit into
     * @param body the code block to run with color
     */
    public open func fillLimitedSpace(spaceSize: Int64, body: () -> Unit): PrettyPrinter {
        body()

        return this
    }

    /**
     * Print a string with a different color
     * @param color the color to use
     * @param string the string to print
     */
    public func colored(color: Color, text: String): PrettyPrinter {
        if (currentColor == color) {
            return append(text)
        }
        let previousColor = currentColor
        currentColor = color
        setColor(color)
        append(text)
        currentColor = previousColor
        setColor(previousColor)
        return this
    }

    /**
     * Append a string to this pretty printer
     * Note: this does not support multiline strings, no indentation is provided for that case
     * @param value the string to print
     */
    public func append(text: String): PrettyPrinter {
        if (needIndent) {
            put(currentIndent)
            needIndent = false
        }
        put(text)
        return this
    }

    /**
     * Append a string to this pretty printer, aligned in the space of `size` characters, centered
     * Note: this does not support multiline strings, no indentation is provided for that case
     * @param assert the string to print
     * @param size the size of the box to use
     */
    public func appendCentered(text: String, space: UInt64): PrettyPrinter {
        let actualSize = UInt64(text.size)
        let leftSpaces = (space - actualSize) / 2

        appendPadded(text, leftSpaces, space)
    }

    public func appendLeftAligned(text: String, space: UInt64): PrettyPrinter {
        appendPadded(text, 0, space)
    }

    public func appendRightAligned(text: String, space: UInt64): PrettyPrinter {
        let actualSize = UInt64(text.size)
        let dd = space - actualSize
        appendPadded(text, dd, space)
    }

    private func appendPadded(text: String, leftSpaces: UInt64, space: UInt64): PrettyPrinter {
        if (UInt64(text.size) >= space) {
            return append(text)
        }
        let rightSpaces = space - leftSpaces - UInt64(text.size)
        append(" " * Int64(leftSpaces))
        append(text)
        append(" " * Int64(rightSpaces))
    }

    /**
     * Append a PrettyPrintable value to this pretty printer
     * @param value the value to print
     */
    public func append<PP>(value: PP): PrettyPrinter where PP <: PrettyPrintable {
        if (needIndent) {
            put(currentIndent)
            needIndent = false
        }
        value.pprint(this)
        return this
    }

    /**
     * Print a newline
     */
    public func newLine(): PrettyPrinter {
        putNewLine()
        needIndent = true
        return this
    }

    /**
     * Print a given string, followed by a newline
     * @param value the string to print
     */
    public func appendLine(text: String): PrettyPrinter {
        append(text)
        newLine()
        return this
    }

    /**
     * Print a given PrettyPrintable value, followed by a newline
     * @param value the value to print
     */
    public func appendLine<PP>(value: PP): PrettyPrinter where PP <: PrettyPrintable {
        append(value)
        newLine()
        return this
    }
}

/**
 * Internal enum used to implement PrettyText, should not be used directly
 * A chunk of output produced by pretty printer:
 * - A string fragment
 * - A color switch
 * - A newline
 */
enum PrettyPrintableTextChunk {
    | PPTextPiece(String)
    | PPColorSwitch(Color)
    | PPNewLine
}

/**
 * A builder-like class to store pretty-printed output.
 * Main usage is for intermediate storage and passing of such values.
 * Implements both PrettyPrinter (can be printed to) and PrettyPrintable (can be printed from)
 */
public class PrettyText <: PrettyPrinter & PrettyPrintable & ToString {
    PrettyText(let data: ArrayList<PrettyPrintableTextChunk>) {}

    /**
     * Default constructor: makes an empty PrettyText
     */
    public init() {
        this(ArrayList())
    }

    /**
     * String-based constructor: makes a PrettyText with starting content of `string`
     */
    public init(string: String) {
        this()
        put(string)
    }

    /**
     * Utility factory function: create a PrettyText from a PrettyPrintable by printing it.
     * This is static only because generic constructors are not allowed.
     */
    public static func of<PP>(pp: PP) where PP <: PrettyPrintable {
        let result = PrettyText()
        pp.pprint(result)
        result
    }

    /**
     * @return true if nothing has been put into this object yet, false otherwise
     */
    public func isEmpty(): Bool {
        data.isEmpty()
    }

    protected override func put(s: String): Unit {
        if (!s.isEmpty()) {
            data.add(PPTextPiece(s))
        }
    }
    protected override func setColor(color: Color): Unit {
        data.add(PPColorSwitch(color))
    }

    protected override func putNewLine(): Unit {
        data.add(PPNewLine)
    }

    /**
     * Print this PrettyText into a pretty printer: output should look exactly like input
     * @param to the pretty printer to print to
     */
    public func pprint(to: PrettyPrinter): PrettyPrinter {
        for (element in data) {
            match (element) {
                case PPTextPiece(s) => to.append(s)
                case PPColorSwitch(c) => to.setColor(c)
                case PPNewLine => to.newLine()
            }
        }
        return to
    }
    /**
     * Print this PrettyText to a String: output should look exactly like it would on an output printer,
     * but without colors
     */
    public func toString(): String {
        let result = StringBuilder()
        for (element in data) {
            match (element) {
                case PPTextPiece(s) => result.append(s)
                case PPColorSwitch(_) => ()
                case PPNewLine => result.append("\n")
            }
        }
        return result.toString()
    }
}

/**
 * Pretty printable: interface signifying this type can be pretty-printed
 */
public interface PrettyPrintable {
    /**
     * Pretty-print this object to a given printer
     * @param to the pretty printer to print to
     * @return the same value as to
     */
    func pprint(to: PrettyPrinter): PrettyPrinter
}

/**
 * Pretty printable instance for Array: print elements in succession
 */
extend<T> Array<T> <: PrettyPrintable where T <: PrettyPrintable {
    public func pprint(to: PrettyPrinter): PrettyPrinter {
        for (e in this) {
            e.pprint(to)
        }
        return to
    }
}

/**
 * Pretty printable instance for ArrayList: print elements in succession
 */
extend<T> ArrayList<T> <: PrettyPrintable where T <: PrettyPrintable {
    public func pprint(to: PrettyPrinter): PrettyPrinter {
        for (e in this) {
            e.pprint(to)
        }
        return to
    }
}

protected const NOT_PRINTABLE_PLACEHOLDER = "<value not printable>"

protected func toStringOrPlaceholder<T>(value: T) {
    return (value as ToString)?.toString() ?? NOT_PRINTABLE_PLACEHOLDER
}

protected func toStringQuotedOrPlaceholder<T>(value: T) {
    return match (value) {
        case vStr: String => quoteString(vStr)
        case _ => toStringOrPlaceholder(value)
    }
}

protected func quoteString<T>(value: T) where T <: ToString {
    return "\"${value}\""
}
