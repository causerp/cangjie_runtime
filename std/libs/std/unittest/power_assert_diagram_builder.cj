/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.collection.*
import std.sort.*
import std.unittest.common.*

class PowerAssertValue <: Serializable<PowerAssertValue> {
    PowerAssertValue(let kind: PowerAssertValueKind, let expression: String, let position: Int64) {}

    init(value: String, expression: String, position: Int64, isException!: Bool = false) {
        this(if (isException) { PAThrown(value) } else { PAValue(value) }, expression, position)
    }

    prop value: String {
        get() {
            match (kind) {
                case PAValue(value) => value
                case PAThrown(value) => "[${value}]"
                case PASkipped => "[not computed]"
            }
        }
    }

    /**
     * Expression position range.
     */
    prop range: Range<Int64> {
        get() {
            position..(position + expression.size)
        }
    }

    prop valuePosition: Int64 {
        get() {
            let exprAlign = if (expression.size % 2 == 0) { 0 } else { 1 }
            let valueAlign = match {
                case value.size % 2 != 0 && exprAlign == 0 => -1
                case value.size % 2 == 0 && exprAlign != 0 => 0
                case _ => 1
            }
            let exprShift = (expression.size + exprAlign) / 2
            let valueShift = -(value.size + valueAlign) / 2
            position + exprShift + valueShift
        }
    }

    /**
     * Returns the safe position for the next value after this expression.
     */
    prop safeValueNextPosition: Int64 {
        get() {
            if (value.size > expression.size) {
                max(valuePosition + value.size, position + expression.size)
            } else {
                position + expression.size
            } + 1
        }
    }

    static func skipped(expression: String, position: Int64) {
        PowerAssertValue(PASkipped, expression, position)
    }

    public func serializeInternal(): DataModel {
        return DataModelStruct()
            .add(field<PowerAssertValueKind>("kind", kind))
            .add(field<String>("expression", expression))
            .add(field<Int64>("position", position))
    }

    public static func deserialize(dm: DataModel): PowerAssertValue {
        let dms = dm.asStruct()
        let kind = PowerAssertValueKind.deserialize(dms.get("kind"))
        let expression = String.deserialize(dms.get("expression"))
        let position = Int64.deserialize(dms.get("position"))

        return PowerAssertValue(kind, expression, position)
    }
}

enum PowerAssertValueKind <: Serializable<PowerAssertValueKind> {
    | PAValue(String)
    | PAThrown(String)
    | PASkipped

    private static prop TYPE_KEY: String {
        get() { "type" }
    }

    private static prop VALUE_KEY: String {
        get() { "value" }
    }

    public func serializeInternal(): DataModel {
        let dms = DataModelStruct()
        match (this) {
            case PAValue(value) =>
                dms.add(field<Int8>(TYPE_KEY, 0i8))
                dms.add(field<String>(VALUE_KEY, value))
            case PAThrown(value) =>
                dms.add(field<Int8>(TYPE_KEY, 1i8))
                dms.add(field<String>(VALUE_KEY, value))
            case PASkipped => dms.add(field<Int8>(TYPE_KEY, 2i8))
        }
        dms
    }

    public static func deserialize(dm: DataModel): PowerAssertValueKind {
        let dms = dm.asStruct()
        match (Int8.deserialize(dms.get(TYPE_KEY))) {
            case 0 => PAValue(String.deserialize(dms.get(VALUE_KEY)))
            case 1 => PAThrown(String.deserialize(dms.get(VALUE_KEY)))
            case 2 => PASkipped
            case other => throw Exception("Unknown key value during deserialization: ${other}")
        }
    }
}

class PowerAssertDiagram <: ToString & Serializable<PowerAssertDiagram> & PrettyPrintable {
    private let diagram: ArrayList<ArrayList<PowerAssertValue>>
    private var offset: Int64 = 0

    private init(diagram: ArrayList<ArrayList<PowerAssertValue>>) {
        this.diagram = diagram
    }

    init() {
        this.diagram = ArrayList<ArrayList<PowerAssertValue>>()
    }

    func setOffset(offset: Int64) {
        this.offset = offset
    }

