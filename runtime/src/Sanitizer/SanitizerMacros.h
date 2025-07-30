// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef CANGJIERUNTIME_SANITIZERMACROS_H
#define CANGJIERUNTIME_SANITIZERMACROS_H

// definitions copy from linux/syscalls.h
// these defs are needed to expand function param declaration

// ARG_MAP0 is a special macro for functions has no args
#define ARG_MAP0(m, t, a, ...) m(t,)
#define ARG_MAP1(m, t, a, ...) m(t, a)
#define ARG_MAP2(m, t, a, ...) m(t, a), ARG_MAP1(m, __VA_ARGS__)
#define ARG_MAP3(m, t, a, ...) m(t, a), ARG_MAP2(m, __VA_ARGS__)
#define ARG_MAP4(m, t, a, ...) m(t, a), ARG_MAP3(m, __VA_ARGS__)
#define ARG_MAP5(m, t, a, ...) m(t, a), ARG_MAP4(m, __VA_ARGS__)
#define ARG_MAP6(m, t, a, ...) m(t, a), ARG_MAP5(m, __VA_ARGS__)
#define ARG_MAP(n, ...) ARG_MAP##n(__VA_ARGS__)

#define ARG_DECL(t, a) t a
#define ARG_TYPE(t, a) t
#define ARG_NAME(t, a) a

#define FUNC_TYPE(x) x##_type
#define SANITIZER_FUNC_TYPE(x) ::MapleRuntime::Sanitizer::FUNC_TYPE(x)
#define PTR_TO_REAL(x) x##_fn
#define REAL(x) ::MapleRuntime::Sanitizer::PTR_TO_REAL(x)
#endif // CANGJIERUNTIME_SANITIZERMACROS_H
