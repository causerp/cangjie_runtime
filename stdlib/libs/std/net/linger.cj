/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

@When[os == "Windows"]
@C
struct Linger {
    var enabled: UInt16 = 0
    var seconds: UInt16 = 0

    init(onOff: Bool, seconds: Int64) {
        this.enabled = if (onOff) {
            1
        } else {
            0
        }
        this.seconds = match {
            case seconds > Int64(UInt16.Max) => UInt16.Max
            case _ => UInt16(seconds)
        }
    }

    static const size: UIntNative = 4

    static func use<R>(block: (CPointer<Linger>) -> R): R {
        unsafe {
            let ptr = LibC.malloc<Linger>()
            if (ptr.isNull()) {
                throw IllegalMemoryException("Malloc failed.")
            }

            try {
                block(ptr)
            } finally {
                LibC.free(ptr)
            }
        }
    }
}

@When[os != "Windows"]
@C
struct Linger {
    var enabled: Int32 = 0
    var seconds: Int32 = 0

    init(onOff: Bool, seconds: Int64) {
        this.enabled = if (onOff) {
            1
        } else {
            0
        }
        this.seconds = match {
            case seconds > Int64(Int32.Max) => Int32.Max
            case _ => Int32(seconds)
        }
    }

    static let size: UIntNative = 8

    static func use<R>(block: (CPointer<Linger>) -> R): R {
        unsafe {
            let ptr = LibC.malloc<Linger>()
            if (ptr.isNull()) {
                throw IllegalMemoryException("Malloc failed.")
            }

            try {
                block(ptr)
            } finally {
                LibC.free(ptr)
            }
        }
    }
}

extend<ActualPlatformSocket> SocketCommon<ActualPlatformSocket> {
    func getLinger(): ?Duration {
        Linger.use<?Duration> {
            ptr => unsafe {
                let sizePtr = LibC.malloc<UIntNative>()
                if (sizePtr.isNull()) {
                    throw IllegalMemoryException("Malloc failed.")
                }

                try {
                    sizePtr.write(Linger.size)
                    getSocketOption(SOL_SOCKET, SOCK_LINGER, CPointer(ptr), sizePtr)
                } finally {
                    LibC.free(sizePtr)
                }

                let lingerValue = ptr.read()

                match {
                    case lingerValue.enabled != 0 => Duration.second * Int64(lingerValue.seconds)
                    case _ => None
                }
            }
        }
    }

    func setLinger(newLinger: ?Duration): Unit {
        Linger.use<Unit> {
            ptr => unsafe {
                var lingerValue = match (newLinger) {
                    case Some(linger) => Linger(true,
                        linger.throwIfNegative("Linger").bumpAtLeast(Duration.second * 1).toSeconds())
                    case _ => Linger(false, 0)
                }
                ptr.write(lingerValue)

                setSocketOption(SOL_SOCKET, SOCK_LINGER, CPointer(ptr), Linger.size)
            }
        }
    }
}
