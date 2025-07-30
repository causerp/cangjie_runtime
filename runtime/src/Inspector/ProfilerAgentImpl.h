// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef INSPECTOR_PROFILERAGENTIMPL_H
#define INSPECTOR_PROFILERAGENTIMPL_H
namespace MapleRuntime {
using SendMsgCB = std::function<void(const std::string& message)>;
void ProfilerAgentImpl(const std::string &message, SendMsgCB sendMsg);
}

#endif
