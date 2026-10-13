# Text 文本

文本展示原语：消费全局排版令牌，支持字号级别、字重、色调与对齐。

> 契约源：`lh-ui-core/specs/text.json` ·
> 黄金用例：`lh-ui-core/cases/text.json`（5 条，已翻译为 hypium 测试）

## 字号级别

`level` 映射到 `typography.fontSize.<level>` 令牌，默认 `base`。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text 字号</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--extraLarge">特大 extraLarge</p>
    <p class="sim-text sim-text--large">大 large</p>
    <p class="sim-text sim-text--medium">中 medium</p>
    <p class="sim-text">基准 base（默认）</p>
    <p class="sim-text sim-text--small">小 small</p>
    <p class="sim-text sim-text--extraSmall">特小 extraSmall</p>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

```typescript
LhText({ content: '标题文字', level: LhTextLevel.Large })
```

## 字重

`weight` 映射到 `typography.fontWeight.<weight>` 令牌（primary 400 / bold 600）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text 字重</span></div>
  <div class="sim-screen">
    <p class="sim-text">常规 primary（默认）</p>
    <p class="sim-text sim-text--bold">加粗 bold</p>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

## 色调

`tone` 映射到 `color.text.<tone>` 令牌；`selected` 取 `color.selected`。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text 色调</span></div>
  <div class="sim-screen">
    <p class="sim-text">主要 primary（默认）</p>
    <p class="sim-text sim-text--regular">常规 regular</p>
    <p class="sim-text sim-text--secondary">次要 secondary</p>
    <p class="sim-text sim-text--placeholder">占位 placeholder</p>
    <p class="sim-text sim-text--disabled">禁用 disabled</p>
    <p class="sim-text sim-text--selected">选中 selected</p>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

## 对齐与行高

`align` 决定文字在行盒宽度内的水平定位（不是设计令牌，映射到框架枚举）；行高恒取
`typography.lineHeight.primary`，layout 高度 = 字号 × 行高。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text 对齐</span></div>
  <div class="sim-screen">
    <p class="sim-text">左对齐 start（默认）</p>
    <p class="sim-text sim-text--align-center">居中 center</p>
    <p class="sim-text sim-text--align-end">右对齐 end</p>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

```typescript
LhText({ content: '右对齐', align: LhTextAlign.End })
```

## 明暗主题

切换站点右上角主题，模拟器手机框内的文字颜色即变；真机通过 `LhTheme.apply(true)` 切换。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>暗色文本</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--large">大标题</p>
    <p class="sim-text">正文主色</p>
    <p class="sim-text sim-text--secondary">次要说明</p>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染；明/暗值全部取自 core 令牌快照</p>

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `content` | 文本内容（spec 的 default 插槽） | `string` | `''` |
| `level` | 字号级别，映射到 `typography.fontSize.<level>` | `LhTextLevel` | `Base` |
| `weight` | 字重，映射到 `typography.fontWeight.<weight>` | `LhTextWeight` | `Primary` |
| `tone` | 文字色调，映射到 `color.text.<tone>` 或 `color.selected` | `LhTextTone` | `Primary` |
| `align` | 水平对齐方式（在行盒宽度内生效） | `LhTextAlign` | `Start` |

### LhTextLevel

| 值 | fontSize |
| --- | --- |
| `ExtraLarge` | `typography.fontSize.extraLarge`（20） |
| `Large` | `typography.fontSize.large`（18） |
| `Medium` | `typography.fontSize.medium`（16） |
| `Base` | `typography.fontSize.base`（14） |
| `Small` | `typography.fontSize.small`（13） |
| `ExtraSmall` | `typography.fontSize.extraSmall`（12） |

### LhTextWeight

| 值 | fontWeight |
| --- | --- |
| `Primary` | `typography.fontWeight.primary`（400） |
| `Bold` | `typography.fontWeight.bold`（600） |

### LhTextTone

| 值 | 文字色 |
| --- | --- |
| `Primary` | `color.text.primary` |
| `Regular` | `color.text.regular` |
| `Secondary` | `color.text.secondary` |
| `Placeholder` | `color.text.placeholder` |
| `Disabled` | `color.text.disabled` |
| `Selected` | `color.selected` |

### LhTextAlign

| 值 | 端侧映射 |
| --- | --- |
| `Start` | `TextAlign.Start` |
| `Center` | `TextAlign.Center` |
| `End` | `TextAlign.End` |

## 令牌对照

文本消费的令牌（与 `specs/text.json` 的 `tokenRefs` 逐条对齐，全部是全局令牌——
text 没有组件级令牌）：

| 令牌 | 用途 |
| --- | --- |
| `typography.fontSize.{extraLarge,large,medium,base,small,extraSmall}` | 六档字号 |
| `typography.fontWeight.{primary,bold}` | 两档字重 |
| `typography.lineHeight.primary` | 行高（layout 高度 = 字号 × 行高） |
| `color.text.{primary,regular,secondary,placeholder,disabled}` | 五档文字色调 |
| `color.selected` | 选中态文字色 |

## 黄金用例对照

`cases/text.json` 的 5 条断言与 hypium 测试的对应关系（`entry/src/test/Text.test.ets`）：

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `default-level-uses-base-tokens` | 默认级消费 base 套排版令牌 | `default_level_uses_base_tokens` |
| `large-level-uses-large-token` | large 字号令牌生效，base 未误用 | `large_level_uses_large_token` |
| `bold-weight-uses-bold-token` | bold 字重令牌生效，primary 未误用 | `bold_weight_uses_bold_token` |
| `secondary-tone-uses-text-secondary` | secondary 文字色令牌生效 | `secondary_tone_uses_text_secondary` |
| `render-emits-single-text-command` | 指令流仅一条 TEXT 指令 | `resolve_produces_single_complete_text_style` |

另有暗色专项：`dark_colors_come_from_dark_tokens` / `dimensions_are_identical_in_dark_mode`。
运行：DevEco Studio 右键 `entry/src/test` → Run Tests。
