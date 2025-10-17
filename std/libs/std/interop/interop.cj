/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.interop

@Intrinsic
func GetExportedRef(handle: UInt64): ?ExportedRef

@Intrinsic
func RemoveExportedRef(handle: UInt64): Unit

@Intrinsic
func CrossAccessBarrier(hadnle: UInt64): Unit

@Intrinsic
func CreateExportHandle(ref: ExportedRef): UInt64

type CrossReferenceHandler = (ExportedRef, ForeignProxy) -> Unit

public abstract class InteropContext <: Equatable<InteropContext> {
    private let crossReferenceHandler: CrossReferenceHandler
    protected init(handler: CrossReferenceHandler) {
        crossReferenceHandler = handler;
    }
}

public abstract class ExportedRef {
    protected var handle: UInt64 = 0
    protected let ref: Any
    protected let interopContext: InteropContext

    protected init(exportedRef: Any, context: InteropContext) {
        ref = exportedRef
        interopContext = context
    }

    protected func validateHandle(): Unit {
        handle = ExportTable.createExportHandle(this)
    }
}

public abstract class ForeignProxy {
    private let interopContext: InteropContext
    protected init(context: InteropContext) {
        interopContext = context
    }
}

public class ExportTable {
    public static func getExportedRef(handle: UInt64): ?ExportedRef {
        GetExportedRef(handle)
    }

    public static func removeExportedRef(handle: UInt64): Unit {
        RemoveExportedRef(handle)
    }

    public static func crossAccessBarrier(handle: UInt64): Unit {
        CrossAccessBarrier(handle)
    }

    public func createExportHandle(ref: ExportedRef): UInt64 {
        CreateExportHandle(ref)
    }
}