# lh-ui-harmony —— AGENTS.md

> ohpm `top.lhgb.ui.harmony` · ArkTS + ArkUI（HarmonyOS NEXT）· **原生血脉**成员之一。
> 权威规范：本文件 > 家族根 `AGENTS.md` > 总纲 `docs/多端组件库规划.md`。

## 一、定位与血脉

- **原生血脉**：`lh-ui-core`（JSON 令牌 + 契约 + 黄金用例 + codegen）→ android / ios / harmony / windows。
- 本仓是鸿蒙端 UI 层：**ArkTS + ArkUI 手写 UI**，运行时零 JS Web 运行时、零 npm 依赖。
- 与 web 血脉（`@lh-ui/share` → plus/vue2/react/uniapp）**互相独立、不得关联**（总纲 D13）。本仓不依赖
  `@lh-ui/share`，web 仓也不依赖本仓。视觉一致性靠《设计语言基线.md》人工对齐。
- 唯一外部令牌来源：core codegen 生成的 `LhTokens` / `LhDarkTokens` / `LhShadow`（`tokens/` 目录）。

## 二、目录职责

```
lh-ui-harmony/
├── oh-package.json5           # ohpm 清单（top.lhgb.ui.harmony），main 指向仓根 Index.ets
├── build-profile.json5        # 工程级编译配置（strictMode + useNormalizedOHMUrl）
├── Index.ets                  # ohpm 包入口：聚合导出全部组件 / 枚举 / 主题工具 / 令牌类（只导出不实现）
├── scripts/
│   ├── link-tokens.mjs        # 令牌本地连接（三级存在性守卫 + 逐文件字节比对，D18）
│   ├── gen-sim-tokens.mjs     # 文档模拟器令牌 CSS 生成（D19）
│   ├── gen-app-icon.mjs       # entry 应用图标生成（读 core 令牌品牌色，构建期）
│   ├── gen-doc-pages.mjs      # md → ArkTS 原生文档页生成（docsui 的 pages/，禁手改）
│   ├── check-sim-vars.mjs     # 模拟器 var(--lh-*) 变量名守卫（CI 门禁）
│   └── check-docs.mjs         # docsui 一致性守卫（预览双向一致 + 无未用 import，CI 门禁）
├── common/
│   ├── LhVp.ets               # lhVp：尺寸令牌数值 → Length 的类型收窄（调用点标明「消费令牌」）
│   └── theme/
│       ├── LhTheme.ets        # LhColors 接口 + LightLhColors / DarkLhColors 工厂 + AppStorage 键
│       └── LhThemeApply.ets   # LhTheme.apply / LhTheme.isDark 工具
├── components/<comp>/         # 每个组件两文件，职责固定：
│   ├── Index.ets              #   @Component struct（props 与 spec 逐字对齐，只画外观）
│   └── Lh<Comp>Tokens.ets     #   枚举 + LhAppearance 接口 + Lh<Comp>Tokens.resolve 纯函数
├── entry/                     # 演示应用模块（DevEco module）
│   ├── oh-package.json5       #   `top.lhgb.ui.harmony: file:../` 依赖仓根库
│   ├── build-profile.json5    #   模块级编译配置（stage 模型）
│   └── src/
│       ├── main/              #   Ability / pages / resources（含 media/app_icon.png）
│       └── test/              #   hypium 黄金用例（hvigor 自动发现 *.test.ets，无需聚合入口）
├── AppScope/resources/        # 应用级资源（app_name 字符串；app.json5 的 $string 指向这里）
├── tokens/                    # 【生成物，gitignore】link-tokens 同步的 LhTokens/LhDarkTokens/LhShadow
├── docsui/                    # 原生文档模块（照 android `:docsui` 范式，见本文「原生文档模块」）
│   ├── Index.ets              #   聚合导出 LhDocs（页面组件）+ 数据模型
│   ├── LhDocsPage.ets         #   宿主：手写返回栈 + LhNavbar dogfood + LhTheme 明暗切换 + 全局 LhToast
│   ├── model/DocModels.ets    #   DocGroup / DocEntry / DocSection / DocTable / DocRow
│   ├── widgets/               #   DocPalette（Docs 令牌组取色）+ 标题/正文/卡片/代码块/表格/预览框
│   ├── DocRegistry.ets        #   【生成物，禁手改】条目清单 + groups/byId/entriesInGroup
│   ├── DocPageDispatch.ets    #   【生成物，禁手改】id → 页面结构体分发
│   ├── pages/                 #   【生成物，禁手改】20 个文档页（md → ArkTS）
│   └── previews/              #   手写真交互预览（15 文件 / 38 个结构体）
├── docs/                      # VitePress 文档站（内联静态 HTML 模拟器，D19）
└── package.json               # 构建期工具脚本入口（非运行时）
```

