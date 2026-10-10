# lh-ui-harmony —— AGENTS.md

> ohpm `@lh-ui/harmony` · ArkTS + ArkUI（HarmonyOS NEXT）· **原生血脉**成员之一。
> 权威规范：本文件 > 家族根 `AGENTS.md` > 总纲 `docs/多端组件库规划.md`。

## 一、定位与血脉

- **原生血脉**：`lh-ui-core`（JSON 令牌 + 契约 + 黄金用例 + codegen）→ android / ios / harmony / c。
- 本仓是鸿蒙端 UI 层：**ArkTS + ArkUI 手写 UI**，运行时零 JS Web 运行时、零 npm 依赖。
- 与 web 血脉（`@lh-ui/share` → plus/vue2/react/uniapp）**互相独立、不得关联**（总纲 D13）。本仓不依赖
  `@lh-ui/share`，web 仓也不依赖本仓。视觉一致性靠《设计语言基线.md》人工对齐。
- 唯一外部令牌来源：core codegen 生成的 `LhTokens` / `LhDarkTokens` / `LhShadow`（`tokens/` 目录）。

## 二、目录职责

```
lh-ui-harmony/
├── oh-package.json5           # ohpm 清单（@lh-ui/harmony）
├── build-profile.json5        # 工程级编译配置
├── scripts/
│   ├── link-tokens.mjs        # 令牌本地连接（三级存在性守卫，D18）
│   └── gen-sim-tokens.mjs     # 文档模拟器令牌 CSS 生成（D19）
├── common/theme/
│   ├── LhTheme.ets            # LhColors 接口 + 明/暗色板工厂
│   └── LhThemeApply.ets       # AppStorage 注入工具（LhTheme.apply）
├── components/button/
│   ├── Index.ets              # LhButton 组件（ArkUI 手写）
│   └── LhButtonTokens.ets     # 类型枚举 + resolve 外观解析（黄金用例断言入口）
├── entry/                     # 演示应用（等价 dev 沙箱：全形态 + 明暗切换）
├── tokens/                    # 【生成物，gitignore】link-tokens 同步的 LhTokens/LhDarkTokens/LhShadow
├── tests/Button.test.ets      # hypium 黄金用例
├── docs/                      # VitePress 文档站（内联静态 HTML 模拟器，D19）
└── package.json               # 构建期工具脚本入口（非运行时）
```

## 三、红线

1. **令牌唯一源**：组件实现禁止出现任何色值 / 间距 / 圆角 / 字号字面量（`'#FF2B4C7C'`、`vp(40)`、
   字号数字等），只能引用 `LhTokens.Button.*` / `LhColors` 工厂。违例即 drift。
2. **core 生成的令牌文件禁止手改**：`tokens/` 是生成物（gitignore），改令牌去
   `lh-ui-core/tokens/*.json` → `pnpm codegen` → 本仓 `pnpm link:tokens`。
3. **只生成骨架不生成 UI**：core 不会、也不应生成任何 `@Component` 实现体；本仓的 ArkUI 组件全部手写。
4. **血脉隔离**：禁止 import 任何 `@lh-ui/share` / web 仓符号；本仓不发布到 npm。
5. **黄金用例对齐**：组件行为必须满足 `lh-ui-core/cases/<comp>.json`，并人工翻译为 hypium 测试。
6. **命名与 spec 对齐**（R-n5）：props 名严格沿用 `lh-ui-core/specs/<comp>.json` 的驼峰命名
   （`type` / `size` / `disabled` / `loading` / `icon` / `bgPattern`），不得自创 `variant` / `dimension` 等。

## 四、令牌消费机制（D18）

core 的 codegen 产物是 `LhTokens`（明）与 `LhDarkTokens`（暗）两个类（仅根类 export）。

- **暗色模型是并列对象**：`LhDarkTokens` 只含 `Color` 子类，尺寸类令牌暗色不覆盖
  （与 android/ios 一致；C 端是宏重定义覆盖，docs 端是浅合并）。主题层据此设计。
- **本地连接**：`pnpm link:tokens`（脚本带三级守卫：本地 `../lh-ui-core/dist/harmony` →
  npm `@lh-ui/core/dist/harmony` → 报错）。禁止把生成的令牌文件提交入库。
- **回退形态**：家族布局不存在时（CI 单仓 clone），`@lh-ui/core` npm 包的 `files:["dist"]`
  含四端产物。ohpm 令牌 HAR 回退在 nM6 打通后接入。

## 五、平台 gotcha

- **单位**：尺寸/字号是无单位数值（vp）；ArkUI 的 `vp()` 是恒等换算（数值即 vp）。
  暗色对象不含尺寸令牌，取尺寸时始终走明色对象。
- **时长单位是毫秒**：`Motion.Duration.base = 300`（iOS 是秒）。
- **色值表达**：`'#AARRGGBB'` 字符串（`ResourceColor`），带透明度前缀。
- **AppStorage 序列化**：`ResourceColor` 不在 AppStorage 类型白名单内，色板走 JSON 字符串
  （`LhTheme.apply` 序列化 / 组件 `JSON.parse` 还原）。
- **回调属性不加 @Prop**：ArkTS 装饰器不支持函数类型，`onClick` 用普通属性。
- **嵌套类无 export**：生成的令牌只有根类 `export class LhTokens`，嵌套 `class Color` 等不带 export
  （类体内不允许 export 声明，core harmony target 已处理；引用旧产物若见 `export class` 嵌套即过期产物）。
- **圆角**：`Radius.circle` 是 0.5 分数，端侧取 `min(宽,高)/2` 换算，不能当 vp 用。
- **entry 即文档**：entry 演示应用是组件示例的第一现场，文档站 HTML 模拟器是第二现场。

## 六、命令速查

| 任务 | 命令 | 说明 |
| --- | --- | --- |
| 同步令牌 | `pnpm link:tokens` | 从 core dist 同步到本仓源码树（改令牌后必跑） |
| 令牌同步校验 | `pnpm link:tokens:check` | CI 门禁：检测令牌是否已同步 |
| 构建 | DevEco：Build → Build Hs/Hap | 编译（含 ArkTS 类型检查） |
| 单测 | DevEco：右键 tests → Run Tests | hypium 黄金用例（需 DevEco） |
| 文档 dev | `pnpm docs:dev` | 先 gen:sim 再起 VitePress（端口 5183） |
| 文档构建 | `pnpm docs:build` | 部署前跑，产物在 docs/.vitepress/dist |

## 七、Read before touching sensitive areas

- 改 `LhTheme.ets`：先读 core 的 `dist/harmony/tokens/LhDarkTokens.ets`，确认暗色覆盖范围
  （只 Color，不含尺寸），否则主题层取尺寸会拿到错误对象。
- 改 `LhButtonTokens.ets`：先读 `../../lh-ui-core/specs/button.json` 的 behaviors 与 tokenRefs，
  令牌绑定必须逐条对齐；黄金用例（`cases/button.json`）会断言这些映射。
- 改 `scripts/*.mjs`：守卫逻辑改动影响四仓统一机制，先读 core 的
  `scripts/resolve-local-tokens.mjs` 与总纲 D18。
- 加新组件：先在 core 仓写 `specs/<comp>.json` + `cases/<comp>.json`（codegen 不生成 UI），
  再本仓建 `components/<comp>/`，翻译黄金用例为 hypium 测试。
