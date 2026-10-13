---
'@lh-ui/harmony': patch
---

ohpm 包名按 D22 统一为反域名 `top.lhgb.ui.harmony`（废弃 npm 风格 `@lh-ui/harmony`）。

非 npm 平台发包标识统一为「groupId `top.lhgb.ui` + 平台名」
（Maven `top.lhgb.ui:android`、ohpm `top.lhgb.ui.harmony`、NuGet `Top.Lhgb.Ui.Windows`），
见 `docs/发包流程.md` §十四。仓内全量同步，须本地 DevEco 编译 + hypium 回归：

- `oh-package.json5` 包名 + `entry/oh-package.json5` 依赖键（含 license MIT→Apache-2.0）
- entry 演示应用与 14 份 hypium 测试共 18 处 `from 'top.lhgb.ui.harmony'`
- README / AGENTS.md / `docs/guide/installation.md` / docsui 文档页的安装与引用示例
- 仓内 `package.json` 的 `@lh-ui/harmony` 保持不动（`private: true` 工具链身份，从不发包，
  改名会让既有 changeset 孤立）
