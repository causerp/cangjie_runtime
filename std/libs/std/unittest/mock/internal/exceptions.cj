/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.unittest.mock.internal

/**
 * Used mock calls in the runtime-error mocking mode (compiled with --mock=runtime-error),
 * or inside a generic function which isn't marked with @Frozen annotation
 */
public class IllegalMockCallException <: Exception {
    public init() {
        super("Mock functions shouldn't be called in the runtime-error mocking mode " +
            "or inside non-frozen generic functions")
    }
}

/**
 * No default value provided for a type in the `ReturnsDefaults` mode
 */
public class NoDefaultValueForMockException <: Exception {
    public init(typeName: String, defaultValueForStubInterfaceName: String) {
        super("No provided default value for a return type `${typeName}`. "
            + "Make sure such type implements `${defaultValueForStubInterfaceName}<${typeName}>` interface")
    }
}

/**
 * Failed to cast the provided stubbed return value to the real declaration's return type
 */
public class MockReturnValueTypeMismatchException <: Exception {
    public init(declarationReturnTypeName: String) {
        super("Type of the stub's return value doesn't match the corresponding declaration's return type. "
            + "Please make sure that type in stub is `${declarationReturnTypeName}`")
    }
}

public class UninitializedStaticCallHandler <: Exception {
    public init() {
        super("Call handler for static declarations should be initialized before its usage")
    }
}
