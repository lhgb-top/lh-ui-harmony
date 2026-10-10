# 介绍

**lh-ui-harmony** 是 lh-ui 家族**原生血脉**的鸿蒙端实现：基于 **ArkTS + ArkUI**（HarmonyOS NEXT 原生）的 UI 组件库。

## 家族中的位置

```
                        ┌── web 血脉：share（TS core + SCSS）→ plus / vue2 / react / uniapp
lh-ui 家族（同品牌）─────┤
                        └── 原生血脉：core（JSON 令牌 + 契约 + codegen）→ android / ios / harmony / c
                                                                    ↑ 本仓
```

- **构建期中心**：`lh-ui-core` 是原生血脉的令牌真源（`tokens/*.json`）、组件契约（`specs/`）、黄金用例（`cases/`）与 codegen 工具。它生成 ArkTS 令牌骨架（`LhTokens` / `LhDarkTokens` / `LhShadow`），**不生成任何组件实现**。
- **本仓职责**：手写 ArkUI 组件、主题接入（AppStorage 注入）、props 枚举与默认值绑定、把黄金用例翻译为 hypium 测试。
- **与 web 血脉互相独立**：不依赖 `@lh-ui/share`，发版互不约束。视觉一致性靠《设计语言基线》人工对齐。

## 设计语言

国风主题：青花瓷蓝主色（`#2B4C7C`）、宣纸白底（`#FAF6F0`）、松花绿成功、藤黄警告、朱砂危险，衬线字体栈（Noto Serif SC → STSong → SimSun）。所有视觉值都是令牌，组件不出现任何字面量。

## 为什么是 ArkUI

- HarmonyOS NEXT 的一等公民声明式 UI，与 Compose / SwiftUI 心智同构，跨端契约容易对齐
- 无 Web 运行时、无 HTML/CSS 桥接，原生性能
- ohpm 分发（HAR/HSP），DevEco Studio 一键集成

## 当前状态

- **button 全链路打样已交付**（令牌消费 + resolveAppearance 外观解析 + ArkUI 组件 + hypium 测试 + entry 演示应用 + 文档站）
- P0 其余 13 个组件（icon / input / textarea / cell / checkbox / radio / switch / tag / dialog / toast / loading / picker / navbar）按同范式后续补齐