**已落地组件**（15 个，按 `Index.ets` 的分组）：

- 基础：`button` / `icon` / `tag` / `cell` / `text`
- 表单：`input` / `textarea` / `checkbox` / `radio` / `switch` / `picker`
- 反馈：`dialog` / `toast` / `loading`
- 导航：`navbar`

P0 全 15 组件已齐备，无 spec / 实现缺口。text 只消费全局排版与颜色令牌（零组件级令牌）。

## 三、红线

1. **令牌唯一源**：组件实现禁止出现任何色值 / 间距 / 圆角 / 字号字面量（`'#FF2B4C7C'`、`vp(40)`、
   字号数字等），只能引用 `LhTokens.Button.*` / `LhColors` 工厂。违例即 drift。
   尺寸令牌经 `lhVp(...)` 收窄为 `Length`（`common/LhVp.ets`），它在运行时是恒等函数，
   存在的意义就是把「这里消费的是令牌数值」写在调用点上。
2. **core 生成的令牌文件禁止手改**：`tokens/` 是生成物（gitignore），改令牌去
   `lh-ui-core/tokens/*.json` → `pnpm codegen` → 本仓 `pnpm link:tokens`。
3. **只生成骨架不生成 UI**：core 不会、也不应生成任何 `@Component` 实现体；本仓的 ArkUI 组件全部手写。
4. **血脉隔离**：禁止 import 任何 `@lh-ui/share` / web 仓符号；本仓不发布到 npm。
5. **黄金用例对齐**：组件行为必须满足 `lh-ui-core/cases/<comp>.json`，并人工翻译为 hypium 测试。
6. **命名与 spec 对齐**（R-n5）：props 名严格沿用 `lh-ui-core/specs/<comp>.json` 的驼峰命名
   （`type` / `size` / `disabled` / `loading` / `icon` / `bgPattern`），不得自创 `variant` / `dimension` 等。
7. **新增组件必须同时更新三个聚合点**：仓根 `Index.ets`（导出组件 + 枚举 + resolve 类；
   测试与 entry 都经包名 `top.lhgb.ui.harmony` 导入，漏导出符号会直接编译失败）、
   `entry/src/test/<Comp>.test.ets`（hvigor 自动发现 `*.test.ets`，**不需要注册**；
   测试只能 import barrel 导出的符号）、
   `docs/.vitepress/config.ts` 的 `componentGroups`（侧边栏数据驱动，加一条才有文档入口）。
   另需同步：entry demo 的 `xxxSection()` 与 build 注册、`docs/components/<comp>.md`、
   `docs/.vitepress/theme/sim/harmony.css` 的 `.sim-<comp>` 样式。
   **docsui 也要同步**（见「原生文档模块」）：md 有新 `##` 分节时在 `gen-doc-pages.mjs` 的
   SCENE_MAP 登记 + `previews/{Comp}Previews.ets` 加 `{Comp}{Scene}Preview` 结构体，再跑 `pnpm gen:docs`。
8. **docsui 生成物禁手改**：`docsui/pages/*.ets`、`DocRegistry.ets`、`DocPageDispatch.ets` 由
   `scripts/gen-doc-pages.mjs` 从 `docs/**/*.md` 生成，改 md 后重跑 `pnpm gen:docs`，
   生成物带「禁手改」文件头。docsui 自身同样零字面量（红线 1）：颜色走 `DocPalette`
   （`LhTokens.Docs.*` + `LhDarkTokens.Docs.*` + `LhColors`），尺寸走 `lhVp(LhTokens.*)`。

