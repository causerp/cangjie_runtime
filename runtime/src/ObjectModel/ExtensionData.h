// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_EXTENSION_DATA_H
#define MRT_EXTENSION_DATA_H

#include "Common/TypeDef.h"
#include "MClass.inline.h"

namespace MapleRuntime {
class ATTR_PACKED(4) ExtensionData {
public:
    bool TargetIsTypeInfo() const { return argNum == 0; }
    void* GetTargetType() const
    {
        if (argNum == 0) {
            return ti;
        }
        return tt;
    }
    TypeInfo* GetInterfaceTypeInfo(U32 argsNum = 0U, TypeInfo** args = nullptr) const;
    FuncPtr GetWhereCondFn() const { return whereCondFn; }
    FuncPtr* GetFuncTable() const { return funcTable; }
    void UpdateFuncTable(U16 ftSize, FuncPtr* newFt) { funcTableSize  = ftSize; funcTable = newFt; }
    U16 GetFuncTableSize() const { return funcTableSize; }
    bool IsDirect() const { return flag & 0b10000000; }
    bool HasOuterTiFastPath() const { return (flag & 0b1) != 0; } // "bit-0 is 1" means codegen has computed the outer ti.
    TypeInfo* GetOuterTi(TypeInfo* childTi, U64 index) const
    {
        CHECK(index < funcTableSize);
        if (!HasOuterTiFastPath()) {
            return nullptr;
        }
        if (!IsTargetHasSameSourceWith(childTi)) {
            for (auto pair : childTi->GetMTableDesc()->mTable) {
                auto superTi = pair.second.GetSuperTi();
                if (IsTargetHasSameSourceWith(superTi)) {
                    void* fn = reinterpret_cast<void*>(whereCondFn);
                    bool matched = fn == nullptr ||
                        reinterpret_cast<uintptr_t>(TypeTemplate::ExecuteGenericFunc(
                            fn, superTi->GetTypeArgNum(), superTi->GetTypeArgs())) & 0x1;
                    if (matched) {
                        childTi = superTi;
                        break;
                    }
                }
            }
        }
        bool isConcrete = (argNum == 0);
        OuterTiUnion* outerTiUnionStart = reinterpret_cast<OuterTiUnion*>(
            reinterpret_cast<uint8_t*>(funcTable) + sizeof(FuncPtr) * funcTableSize);
        return isConcrete ? outerTiUnionStart[index].outerTypeInfo : outerTiUnionStart[index].outerTiFunc == nullptr ?
            nullptr : outerTiUnionStart[index].outerTiFunc(childTi);
    }

    bool IsTargetHasSameSourceWith(TypeInfo *ti) const
    {
        if (!ti->IsGenericTypeInfo() && TargetIsTypeInfo()) {
            return ti->GetUUID() == static_cast<TypeInfo*>(GetTargetType())->GetUUID();
        }
        if (ti->IsGenericTypeInfo() && !TargetIsTypeInfo()) {
            return ti->GetSourceGeneric()->GetUUID() ==
                static_cast<TypeTemplate*>(GetTargetType())->GetUUID();
        }
        return false;
    }

private:
    U32 argNum;
    U8 isInterfaceTypeInfo;
    // optimization: use 1 byte to speed up the search of mtable.
    U8 flag;
    U16 funcTableSize;
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
