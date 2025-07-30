/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.common

import std.collection.*
import std.sync.ReentrantMutex

public class UnittestOptionValidationException <: Exception {
    init() {
        super()
    }

    init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "UnittestOptionValidationException"
    }
}

public enum OptionValidity {
    | UnknownOptionType
    | InvalidOption(String)
    | ValidOption(ConfigurationKey) // with correct type key
}

type Validator = (Any) -> OptionValidity

public var unittestOptionsRegistryClosed = false

// validators registry is closed when defaultConfiguration is created
let validators: HashMap<String, ArrayList<Validator>> = HashMap()

public struct OptionInfo {
    OptionInfo(
        public let name: String,
        public let userDefined: Bool,
        public let description: ?String,
        public let types!: HashMap<String, ?String> = HashMap() // type to it's optional description
    ) {}
}

public let optionsInfo: HashMap<String, OptionInfo> = HashMap()
let mutex = ReentrantMutex()
let VALIDATOR_NAME = "UnittestOption"

func checkOptionValueAndGetConfigurationKey<T>(key: KeyFor<T>, value: T): ConfigurationKey {
    return checkOptionValueByNameAndGetConfigurationKey(key.name, value)
}

func checkOptionValueByNameAndGetConfigurationKey<T>(name: String, value: T): ConfigurationKey {
    let valueStr = match (value) {
        case tos: ToString => " (${name}.toString='${tos}')"
        case _ => ""
    }
    let option = "Option '${name}'${valueStr}"

    if (let Some(validators) <- validators.get(name)) {
        for (validator in validators) {
            let status = validator(value)
            match (status) {
                case UnknownOptionType => continue
                case ValidOption(configurationKey) => return configurationKey // valid, exit
                case InvalidOption(message) => throw UnittestOptionValidationException(
                    "${option} is invalid. ${message}")
            }
        }

        // no one fit
        throw UnittestOptionValidationException("${option} type is not valid.")
    }

    throw UnittestOptionValidationException("Option '${name}' has no validators. Use @${VALIDATOR_NAME} macro.")
}

public func registerOptionValidator(name: String, validator: Validator): Unit {
    if (unittestOptionsRegistryClosed) {
        throw UnittestOptionValidationException("Validator registry closed. Move your validator on top level.")
    }

    synchronized(mutex) {
        if (!validators.contains(name)) {
            validators.add(name, ArrayList())
        }

        validators[name].add(validator)
    }
}

public func setOptionInfo(
    name: String,
    types: Array<String>,
    description!: ?String = None
): Unit {
    synchronized(mutex) {
        var info = OptionInfo(name, true, description)
        for (ty in types) {
            info.types[ty] = None
        }
        optionsInfo[name] = info
    }
}

public func setOrUpdateOptionInfo(
    name: String,
    description: ?String,
    ty: String,
    typeDescription: String
): Unit {
    synchronized(mutex) {
        if (!optionsInfo.contains(name)) {
            optionsInfo.add(name, OptionInfo(name, false, description))
        }

        optionsInfo[name].types[ty] = typeDescription
    }
}