## 三（补）、原生文档模块（docsui，照 android `:docsui` 范式）

网页站的 HTML 模拟器（`docs/`）是**第二现场**，docsui 是**真交互第一现场**：同一批 md
既渲染网页模拟器，也生成可真机交互的 ArkUI 文档页。四支柱落地：

- **① 令牌先行**：widgets 与宿主零外观字面量，全部取 `LhTokens.Docs.*`
  （`Card` / `Code` / `Heading` / `Prose` / `Table` 五组，暗色覆盖见 `LhDarkTokens.Docs`）
  与 `LhColors`（经 `@StorageProp(LH_COLORS_KEY)`，明暗热重绘）。
- **② 内容与预览分离**：`docs/**/*.md` → `pnpm gen:docs` → `pages/*.ets`（数据，禁手改）；
  预览手写在 `previews/{Comp}Previews.ets`（38 个 `{Comp}{Scene}Preview` 结构体）。
  md 的 `##` 标题经 `gen-doc-pages.mjs` 的 `SCENE_MAP` 映射为 Scene 后缀，挂接点是生成页里
  `DocSectionView({ section: ... }) { XxxPreview({ toast: this.toast }) }` 的尾随闭包——
  ArkUI 没有组件工厂，预览只能靠生成期把结构体名写进分发链（`DocPageDispatch`）。
- **③ 宿主零依赖**：本仓无 Router（entry demo 也是单页），宿主 `LhDocsPage.ets` 自管
  `@State pageStack` 返回栈；顶栏 dogfood `LhNavbar`；全局反馈 dogfood `LhToast`
  （宿主持 `LhToastController`，以普通属性注入每个预览；预览只通过该通道反馈，不自带浮层）。
  声明式浮层（dialog / picker）由各预览自身 Stack 承载，挂在预览框边界内（以 `DocPreviewFrame` 为舞台）。
- **④ 分发形态**：docsui 是**库内组件**，使用方在页面里 `import { LhDocs } from 'top.lhgb.ui.harmony'`
  后 `LhDocs()` 即可（主题初始化 `LhTheme.apply` 由宿主负责）。极薄 app 形态等本仓有独立
  entry 目标再接（与 ios 仓同口径）。

## 四、令牌消费机制（D18）

core 的 codegen 产物是 `LhTokens`（明）与 `LhDarkTokens`（暗）两个类（仅根类 export）。

- **暗色模型是并列对象**：`LhDarkTokens` 只含 `Color` 子类，尺寸类令牌暗色不覆盖
  （与 android / ios / windows 一致；docs 端是浅合并）。主题层据此设计。
- **本地连接**：`pnpm link:tokens`（脚本带三级守卫：本地 `../lh-ui-core/dist/harmony` →
  npm `@lh-ui/core/dist/harmony` → 报错）。`--check` 是 CI 门禁，做**文件名集合 + 逐文件字节**
  比对（早期版本只比文件数，core 新增令牌内容漂移时给出过假绿灯）。禁止把生成的令牌文件提交入库。
- **回退形态**：家族布局不存在时（CI 单仓 clone），`@lh-ui/core` npm 包的 `files:["dist"]`
  含四端产物。ohpm 令牌 HAR 回退在 nM6 打通后接入。

## 五、命名规范（总纲 D20）

- **平台包名一律反域名**：应用 bundleName 为 `top.lhgb.ui.harmony.demo`
  （`AppScope/app.json5`）；ohpm 包名同为反域名 `top.lhgb.ui.harmony`——非 npm 平台统一以
  `top.lhgb.ui` 为 groupId、平台名为 artifactId（见总纲 D20 与 `docs/发包流程.md` §十四），
  不再使用 npm 风格的 `@lh-ui/*` scope。仓内 `package.json` 的 `@lh-ui/harmony` 是
  `private: true` 的工具链身份（pnpm 脚本 + changeset 寻址用），从不发包，保持不动。
