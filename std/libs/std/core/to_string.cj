/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

/**
 * This file introduces 'ToString' interface, which has a 'toString' function declaration.
 * 'toString' function is used to provide string representation for various types.
 * For primitive types, we provide standard toString implementation. For composite types
 * or user-defined types, they have to to implement toString function by themselves.
 */
public interface ToString {
    func toString(): String
}

extend Int64 <: ToString {
    @OverflowWrapping
    public func toString(): String {
        let (numLen, unum, buffer) = if (this < 0) {
            let unum = UInt64(-this)
            let numLen = 1 + calcNumLen(unum)
            let buffer = Array<Byte>(numLen, repeat: 0)
            buffer[0] = b'-'
            (numLen, unum, buffer)
        } else {
            let numLen = calcNumLen(UInt64(this))
            (numLen, UInt64(this), Array<Byte>(numLen, repeat: 0))
        }
        numberToString(unum, numLen, buffer)
        return String(buffer)
    }
}

extend IntNative <: ToString {
    @OverflowWrapping
    public func toString(): String {
        return Int64(this).toString()
    }
}

extend Int32 <: ToString {
    public func toString(): String {
        return Int64(this).toString()
    }
}

extend Int16 <: ToString {
    public func toString(): String {
        return Int64(this).toString()
    }
}

extend Int8 <: ToString {
    public func toString(): String {
        return Int64(this).toString()
    }
}

extend UInt64 <: ToString {
    public func toString(): String {
        let numLen = calcNumLen(this)
        let buffer = Array<Byte>(numLen, repeat: 0)
        numberToString(this, numLen, buffer)
        return String(buffer)
    }
}

extend UIntNative <: ToString {
    @OverflowWrapping
    public func toString(): String {
        return UInt64(this).toString()
    }
}

extend UInt32 <: ToString {
    public func toString(): String {
        return UInt64(this).toString()
    }
}

extend UInt16 <: ToString {
    public func toString(): String {
        return UInt64(this).toString()
    }
}

extend UInt8 <: ToString {
    public func toString(): String {
        return UInt64(this).toString()
    }
}

extend Float64 <: ToString {
    public func toString(): String {
        let p: CPointer<UInt8> = unsafe { CJ_CORE_Float64ToCPointer(this) }
        if (p.isNull()) {
            return String()
        }
        let s: String = unsafe { createStrFromCPointer(p) }
        unsafe { LibC.free(p) }
        return s
    }
}

extend Float32 <: ToString {
    public func toString(): String {
        return Float64(this).toString()
    }
}

extend Float16 <: ToString {
    public func toString(): String {
        return Float64(this).toString()
    }
}

extend Bool <: ToString {
    public func toString(): String {
        return if (this) {
            "true"
        } else {
            "false"
        }
    }
}

extend Rune <: ToString {
    public func toString(): String {
        return String([this])
    }
}

extend Unit <: ToString {
    public func toString(): String {
        return "()"
    }
}
