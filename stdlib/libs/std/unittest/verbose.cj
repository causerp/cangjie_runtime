/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.core.println as corePrintln
import std.core.print as corePrint

class ProgressOutput {
    private let isVerbose: Bool

    ProgressOutput(configuration: Configuration) {
        this.isVerbose = configuration.get(KeyVerbose.verbose) ?? false
    }

    func println(message: () -> String) {
        corePrintln(message())
    }

    func verboseLine(message: String) {
        if (isVerbose) {
            corePrintln(message)
        }
    }

    func verbose(message: String) {
        if (isVerbose) {
            corePrint(message)
        }
    }
}
