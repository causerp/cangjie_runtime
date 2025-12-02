// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_TYPEEXT_H
#define MRT_TYPEEXT_H

namespace MapleRuntime {
class ATTR_PACKED(4) TypeExt {
public:
    union {
        TypeTemplate* tt;
        TypeInfo* ti;
    };
    U16 version;
    U16 padding;
    U32 size;
    U8 content[];
};
} // namespace MapleRuntime

#endif // MRT_TYPEEXT_H
