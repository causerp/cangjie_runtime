/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.database.sql

/**
 * ColumnInfo, contain the name, type, length of a column.
 */
public interface ColumnInfo {

    /**
     * column name.
     * @since 0.40.1
     */
    prop name: String

    /**
     * column type name, same with SqlDbType.name.
     *
     * @since 0.40.1
     */
    prop typeName: String

    /**
     * column length.
     * <p>For text and binary field types, this is the column type length.
     * For numeric datatypes, this is the maximum precision.
     * For datetime datatypes, this is the length in characters of the String representation.
     * If not applicable or if not supported return 0. </p>
     *
     * @since 0.40.1
     */
    prop length: Int64

    /**
     * the scale size of a decimal type.
     * If not applicable or if not supported return 0.
     *
     * @since 0.40.1
     */
    prop scale: Int64

    /**
     * whether the column may be null.
     *
     * @since 0.40.1
     */
    prop nullable: Bool

    /**
     * column's normal maximum width in characters.
     *
     * @since 0.40.1
     */
    prop displaySize: Int64
}