    func addValue(newValue: PowerAssertValue) {
        // Try to put the new recorded value into the existing line, there as space enough.

        let minLine = match (getValueRowByNesting(newValue)) {
            case Some(i) => i
            case _ => diagram.size // Skip the loop before and append the new line.
        }

        for (lineIdx in minLine..diagram.size) {
            let diagramLine = diagram[lineIdx]
            match (getSuitableIndex(newValue, diagramLine)) {
                case Some(i) where i < diagramLine.size => diagramLine.add(newValue, at: i); return
                case Some(i) where i == diagramLine.size => diagramLine.add(newValue); return
                case _ => continue
            }
        }

        diagram.add(ArrayList([newValue]))
    }

    /**
     * Returns suitable index for the `value` in the `line` of the diagram.
     * May return `None` if there is no space for the `value` in the `line`.
     */
    private func getSuitableIndex(value: PowerAssertValue, line: ArrayList<PowerAssertValue>): ?Int64 {
        var nextPosFromLeft = Int64.Min
        for (i in 0..line.size) {
            let valueRight = line[i]

            let exprFitsLeft = nextPosFromLeft <= value.position
            let valueFitsLeft = nextPosFromLeft <= value.valuePosition

            let exprFitsRight = value.safeValueNextPosition <= valueRight.position
            let valueFitsRight = value.safeValueNextPosition <= valueRight.valuePosition

            match {
                case !exprFitsLeft || !valueFitsLeft => return None // Not enough space from left.
                case exprFitsRight && !valueFitsRight => return None // Not enough space for the value from right.
                case exprFitsRight => return i
                case _ => ()
            }

            nextPosFromLeft = valueRight.safeValueNextPosition
        }

        let exprFitsLeft = nextPosFromLeft <= value.position
        let valueFitsLeft = nextPosFromLeft <= value.valuePosition
        if (exprFitsLeft && valueFitsLeft) {
            return line.size // Rightmost expr with enough space for the value from left.
        }

        return None
    }

    /**
     * Returns minimal available row index into which [value] should be inserted considering expressions nesting levels:
     * * In diagram parent node expression is printed below its children nodes.
     * * Return None if there is no suitable index in [this.diagram]
     */
    private func getValueRowByNesting(value: PowerAssertValue): ?Int64 {
        func nextLine(i: Int64): ?Int64 {
            if (i + 1 < diagram.size) {
                i + 1
            } else {
                None
            }
        }

        if (diagram.isEmpty()) { return None }
        for (lineIdx in diagram.size - 1..=0 : -1) {
            let line = diagram[lineIdx]
            for (columnIdx in 0..line.size) {
                let candidate = line[columnIdx]
                match {
                    case candidate.position < value.position => continue
                    case value.position + value.expression.size < candidate.position + candidate.expression.size => break
                    case _ => return nextLine(lineIdx)
                }
            }
        }
        return 0
    }

    private func toLines(): Array<String> {
        var result = ArrayList<ArrayList<Rune>>()

        for ((lineIndex, diagramLine) in diagram |> enumerate) {
            result.add(ArrayList<Rune>())

            for (recordedValue in diagramLine) {
                fillWithWhitespace(result, recordedValue.position + offset)
                fillWithPipeline(result, lineIndex, needToFillWithWhitespace: true)
                fillWithUnderscore(result, recordedValue.expression.size)
                fillWithPipeline(result, lineIndex, needToFillWithWhitespace: true)
            }

            result.add(ArrayList<Rune>())

            for (recordedValue in diagramLine) {
                fillWithWhitespace(
                    result,
                    offset + recordedValue.valuePosition + 1
                )
                fillWithValue(result, recordedValue.value)
            }
        }
        result |> map { line: ArrayList<Rune> => String(line.toArray()) } |> collectArray
    }

    public func pprint(pp: PrettyPrinter) {
        for (line in toLines()) {
            pp.appendLine(line)
        }
        return pp
    }

    public func toString(): String {
        String.join(toLines(), delimiter: "\n")
    }

    public func serializeInternal(): DataModel {
        return (diagram |> map { line: ArrayList<PowerAssertValue> => line.toArray() } |> collectArray)
            .serializeInternal()
    }

