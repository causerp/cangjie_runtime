// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_EXTENSION_DATA_H
#define MRT_EXTENSION_DATA_H

#include "Common/TypeDef.h"
#include "MClass.h"

namespace MapleRuntime {
class ATTR_PACKED(4) ExtensionData {
public:
    bool TargetIsTypeInfo() { return argNum == 0; }
    void* GetTargetType() const
    {
        if (argNum == 0) {
            return ti;
        }
        return tt;
    }
    TypeInfo* GetInterfaceTypeInfo(U32 argsNum = 0U, TypeInfo** args = nullptr) const
    {
        if (isInterfaceTypeInfo) {
            return interfaceTypeInfo;
        }
        void* iFn = reinterpret_cast<void*>(interfaceFn);
        TypeInfo* itf = reinterpret_cast<TypeInfo*>(TypeTemplate::ExecuteGenericFunc(iFn, argsNum, args));
        return itf;
    }
    FuncPtr GetWhereCondFn() const { return whereCondFn; }
    FuncPtr* GetFuncTable() const { return funcTable; }

private:
    U32 argNum;
    U8 isInterfaceTypeInfo;
    // optimization: use 1 byte to speed up the search of mtable.
    U8 __attribute__((unused)) padding[3] { 0 }; // 3 bytes padding
    union {
        TypeTemplate* tt;
        TypeInfo* ti;
    };
    union {
        FuncPtr interfaceFn;
        TypeInfo* interfaceTypeInfo;
    };
    FuncPtr whereCondFn;
    FuncPtr* funcTable;
};
} // namespace MapleRuntime
#endif // MRT_EXTENSION_DATA_H
