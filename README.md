# lh-ui-harmony

> lh-ui 家族 · 原生血脉 · 鸿蒙端 —— **ArkTS + ArkUI**（HarmonyOS NEXT）UI 组件库（ohpm `top.lhgb.ui.harmony`）。
>
> 同品牌的设计令牌、组件契约与黄金用例定义在 `lh-ui-core`（构建期中心，移动端运行时零 JS）；
> 本仓只手写 ArkUI 组件。与 web 血脉（plus / vue2 / react / uniapp）互相独立、不共享运行时代码，
> 视觉一致性靠《设计语言基线》人工对齐。

## 特性

- **国风设计语言**：青花瓷蓝主色、宣纸白底、藤黄朱砂点缀，衬线字体栈（由 core 令牌驱动）。
- **令牌驱动**：组件零硬编码色值/间距，全部消费 codegen 生成的 `LhTokens` / `LhDarkTokens`。
- **明暗双主题**：`LhTheme.apply(isDark)` 一行切换（AppStorage 注入），暗色令牌由 core 预计算。
- **契约一致**：props 命名与 `lh-ui-core/specs` 逐条对齐，四端 + web 行为共享。
- **黄金用例**：`cases/button.json` 的 8 条断言翻译为 hypium 测试（DevEco 一键回归）。

## 快速开始

### 1. 同步令牌（本地连接）

```bash
cd ../lh-ui-core && pnpm codegen   # 生成 dist/harmony 令牌产物
cd ../lh-ui-harmony
pnpm install && pnpm link:tokens   # 同步令牌到 tokens/（生成物，gitignore）
```

### 2. 使用组件

```typescript
import { LhButton } from '../components/button/Index'
import { LhButtonType } from '../components/button/LhButtonTokens'
import { LhTheme } from '../common/theme/LhThemeApply'

LhTheme.apply(false) // 注入明色板

LhButton({
  onClick: () => { /* ... */ },
  type: LhButtonType.Primary,
  text: '主要按钮',
})
```

### 3. 演示应用

DevEco Studio 打开本仓工程，直接运行 `entry` —— 全形态展示 + 明暗切换开关。

## 文档

```bash
pnpm docs:dev    # 本地文档站（含 HTML 模拟器预览），端口 5183
```

组件示例预览说明：原生 UI 无法在浏览器实时渲染，文档站用**内联静态 HTML 手机框模拟器**
展示外观效果（样式由 core 令牌快照生成的 CSS 变量驱动，与真机同源同值）。真机外观以
entry 演示应用与设备截图为准。

## 仓库规范

见 [AGENTS.md](./AGENTS.md)（本仓权威规范：目录职责、红线、命令、gotchas）。

## 家族

| 成员 | 血脉 | 技术栈 |
| --- | --- | --- |
| lh-ui-share → plus / vue2 / react / uniapp | web | TS core + SCSS + 各框架 |
| lh-ui-core → android / ios / **harmony** / windows | 原生 | JSON 令牌 + codegen → 各端原生 |