    public static func deserialize(dm: DataModel): PowerAssertDiagram {
        let diagramAsArray = Array<Array<PowerAssertValue>>.deserialize(dm)
        let diagram = ArrayList<ArrayList<PowerAssertValue>>()

        for (diagramLine in diagramAsArray) {
            diagram.add(ArrayList(diagramLine))
        }

        return PowerAssertDiagram(diagram)
    }

    func pprintExpression(expr: String, pp: PrettyPrinter) {
        let COLOR_COMPUTED = Color.YELLOW
        let COLOR_EXCEPTION = Color.RED
        let COLOR_UNCOMPUTED = Color.GRAY

        func fillUncomputedOrThrown(pos: Int64, last: Int64, thrownRange: Range<Int64>): Unit {
            if (last < pos) { return }
            if (pos <= lastPos(thrownRange) && thrownRange.start <= last) {
                let exceptionStart = min(max(thrownRange.start, pos), last)
                let exceptionEnd = min(lastPos(thrownRange), last)
                if (pos < exceptionStart) {
                    pp.colored(COLOR_UNCOMPUTED, expr[pos..exceptionStart])
                }
                pp.colored(COLOR_EXCEPTION, expr[exceptionStart..=exceptionEnd])
                if (exceptionEnd < last) {
                    pp.colored(COLOR_UNCOMPUTED, expr[(exceptionEnd + 1)..=last])
                }
            } else {
                pp.colored(COLOR_UNCOMPUTED, expr[pos..=last])
            }
        }

        if (let Some(tvalue) <- thrownValue) {
            let ranges = diagram |> flatten |>
                filter { v: PowerAssertValue => match (v.kind) { case PAValue(_) => true; case _ => false } } |>
                map { v: PowerAssertValue => v.range } |> merge

            var pos = 0
            for (range in ranges) {
                if (pos < range.start) {
                    fillUncomputedOrThrown(pos, range.start - 1, tvalue.range)
                }
                pp.colored(COLOR_COMPUTED, expr[range])
                pos = if (range.isClosed) { range.end + 1 } else { range.end }
            }
            fillUncomputedOrThrown(pos, expr.size - 1, tvalue.range)
        } else {
            pp.colored(COLOR_COMPUTED, expr)
        }
    }

    private prop thrownValue: ?PowerAssertValue {
        get() {
            diagram |> flatten |>
                filter { v: PowerAssertValue => match (v.kind) { case PAThrown(_) => true; case _ => false } } |>
                first
        }
    }

    /**
     * Note: [Range.step] shoud not be considered here due to expressions ranges are always with step 1.
     */
    private func isPosInRange(position: Int64, range: Range<Int64>) {
        if (position < range.start) { return false }
        return position <= lastPos(range)
    }

    /**
     * Returns last element in the range inclusive.
     * Note: it's considering that [range] always has step 1 and it's not empty.
     */
    private func lastPos(range: Range<Int64>): Int64 {
        if (range.isClosed) { range.end } else { range.end - 1 }
    }

    /**
     * Merges intercecting [positions] ranges and returns sorted non-intercecting array of position ranges.
     * Note: it's considered that both accepting and returning ranges are 1-stepped and not empty.
     */
    private func merge(positions: Iterable<Range<Int64>>): Array<Range<Int64>> {
        let posArray = positions |> collectArray
        posArray.sortBy { l, r => l.start.compare(r.start) }
        let flattenPos = ArrayList<Range<Int64>>()
        var prev = posArray.get(0) ?? return []
        for (cur in posArray) {
            if (cur.start <= lastPos(prev)) {
                prev = prev.start..=max(lastPos(prev), lastPos(cur))
            } else {
                flattenPos.add(prev)
                prev = cur
            }
        }
        flattenPos.add(prev)
        flattenPos.toArray()
    }

    private func getLastLineOrThrow(result: ArrayList<ArrayList<Rune>>) {
        return (result |> last<ArrayList<Rune>>) ??
            throw Exception("Diagram's line to fill shouldn't be empty")
    }

    private func fillWithWhitespace(result: ArrayList<ArrayList<Rune>>, rightBound: Int64) {
        fillWithWhitespace(
            getLastLineOrThrow(result),
            rightBound
        )
    }

    private func fillWithWhitespace(currentLine: ArrayList<Rune>, rightBound: Int64) {
        for (_ in currentLine.size..rightBound) {
            currentLine.add(r' ')
        }
    }

