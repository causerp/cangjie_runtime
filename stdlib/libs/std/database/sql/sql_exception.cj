/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * This file defines the SqlException class.
 */

package std.database.sql

/**
 * The SqlException class is used to handle SQL-related exceptions.
 *
 * @since 0.32.3
 */
public open class SqlException <: Exception {
    var _sqlState = ""
    var _errorCode: Int64 = 0

    /**
     * a five-character string where IDMS returns the status of the last SQL statement executed.
     *
     * @since 0.43.2
     */
    public prop sqlState: String {
        get() {
            _sqlState
        }
    }

    /**
     * error code that is specific to each vendor.
     *
     * @since 0.43.2
     */
    public prop errorCode: Int64 {
        get() {
            _errorCode
        }
    }

    public override prop message: String {
        get() {
            var msg = super.message
            if (msg != "") {
                msg += ", "
            }
            if (_sqlState != "") {
                msg += "SqlState: ${_sqlState}, "
            }
            msg += "errorCode: ${_errorCode}"
            msg
        }
    }

    /**
     * Parameterless constructor.
     *
     * @since 0.32.3
     */
    public init() {
        super()
    }

    /**
     * Parameter constructor.
     *
     * @param message : predefined message.
     * @param sqlState : a five-character string where IDMS returns the status of the last SQL statement executed.
     * @param errorCode : an integer error code that is specific to each vendor.
     *
     * @since 0.43.2
     */
    public init(message: String, sqlState: String, errorCode: Int64) {
        super(message)
        this._sqlState = sqlState
        this._errorCode = errorCode
    }

    /**
     * Parameter constructor.
     *
     * @param message : predefined message.
     *
     * @since 0.32.3
     */
    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "SqlException"
    }
}
