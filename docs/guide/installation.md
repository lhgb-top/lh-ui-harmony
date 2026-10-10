# 安装

## 环境要求

- DevEco Studio 5.0+（HarmonyOS NEXT SDK，compatibleSdkVersion 5.0.0(12)）
- 构建期工具链：Node.js >= 20 + pnpm（仅令牌连接与文档站使用，**不进入运行时**）

## ohpm 引入（nM6 发包链路打通后）

```bash
ohpm install @lh-ui/harmony
```

```json5
// oh-package.json5
{
  "dependencies": {
    "@lh-ui/harmony": "^0.0.1"
  }
}
```

## 源码集成（当前阶段）

家族布局下直接引用本仓模块（DevEco 打开 `lh-ui-harmony` 工程即可）：

```
lh-ui-harmony/
├── common/theme/        # LhTheme（AppStorage 注入）
├── components/button/   # LhButton 组件
├── entry/               # 演示应用（全形态展示 + 明暗切换）
└── tokens/              # 生成物（见下）
```

## 同步令牌

令牌是生成物，必须从 `lh-ui-core` 同步（唯一真源，禁止手改）：

```bash
cd ../lh-ui-core && pnpm codegen   # 生成 dist/harmony 令牌产物
cd ../lh-ui-harmony
pnpm install                        # 安装构建期工具链
pnpm link:tokens                    # 同步令牌到 tokens/
```

`pnpm link:tokens` 带三级存在性守卫：本地 `../lh-ui-core/dist/harmony` → npm `@lh-ui/core` 产物 → 报错。

## 验证安装

```bash
# DevEco Studio 打开工程后：
# Build → Build Hs/Hap（编译）
# 右键 tests → Run Tests（hypium 黄金用例）
```
