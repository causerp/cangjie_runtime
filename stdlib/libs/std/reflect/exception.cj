/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.reflect

public open class ReflectException <: Exception {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    protected override open func getClassName(): String {
        return "ReflectException "
    }
}

public class InfoNotFoundException <: ReflectException {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "InfoNotFoundException"
    }
}

public class MisMatchException <: ReflectException {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "MisMatchException"
    }
}

public class IllegalSetException <: ReflectException {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "IllegalSetException"
    }
}

public class IllegalTypeException <: ReflectException {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "IllegalTypeException"
    }
}

public class InvocationTargetException <: ReflectException {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "InvocationTargetException"
    }
}
