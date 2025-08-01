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
 * This is a library for class DataModel, DataModelBool, DataModelInt, DataModelFloat, DataModelString, DataModelSeq, DataModelStruct, Field.
 */

package std.unittest.common

import std.collection.ArrayList

/**
 * DataModel abstract class used for various data type operations.
 */
protected abstract class DataModel {}

/**
 * DataModelNull class used for encapsulate null.
 */
protected class DataModelNull <: DataModel {}

/**
 * DataModelBool class used for encapsulate Bool.
 */
protected class DataModelBool <: DataModel {

    /* The value of the DataModelBool. */
    private var value: Bool

    /**
     * Create a new DataModelBool object.
     * Construction with parameters.
     *
     * @param bv The Bool value of DataModelBool.
     *
     * @since 0.17.4
     */
    public init(bv: Bool) {
        this.value = bv
    }

    /**
     * Get the value data of DataModelBool.
     *
     * @return the value of DataModelBool.
     *
     * @since 0.17.4
     */
    public func getValue(): Bool {
        return value
    }
}

/**
 * DataModelInt class used for encapsulate Int.
 */
protected class DataModelInt <: DataModel {

    /* The value of the DataModelInt. */
    private var value: Int64

    /**
     * Create a new DataModelInt object.
     * Construction with parameters.
     *
     * @param iv The Int64 value of DataModelInt.
     *
     * @since 0.17.4
     */
    public init(iv: Int64) {
        this.value = iv
    }

    /**
     * Get the value data of DataModelInt.
     *
     * @return the value of DataModelInt.
     *
     * @since 0.17.4
     */
    public func getValue(): Int64 {
        return value
    }
}

/**
 * DataModelFloat class used for encapsulate Float.
 */
protected class DataModelFloat <: DataModel {

    /* The value of the DataModelFloat. */
    private var value: Float64

    /**
     * Create a new DataModelFloat object.
     * Construction with parameters.
     *
     * @param fv The Float64 value of DataModelFloat.
     *
     * @since 0.17.4
     */
    public init(fv: Float64) {
        this.value = fv
    }

    public init(v: Int64) {
        this.value = Float64(v)
    }

    /**
     * Get the value data of DataModelFloat.
     *
     * @return the value of DataModelFloat.
     *
     * @since 0.17.4
     */
    public func getValue(): Float64 {
        return value
    }
}

/**
 * DataModelString class used for encapsulate String.
 */
protected class DataModelString <: DataModel {

    /* The value of the DataModelString. */
    private var value: String

    /**
     * Create a new DataModelString object.
     * Construction with parameters.
     *
     * @param sv The String value of DataModelString.
     *
     * @since 0.17.4
     */
    public init(sv: String) {
        this.value = sv
    }

    /**
     * Get the value data of DataModelString.
     *
     * @return the value of DataModelString.
     *
     * @since 0.17.4
     */
    public func getValue(): String {
        return value
    }
}

/**
 * DataModelSeq class used for encapsulate collection.
 */
protected class DataModelSeq <: DataModel {

    /* The items of the DataModelSeq. */
    private var items: ArrayList<DataModel>

    /**
     * Create a new DataModelSeq object.
     * Construction without parameters.
     *
     * @since 0.17.4
     */
    public init() {
        items = ArrayList<DataModel>()
    }

    /**
     * Create a new DataModelSeq object.
     * Construction with parameters.
     *
     * @param list The items value of DataModelSeq.
     *
     * @since 0.17.4
     */
    public init(list: ArrayList<DataModel>) {
        items = list
    }

    /**
     * Get the items data of DataModelSeq.
     *
     * @return the items of DataModelSeq.
     *
     * @since 0.17.4
     */
    public func getItems(): ArrayList<DataModel> {
        return items
    }

    /**
     * Add the Data to DataModelSeq.
     *
     * @param dm DataModel data to be added.
     *
     * @since 0.17.4
     */
    public func add(dm: DataModel) {
        items.add(dm)
    }
}

/**
 * DataModelStruct class used for encapsulate map type.
 */
protected class DataModelStruct <: DataModel {

    /* The fields of the DataModelStruct. */
    private var fields: ArrayList<Field>

    /**
     * Create a new DataModelStruct object.
     * Construction without parameters.
     *
     * @since 0.17.4
     */
    public init() {
        fields = ArrayList<Field>()
    }

    /**
     * Create a new DataModelStruct object.
     * Construction with parameters.
     *
     * @param list The fields value of DataModelStruct.
     *
     * @since 0.17.4
     */
    public init(list: ArrayList<Field>) {
        fields = list
    }

    /**
     * Get the value data of DataModelStruct.
     *
     * @return the value of DataModelStruct.
     *
     * @since 0.17.4
     */
    public func getFields(): ArrayList<Field> {
        return fields
    }

    /**
     * Add the Data to DataModelStruct.
     *
     * @param fie Field data to be added.
     * @return itself.
     *
     * @since 0.17.4
     */
    public func add(fie: Field): DataModelStruct {
        let key = fie.getName()
        for (field in fields) {
            if (field.getName() == key) {
                field.data = fie.data
                return this
            }
        }
        this.fields.add(fie)
        return this
    }

    /**
     * Obtain the DataModel corresponding to the key in DataModelStruct.
     *
     * @param key The key to be found.
     * @return the DataModel corresponding to the key.
     *
     * @since 0.17.4
     */
    public func get(key: String): DataModel {
        for (fie in fields) {
            if (fie.getName() == key) {
                return fie.getData()
            }
        }
        return DataModelNull()
    }
}

/**
 * Field class used for stores Elements of DataModelStruct.
 */
protected class Field {

    /* Name of the Field. */
    private var name: String

    /* Data of the Field. */
    var data: DataModel

    /**
     * Create a new Field object.
     * Construction with parameters.
     *
     * @param name The value of name, the empty string name ""
     * has the same behavior with other strings.
     * @param data The value of data.
     *
     * @since 0.17.4
     */
    public init(name: String, data: DataModel) {
        this.name = name
        this.data = data
    }

    /**
     * Get the name of Field.
     *
     * @return the value of name.
     *
     * @since 0.17.4
     */
    public func getName(): String {
        return name
    }

    /**
     * Get the data of Field.
     *
     * @return the value of data.
     *
     * @since 0.17.4
     */
    public func getData(): DataModel {
        return data
    }
}

/**
 * Construct  DataModelSeq object.
 *
 * @param list The items value of Collection.
 *
 * @since 0.17.4
 */
func createDataModelSeq<T>(list: Collection<T>): DataModelSeq where T <: Serializable<T> {
    let dms: ArrayList<DataModel> = ArrayList<DataModel>(list.size)
    for (i in list) {
        dms.add(i.serializeInternal())
    }
    return DataModelSeq(dms)
}

/**
 * Construct the Field object.
 *
 * @param name the name of Field, the empty string name ""
 * has the same behavior with other strings.
 * @param data The data of Field.
 * @return the Field object.
 *
 * @since 0.18.4
 */
protected func field<T>(name: String, data: T): Field where T <: Serializable<T> {
    return Field(name, data.serializeInternal())
}

/**
 * Exception class for DataModel.
 *
 * @since 0.18.4
 */
protected class DataModelException <: Exception {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "DataModelException"
    }
}
