/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

import std.binary.SwapEndianOrder
import std.collection.HashSet
import std.sort.sort

const AI_PASSIVE: Int32 = 0x00000001i32
const AI_ALL: Int32 = 0x00000100
const DOMAIN_MAX_LEN = 255
const SUB_DOMAIN_LIST_LEN = 63

func isDomainValid(domainStr: String): Bool {
    if (domainStr.size > DOMAIN_MAX_LEN) {
        return false
    }
    let domainList = domainStr.split(".")
    var numberPartCnt = 0
    for (domain in domainList) {
        if (domain.isEmpty() || domain.size > SUB_DOMAIN_LIST_LEN || domain.startsWith("-") || domain.endsWith("-")) {
            return false
        }
        var isNumber = true
        for (b in domain) {
            if (!(b.isAsciiNumberOrLetter() || b == b'-')) {
                return false
            }
            if (isNumber && !b.isAsciiNumber()) {
                isNumber = false
            }
        }
        if (isNumber) {
            numberPartCnt++
        }
    }
    // reject the evil domain which looks like ip
    if (numberPartCnt == domainList.size) {
        return false
    }
    return true
}

/**
 * @throws IllegalFormatException while domain contains null character.
 */
func resolveDomain(family: AddressFamily, domain: String): Array<IPAddress> {
    if (domain.contains(NULL_BYTE)) {
        throw IllegalFormatException("Domain cannot contain null character!")
    }
    var node = unsafe { LibC.mallocCString(domain) }
    var res = PAddrinfo()
    var hints = AddrInfo()
    hints.ai_family = Int32(family.value)
    hints.ai_flags = AI_PASSIVE | AI_ALL
    var rc = unsafe { getaddrinfo(node, CPointer<Byte>(), PAddrinfo(), inout res) }
    unsafe { LibC.free(node) }
    if (rc != 0) {
        unsafe { LibC.free(res) }
        return []
    }
    let ips = HashSet<IPAddress>()
    var rp = res
    while (rp.isNotNull()) {
        var ai = unsafe { rp.read() }
        // offset of ai_addr in struct AddrInfo differs on different platform
        // so we get the value of ai_addr from c code
        let ai_addr = unsafe { CJ_SOCKET_GetAddrFromAddrinfo(rp) }
        rp = ai.ai_next
        if (ai_addr.isNull()) {
            continue
        }
        if (ai.ai_family == Int32(AddressFamily.INET.value)) {
            if (UIntNative(ai.ai_addrlen) != sizeOf<SockAddrIn>()) {
                continue
            }
            let ai4 = unsafe { CPointer<SockAddrIn>(ai_addr).read() }
            ips.add(IPv4Address(ai4.addr.swapBytes()))
        } else if (ai.ai_family == Int32(AddressFamily.INET6.value)) {
            if (UIntNative(ai.ai_addrlen) != sizeOf<SockAddrIn6>()) {
                continue
            }
            let u8_arr16 = Array<Byte>(16, repeat: 0)
            for (i in 0..16) {
                u8_arr16[i] = unsafe { (ai_addr + i + 8).read() }
            }
            ips.add(IPv6Address(u8_arr16))
        }
    }
    unsafe { freeaddrinfo(res) }
    let iparr = ips.toArray()
    sort<IPAddress>(iparr, by: sortIPAddr, stable: true)
    return iparr
}

func sortIPAddr(lhs: IPAddress, rhs: IPAddress): Ordering {
    match ((lhs, rhs)) {
        case (_: IPv4Address, _: IPv4Address) => Ordering.EQ
        case (_: IPv4Address, _: IPv6Address) => Ordering.LT
        case (_: IPv6Address, _: IPv4Address) => Ordering.GT
        case _ => Ordering.EQ
    }
}
