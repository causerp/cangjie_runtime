/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.unittest

import std.unittest.common.optionsInfo
import std.process.Process
import std.collection.ArrayList
import std.unittest.common.*

/*
 * Generate and print help page if it the first CLI argument is `help`, `--help`, `-help` or `-h`.
 * The help page contains information about unittest options and options defined by user.
 * Return `true` is help page was printed, `false` in other case.
 */
func printUnittestHelpPageIfRequested(): Bool {
    if (!needToPrintHelpPage()) {
        return false
    }

    let printer = ConsoleOptionsPrinter()

    let userDefinedOptions = ArrayList<OptionInfo>()
    let internalOptions = ArrayList<OptionInfo>()
    for ((_, info) in optionsInfo) {
        if (info.userDefined) {
            userDefinedOptions.add(info)
        } else {
            internalOptions.add(info)
        }
    }

    if (userDefinedOptions.size != 0) {
        printer.header("User defined options")
        for (info in userDefinedOptions) {
            printer.option(info)
        }
    }

    printer.header("Unittest options")
    for (info in internalOptions) {
        printer.option(info)
    }

    return true
}

private func needToPrintHelpPage(): Bool {
    let args = Process.current.arguments
    if (args.size == 0) {
        return false
    }
    let firstArg = args[0]

    return firstArg == "help" || firstArg == "--help" || firstArg == "-h" || firstArg == "-help"
}

private class ConsoleOptionsPrinter {
    let pp: PrettyPrinter = TerminalPrettyPrinter.fromDefaultConfiguration()

    func header(str: String): Unit {
        pp.appendLine(str + ":")
    }

    func option(info: OptionInfo): Unit {
        pp.colored(GREEN, "--${camelCaseToKebabCase(info.name)} ")

        if (let Some(description) <- info.description) {
            pp.colored((MAGENTA), description)
            pp.newLine()
        }

        var needNewLine = false
        for ((ty, typeDescription) in info.types) {
            if (needNewLine) {
                pp.newLine()
            }

            optionType(ty)
            if (let Some(description) <- typeDescription) {
                optionDesription(description)
                needNewLine = true
            }
        }

        pp.newLine()
    }

    private func optionType(ty: String): Unit {
        pp.indent {
            pp.append("[").colored(RED, "${ty}").append("]")
        }
    }

    private func optionDesription(description: String): Unit {
        pp.append(" - ")
        var quoted = false
        for (str in description.split("'")) {
            if (quoted) {
                pp.append("'").colored(YELLOW, str).append("'")
            } else {
                pp.colored(GRAY, str)
            }
            quoted = !quoted
        }
    }
}
