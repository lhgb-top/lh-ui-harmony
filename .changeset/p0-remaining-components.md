---
'@lh-ui/harmony': minor
---

P0 剩余 13 个组件全链路落地 + text 组件补齐 + entry/tests 模块工程化 + 6 项 bug 修复。

## 组件

- icon / tag / cell / input / textarea / checkbox / radio / switch / loading / dialog / toast / picker / navbar：每个组件两件套（`Lh<Comp>Tokens.ets` 外观解析纯函数 + `Index.ets` ArkUI 手写实现），props 与 `lh-ui-core/specs/<comp>.json` 逐字对齐，13 份黄金用例翻译为 hypium 测试。
- **text 组件**（core 契约早已存在、三端皆缺的实现缺口）：`LhText` 消费全局排版令牌（level / weight / tone / align），零组件级令牌（tokenRefs 全是全局 typography / color），5 条黄金用例翻译为 `Text.test.ets`。P0 至此全 15 组件齐备。

## 模块工程化

- entry 成为正式 DevEco 模块：新增 `entry/oh-package.json5`（`@lh-ui/harmony: file:../`）与 `entry/build-profile.json5`，根 `build-profile.json5` 的 modules 补 targets 声明；
- entry 与测试的 import 从跨模块边界的相对路径统一改为 `@lh-ui/harmony` 包名；
- 仓根 `Index.ets` 补令牌再导出（`LhTokens` / `LhDarkTokens` / `LhShadow`）与漏掉的 `LhCheckboxMark`；
- 测试从仓根 `tests/` 迁入 `entry/src/test/`（hvigor 自动发现位置），删除已无必要的聚合入口 `tests/Index.test.ets`；`@ohos/hypium` 随之移到 entry 模块的 devDependencies。

## Bug 修复

- `EntryAbility` 的 import 深度错误（`../../../` 实际指向不存在的 `entry/src/common/`），由包名导入消除；
- `LhIcon` 的 `name` prop 缺 `@Watch`，宿主运行时改图标名时停留在旧字形；
- `LhCellTokens.resolve` 删除从未使用的 `hasIcon` 死参数（组件与测试共 13 处调用点同步）；
- `link-tokens --check` 由「比文件数」升级为「比文件名集合 + 逐文件字节内容」——新守卫当场抓出并修复了一处真实令牌漂移（core 新增的 `textarea.textInset` 未同步到本仓，文件数不变所以旧守卫毫无察觉）；
- 补齐缺失的 `$media:app_icon` 资源（`scripts/gen-app-icon.mjs` 从 core 令牌读品牌色生成 216×216 图标）与 `AppScope/resources` 的 `app_name` 字符串；
- 修正家族计划文档滞后的里程碑记录。

## 文档

- 15 个组件页（契约源 → 内联 HTML 模拟器 → API → 枚举 → 令牌对照 → 黄金用例对照），`harmony.css` 补齐 `.sim-text` 系列，全部 `var(--lh-*)`，`sim:check` / `docs:build` 通过。
- 黄金用例对照表的测试路径随测试迁移更新为 `entry/src/test/`。
