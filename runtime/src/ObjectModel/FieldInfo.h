// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_FIELDINFO_H
#define MRT_FIELDINFO_H

#include "Common/TypeDef.h"
#include "Common/Dataref.h"

namespace MapleRuntime {
class TypeInfo;
class ATTR_PACKED(4) InstanceFieldInfo {
public:
    const char* GetName(TypeInfo* declaringTypeInfo) const;
    U32 GetModifier() const;
    TypeInfo* GetFieldType(TypeInfo* declaringTypeInfo);

    void* GetValue(TypeInfo* declaringTi, ObjRef obj);
    void SetValue(TypeInfo* declaringTi, ObjRef instanceObj, ObjRef newValue);
    void* GetAnnotations(TypeInfo* arrayTi);
private:
    inline U32 GetOffset(TypeInfo* declaringTypeInfo) const;
    I32 modifier;
    U32 fieldIdx;
    Uptr annotationMethod;
};

class ATTR_PACKED(4) StaticFieldInfo {
public:
    const char* GetName() { return fieldName.GetDataRef(); }
    U32 GetModifier() { return modifier; }
    TypeInfo* GetFieldType() { return fieldTypeInfo; }
    void* GetValue();
    void SetValue(ObjRef newValue);
    void* GetAnnotations(TypeInfo* arrayTi);

private:
    void* GetStructValue(ObjRef obj);
    DataRefOffset64<char> fieldName;
    U32 modifier;
    U32 __attribute__((unused)) slot;
    TypeInfo* fieldTypeInfo;
    Uptr addr;
    U64 annotationMethod;
};
} // namespace MapleRuntime
#endif // MRT_FIELDINFO_H
