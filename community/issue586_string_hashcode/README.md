<!--
  Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
  This source file is part of the Cangjie project, licensed under Apache-2.0
  with Runtime Library Exception.

  See https://cangjie-lang.cn/pages/LICENSE for license information.
-->

# Issue #586 String.hashCode — 方案 A 性能测试用例

社区学习赛高级任务交付物（方案 A：证明当前实现不存在 Issue 所述的多倍缓慢）。

- Issue: https://atomgit.com/Cangjie/cangjie_runtime/issues/586
- 方案：A（可运行性能测试；不修改 `@Frozen` / `@ConstSafe` 的 `String` 布局）

## 如何运行

依赖已安装的仓颉 SDK（建议 ≥ 1.1.3），`cjc` 在 `PATH` 中。

```bash
cd community/issue586_string_hashcode
cjc -O2 -Woff unused --output issue586_bench src/main.cj
./issue586_bench
```

或：

```bash
cd community/issue586_string_hashcode
cjpm build -V && cjpm run
```

## 用例做了什么

1. **Issue 同形状负载**：262144 条长度 2–20 的短串，XOR 全部 `hashCode()`，报告单轮耗时（µs/ms）。
2. **缓存对照**：同一批串预计算 hash 后再 XOR，模拟 Java JMH warmup 后读缓存字段的行为。
3. **单次调用粗估**：`per_hashCode_ns`。

## 结论口径

Issue 中 Cangjie 1.0.4 为 ~10.60 ms，Java 17（warmup 后）为 ~1.223 ms。  
本用例在较新 SDK 上复现「重算」路径；并量化「重算 vs 读缓存」差距，说明历史多倍差距主要来自 **Java hash 缓存 + JMH warmup 口径**，而非当前 `wyhash` 实现异常缓慢。仓颉 `String` 为 `@ConstSafe` struct，不能像 Java 那样加可变 hash 字段而不破坏兼容性/常量语义。

## 本机参考结果（cjc 1.1.3, aarch64-darwin）

见提交说明 / PR 描述中的运行摘录；不同机器数值会有波动，但量级应接近 Issue 中的 Java 数字，并显著快于 Issue 中的 1.0.4 数字。