    private func fillWithPipeline(result: ArrayList<ArrayList<Rune>>, lineIndex: Int64,
        needToFillWithWhitespace!: Bool = false) {
        let currentLine = getLastLineOrThrow(result)
        currentLine.add(r'|')
        for (i in 0..(lineIndex * 2)) {
            if (needToFillWithWhitespace) {
                fillWithWhitespace(result[i], currentLine.size)
            }
            if (result[i][currentLine.size - 1] == r' ') {
                result[i][currentLine.size - 1] = r'|'
            }
        }
    }

    private func fillWithUnderscore(result: ArrayList<ArrayList<Rune>>, count: Int64) {
        let currentLine = getLastLineOrThrow(result)
        for (_ in 0..count) {
            currentLine.add(r'_')
        }
    }

    private func fillWithValue(result: ArrayList<ArrayList<Rune>>, value: String) {
        let currentLine = getLastLineOrThrow(result)
        for (valueChar in value.runes()) {
            currentLine.add(valueChar)
        }
    }
}

public class PowerAssertDiagramBuilder {
    private var wasExceptionThrown = false
    private let expression: String
    private let diagram = PowerAssertDiagram()

    public init(expression: String) {
        this.expression = expression
    }

    // Below are shortcuts to reduce the size of generated code by power assertion macro

    public func r<T>(value: T, exprAsText: String, position: Int64): T {
        if (value is ToString) {
            let toStringValue = (value as ToString).getOrThrow()
            let result = recordValue(toStringValue, exprAsText, position)
            (result as T).getOrThrow()
        } else {
            value
        }
    }

    public func r(value: Rune, exprAsText: String, position: Int64): Rune {
        recordValue<String>("\'${shieldEscapeSeq(String(value), shieldDoubleQuote: false)}\'", exprAsText, position,
            shieldBackslash: false)
        value
    }

    public func r(value: String, exprAsText: String, position: Int64): String {
        recordValue<String>("\"${shieldEscapeSeq(value, shieldSingleQuote: false)}\"", exprAsText, position,
            shieldBackslash: false)
        value
    }

    public func h(exception: Exception, exprAsText: String, position: Int64): Nothing {
        handleException(exception, exprAsText, position)
    }

    public func w(passed: Bool): Unit {
        if (passed) {
            Framework.withCurrentContext{ ctx => ctx.checkPassed() }
            return
        }
        let checkResult = PowerAssertCheckResult(expression, diagram)

        Framework.withCurrentContext{ ctx => ctx.checkFailed(checkResult) }

        throw AssertException("`${expression}` has been evaluated to false", checkResult)
    }

    private func recordException(exception: Exception, expression: String): Nothing {
        let message = "`${expression}` has thrown an exception while computing"
        let originalException = match (exception) {
            case e: AssertIntermediateException => e.originalException
            case _ => exception
        }
        throw AssertIntermediateException(originalException, expression, message, diagram)
    }

    private func getExceptionRepresentation(exception: Exception) {
        if (wasExceptionThrown) {
            "[not computed]"
        } else {
            "[" + exception.toString().split(":")[0] + "]"
        }
    }

    private func recordValue<T>(value: T, exprAsText: String, position: Int64, shieldBackslash!: Bool = true): T where T <: ToString {
        let shieldedValue = shieldEscapeSeq(value.toString(), shieldSingleQuote: false, shieldDoubleQuote: false,
            shieldBackslash: shieldBackslash)
        diagram.addValue(PowerAssertValue(shieldedValue, exprAsText, position))
        value
    }

    private func recordExceptionValue(value: Exception, exprAsText: String, position: Int64) {
        let pavalue = if (wasExceptionThrown) {
            PowerAssertValue.skipped(exprAsText, position)
        } else {
            let strValue = shieldEscapeSeq(value.toString().split(":")[0])
            PowerAssertValue(strValue, exprAsText, position, isException: true)
        }
        diagram.addValue(pavalue)
    }

    private func handleException(exception: Exception, exprAsText: String, position: Int64): Nothing {
        recordExceptionValue(exception, exprAsText, position)
        wasExceptionThrown = true
        recordException(exception, exprAsText)
    }
}
