// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_IMMORTAL_WRAPPER_H
#define MRT_IMMORTAL_WRAPPER_H

#include <new>
#include <utility>

namespace MapleRuntime {
// utility class to avoid un-ordered static global destruction
template<class T>
class ImmortalWrapper {
public:
    using pointer = typename std::add_pointer<T>::type;
    using lref = typename std::add_lvalue_reference<T>::type;

    template<class... Args>
    ImmortalWrapper(Args&&... args)
    {
        new (buffer) T(std::forward<Args>(args)...);
    }
    ImmortalWrapper(const ImmortalWrapper&) = delete;
    ImmortalWrapper& operator=(const ImmortalWrapper&) = delete;
    ~ImmortalWrapper() = default;
    inline pointer operator->() { return reinterpret_cast<pointer>(buffer); }

    inline lref operator*() { return reinterpret_cast<lref>(buffer); }

private:
    alignas(T) unsigned char buffer[sizeof(T)] = { 0 };
};
} // namespace MapleRuntime
#endif // MRT_IMMORTAL_WRAPPER_H
