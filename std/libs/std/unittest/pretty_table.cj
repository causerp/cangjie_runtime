/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.unittest.common.*
import std.collection.*

const MIN_COLUMN_WIDTH = 6
// const MAX_COLUMN_WIDTH = 30
class PrettyTable <: PrettyPrintable {
    let columnSizes: ArrayList<Int64>
    let rows = ArrayList<ArrayList<(String, Color)>>()
    var column: Int64 = 0
    let leftAlignedColumns = HashSet<Int64>()

    PrettyTable(
        let names: ArrayList<String>
    ) {
        this.columnSizes = ArrayList<Int64>(names.size, { _ => MIN_COLUMN_WIDTH })

        this.nextRow()
        for (name in names) {
            this.addCell(name)
        }
        rows.add(ArrayList<(String, Color)>(columnSizes.size, { _ =>
            ("", DEFAULT_COLOR)
        }))
    }

    init() {
        names = ArrayList()
        columnSizes = ArrayList()
        this.nextRow()
        this.nextRow()
    }

    func addColumns<T>(names: T) where T <: Iterable<String> {
        for (name in names) {
            addColumn(name)
        }
    }

    func addColumn(name: String) {
        rows[0].add((" ${name} ", DEFAULT_COLOR))
        rows[1].add(("", DEFAULT_COLOR))
        columnSizes.add(max(MIN_COLUMN_WIDTH, name.runes() |> count))
    }

    func removeLastColumn() {
        let rowIdx = columnSizes.size - 1
        columnSizes.remove(at: rowIdx)
        rows[0].remove(at: rowIdx)
        rows[1].remove(at: rowIdx)
    }

    func alignColumnLeft(idx: Int64) {
        leftAlignedColumns.add(idx)
    }

    func addEmptyRow() {
        rows.add(ArrayList<(String, Color)>(columnSizes.size, {_ => ("", DEFAULT_COLOR)}))
    }

    func nextRow() {
        this.column = 0
        rows.add(ArrayList())
    }

    func removeCurrentRow() {
        rows.remove(at: rows.size - 1)
    }

    func addCell(value: String, color!: Color = DEFAULT_COLOR) {

        rows[rows.size - 1].add((" ${value} ", color))
        if (column >= columnSizes.size) { return }

        let size = max(columnSizes[column], displaySize(value))
        columnSizes[column] = size

        column += 1
    }

    private func displaySize(str: String): Int64 {
        // We assume ambiguous width as half width. Such symbols are quite rare.
        // However TerminalPrinter will be able to handle one of such characters being full width by overwriting trailing space.
        // For example, this can happen for `±` which has ambiguous width and actual width depends on a specific font being used.
        str.runes()
            .map { r: Rune => r.width() }
            .fold(0) { a, b => a + b }
    }

    public func pprint(pp: PrettyPrinter): PrettyPrinter {
        for (row in 0..rows.size) {
            for (col in 0..columnSizes.size) {
                var (data, color) = rows[row][col]
                let width = columnSizes[col] + 2
                let alignLeft = leftAlignedColumns.contains(col)

                if (row == 1 && alignLeft) {
                    data = ":" + String.fromUtf8(Array(width - 1, repeat: b'-'))
                }
                if (row == 1 && !alignLeft) {
                    data = String.fromUtf8(Array(width - 1, repeat: b'-')) + ":"
                }

                pp.append("|")
                printCell(pp, data, width, color, alignLeft)
            }
            pp.append("|")
            pp.newLine()
        }
        pp
    }

    private func printCell(pp: PrettyPrinter, data: String, width: Int64, color: Color, alignLeft: Bool) {
        let nonAsciiShift = data.size - displaySize(data)
        pp.colored(color) {
            pp.fillLimitedSpace(width) {
                if (alignLeft) {
                    pp.appendLeftAligned(data, UInt64(width + nonAsciiShift))
                } else {
                    pp.appendRightAligned(data, UInt64(width + nonAsciiShift))
                }
            }
        }
    }
}

extend<T> Range<T> where T <: Comparable<T> {
    func contains(v: T): Bool {
        v >= this.start && v <= this.end
    }
}
