---
'@lh-ui/harmony': minor
---

新增原生文档模块 docsui：md 驱动的真交互文档宿主（照 android `:docsui` 范式），网页 HTML 模拟器之外的第一现场。

## 模块

- `docsui/`（库内组件，barrel 导出 `LhDocs`）：宿主 `LhDocsPage.ets` 自管返回栈、顶栏 dogfood `LhNavbar`、明暗切换 dogfood `LhTheme.apply`、全局反馈 dogfood `LhToast`（宿主 `LhToastController` 注入各预览）；首页按分组的文档索引 dogfood `LhCell` / `LhText`。
- `docsui/model/` + `docsui/widgets/`：`DocPalette` 封装 `LhTokens.Docs.*` / `LhDarkTokens.Docs.*` / `LhColors` 取值；标题 / 正文 / 契约卡片 / 代码块 / 表格（`Row + layoutWeight`）/ 预览框五件套，全部零字面量。
- `docsui/previews/`：15 个文件、38 个 `{Comp}{Scene}Preview` 手写真交互预览，覆盖全部 15 组件的可交互形态（受控表单态、dialog / picker 声明式浮层、toast 三定位指令式演示、全局明暗热重绘）。

## 生成链

- `scripts/gen-doc-pages.mjs`：`docs/**/*.md` → `docsui/pages/*.ets`（20 页）+ `DocRegistry.ets` + `DocPageDispatch.ets`，全部带「禁手改」文件头；解析约定与 android / ios / windows 同名脚本对齐（`#` 标题、`>` 契约、`##` 分节、`###` 子标题表、`|` 表格、代码块、`<div>`/`<p>`/`:::` 跳过），`SCENE_MAP` 把 md 的 `##` 标题映射为预览结构体后缀；散文与表格单元在生成期剥离反引号与 `**`（ArkUI 的 `Text` 不解析 markdown）。
- `scripts/check-docs.mjs` + `pnpm docs:check`：CI 门禁——生成页引用与手写预览双向一致、docsui 全树无未用 import、注册表 / 分发层登记齐全。
- 仓根 `Index.ets` 补 `LhDocs` 与数据模型导出；`package.json` 加 `gen:docs` / `docs:check`。
- AGENTS.md 登记 docsui 目录职责、红线 8（生成物禁手改 + docsui 零字面量）、新增组件的 docsui 同步点、ArkUI 落点 gotcha（builder 尾随闭包、预览必须声明 `toast` 属性、`Dimension | number` 算术收窄）与敏感区条目。

⚠ 验证缺口：本机无 DevEco，ArkTS 无类型级校验条件；已对生成器与全树做静态一致性校验（`pnpm docs:check` 绿：38 预览双向一致、20 页登记齐全、无未用 import，且 docsui 内全部组件属性调用均核对过声明）。编译级验证留待 DevEco 宿主。