- **自有标识符一律 LH 前缀**：类 / 结构体 / 枚举 / 组件 `Lh*`（`LhButton`、`LhButtonType`、
  `LhPatternFill`、`LhDemoIndex`），工具函数 `lh*`（`lhVp`）；框架约定的模板名
  （`EntryAbility`）除外。resolve 纯函数与外观接口遵循 `Lh<Comp>Tokens` /
  `Lh<Comp>Appearance` 命名，`<comp>` 用 spec 文件名的大驼峰形式。
- npm / ohpm 的 `@lh-ui/*` scope 不受此约束。

## 六、平台 gotcha

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
- **主题消费模式**：组件不直接 import 色板，而是 `@StorageProp(LH_COLORS_KEY) colorsJson`
  拿 JSON 字符串再 `JSON.parse(...) as LhColors`（`LhToast` 是范例）。颜色走 `LhColors`，
  尺寸直接取 `LhTokens`（尺寸无暗色变体）。未 apply 时回退 `LightLhColors()`。
- **指令式组件在声明式 UI 中的落点**：spec 的 show/hide 类指令（toast 等）实现为组件 public
  方法 + `Lh<Comp>Controller` 句柄：组件在 `aboutToAppear` 把方法注册到宿主传入的控制器上，
  宿主即可在不持有组件实例的情况下驱动。计时模型（tick/hide）由 `setTimeout` 承载。
- **回调属性不加 @Prop**（重申）：`onClose` 等回调一律普通属性；`@Watch` 只能挂在可观察属性上。
- **模拟器变量名保留驼峰**：`gen-sim-tokens.mjs` 生成的 CSS 变量名沿用令牌点路径的驼峰
  （`--lh-button-paddingHorizontal-medium`），手写 CSS 按 kebab 习惯写会**静默失配**（变量未定义、
  样式悄悄失效）。`pnpm sim:check` 把这类失配拦在 CI。
- **docsui 的 ArkUI 落点**：
  - 预览结构体签名固定为普通属性 `toast: LhToastController`（生成页无条件透传该属性，
    不需要反馈的预览也必须声明该字段，否则 ArkUI 报未知属性）。
  - 嵌入子内容用 `@BuilderParam content: () => void` + 尾随闭包（`DocScroll` /
    `DocSectionView` / `DocPreviewFrame` 都是单一 builder 参数）。
  - 数据接口（`DocEntry` 等）用 interface + 对象字面量，作为**普通属性**传入（静态数据
    不需要 @Prop 的响应式拷贝）；回调与控制器同样是普通属性（红线「回调属性不加 @Prop」）。
  - md 散文里的反引号与 `**` 在生成期剥离（ArkUI 的 `Text` 不解析 markdown）；
    网页模拟器 HTML（`<div class="sim-phone">` / `<p class="sim-note">` / `:::` 容器标记行）
    不进原生，`:::` 的正文当散文保留。
  - 表格无原生组件，用 `Row` + `layoutWeight(1)` 平分列宽（见 `DocTableView`）。
  - `LhTokens` 字段类型是 `Dimension | number`，参与算术前先赋给 `number` 局部
    （`DocPreviewFrame.frameMinHeight()` 的写法），不要直接对令牌做乘除。
- **entry 即文档**：entry 演示应用是组件示例的第一现场（首页 `pages/Index.ets` 已覆盖全部
  15 个组件的分栏 demo 与明暗热重绘），文档站 HTML 模拟器是第二现场（`docs/components/*.md`
  每组件一页）。两处现场与组件实现同步，新增组件时按红线 7 一并补齐。
- **模块边界**：仓根是库本体（ohpm `top.lhgb.ui.harmony`），`entry/` 是消费它的演示模块
  （`file:../` 依赖）。**库内**（components / common / tokens）用相对路径互相 import；
  **entry 与测试一律用包名 `top.lhgb.ui.harmony` 导入**，不要写跨模块边界的相对路径
  （曾因此出现 `../../../` 越界到不存在路径的 bug）。令牌类（`LhTokens` / `LhDarkTokens` /
  `LhShadow`）已在 barrel 再导出，外部只走包名。

