# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.


add_subdirectory(native)


set(STD_NET_SRCS
    ip_addess.cj
    ip_prefix.cj
    ip_socket_address.cj
    ipv4_address.cj
    ipv6_address.cj
    result.cj
    rune_ext.cj
    socket_address.cj
    unix_socket_address.cj
    uint128.cj
    address_family.cj
    dns.cj
    ip_address_ffi.cj
    linger.cj
    socket_ffi.cj
    socket_ffi_sockaddr.cj
    socket_enum.cj
    socket_util.cj
    socket_exception.cj
    socket_raw_enum.cj
    socket_keep_alive.cj
    socket_holder.cj
    socket_state.cj
    socket_api.cj
    socket_options.cj
    mutex.cj
    tcp.cj
    tcp_server.cj
    udp.cj
    unix.cj
    unix_datagram.cj
    socket_impl_common.cj
    CACHE INTERNAL "")

if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    set(CJNATIVE_STD_NET_SRCS
        ${STD_NET_SRCS}
        socket_buffer.cj
        socket_ffi_cjnative.cj
        socket_ffi_cjnative_impl.cj
        socket_raw_cjnative.cj
        CACHE INTERNAL "")
endif()