## 七、命令速查

| 任务 | 命令 | 说明 |
| --- | --- | --- |
| 同步令牌 | `pnpm link:tokens` | 从 core dist 同步到本仓源码树（改令牌后必跑） |
| 令牌同步校验 | `pnpm link:tokens:check` | CI 门禁：文件名集合 + 逐文件字节比对 |
| 生成模拟器令牌 | `pnpm gen:sim` | 生成 `docs/.vitepress/theme/sim-tokens.css`（gitignore） |
| 生成应用图标 | `pnpm gen:icon` | 读 core 品牌色生成 `entry/.../media/app_icon.png` |
| 模拟器变量名校验 | `pnpm sim:check` | CI 门禁：模拟器引用的 `var(--lh-*)` 必须有定义 |
| 原生文档页生成 | `pnpm gen:docs` | md → docsui/pages/ + DocRegistry + DocPageDispatch（改 md 后必跑） |
| 文档模块一致性校验 | `pnpm docs:check` | CI 门禁：预览双向一致 + 无未用 import + 注册表/分发层齐全 |
| 构建 | DevEco：Build → Build Hs/Hap | 编译（含 ArkTS 类型检查） |
| 单测 | DevEco：右键 `entry/src/test` → Run Tests | hypium 黄金用例（需 DevEco；hvigor 自动发现 `*.test.ets`） |
| 文档 dev | `pnpm docs:dev` | 先 gen:sim 再起 VitePress（端口 5183） |
| 文档构建 | `pnpm docs:build` | 部署前跑，产物在 docs/.vitepress/dist |
| 文档预览 | `pnpm docs:preview` | 预览构建产物 |
| 发版 | `pnpm changeset` / `pnpm changeset:version` | changesets 流程（.changeset/ 目录） |

## 八、Read before touching sensitive areas

- 改 `LhTheme.ets`：先读 core 的 `dist/harmony/tokens/LhDarkTokens.ets`，确认暗色覆盖范围
  （只 Color，不含尺寸），否则主题层取尺寸会拿到错误对象。
- 改任一 `Lh<Comp>Tokens.ets`：先读 `../lh-ui-core/specs/<comp>.json` 的 behaviors 与 tokenRefs，
  令牌绑定必须逐条对齐；黄金用例（`cases/<comp>.json`，已翻译为 `entry/src/test/<Comp>.test.ets`）
  会断言这些映射。`LhColors` 里每新增一个色字段，明/暗两个工厂都要同步加。
- 改 `scripts/*.mjs`：守卫逻辑改动影响四仓统一机制，先读 core 的
  `scripts/resolve-local-tokens.mjs` 与总纲 D18。
- 改 `scripts/gen-doc-pages.mjs` 的 `SCENE_MAP`：它是 md `##` 标题 → 预览结构体的唯一映射，
  加了条目必须同时在 `docsui/previews/{Comp}Previews.ets` 建对应 `{Comp}{Scene}Preview`
  结构体（普通属性 `toast: LhToastController`），并跑 `pnpm gen:docs` + `pnpm docs:check`。
  漏映射只会告警（该节无预览），但结构体命名拼错会直接编译失败。
- 改 `docsui/widgets/*` 或 `model/DocModels.ets`：widget 与生成页的接口（`DocScroll` /
  `DocSectionView` 的 builder 签名、`DocEntry` 字段）被全部 20 个生成页依赖，
  改完必须重跑 `pnpm gen:docs` 再 `pnpm docs:check`。
- 改 `docs/.vitepress/config.ts`：注意 `DOCS_BASE` 必须显式读 env（Vite 内置 env 加载在
  config 求值之后），且 `search` 必须放顶层 `themeConfig`（放 locale 下搜索 UI 不渲染）。
- 加新组件：先在 core 仓写 `specs/<comp>.json` + `cases/<comp>.json`（codegen 不生成 UI），
  再本仓建 `components/<comp>/`（Index.ets + Lh<Comp>Tokens.ets 两文件），翻译黄金用例为
  `entry/src/test/<Comp>.test.ets`，最后按红线 7 同步全部聚合点。
