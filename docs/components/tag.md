# Tag 标签

用于标记和选择的标签。支持六种语义类型、三档尺寸、描边态、圆角态与可关闭态。

> 契约源：`lh-ui-core/specs/tag.json` ·
> 黄金用例：`lh-ui-core/cases/tag.json`（6 条，已翻译为 hypium 测试）

## 类型

六种类型决定底色、文字色与描边色。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag 类型</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag">默认</span>
      <span class="sim-tag sim-tag--primary">主要</span>
      <span class="sim-tag sim-tag--success">成功</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--warning">警告</span>
      <span class="sim-tag sim-tag--danger">危险</span>
      <span class="sim-tag sim-tag--info">信息</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

```typescript
LhTag({ text: '主要', type: LhTagType.Primary })
```

## 描边与圆角

`plain` 为 true 时切换为语义浅底 + 语义文字 + 语义描边；`round` 为 true 时
圆角取高度的一半（与端侧 `radius` 分数换算一致）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>描边与圆角</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary sim-tag--plain">描边</span>
      <span class="sim-tag sim-tag--success sim-tag--plain">描边</span>
      <span class="sim-tag sim-tag--danger sim-tag--plain">描边</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary sim-tag--round">圆角</span>
      <span class="sim-tag sim-tag--success sim-tag--round sim-tag--plain">圆角描边</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

## 尺寸与关闭

三档尺寸映射到 `tag.height` / `paddingHorizontal` / `fontSize` 令牌；`closable`
为 true 时在右侧绘制关闭符，点击触发 `onClose`。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>尺寸与关闭</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--small">小</span>
      <span class="sim-tag">中</span>
      <span class="sim-tag sim-tag--large">大</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">可关闭<span class="sim-tag__close">✕</span></span>
      <span class="sim-tag sim-tag--info sim-tag--round">圆角可关闭<span class="sim-tag__close">✕</span></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `text` | 标签文字内容（spec 的 default 插槽） | `string` | `''` |
| `type` | 语义类型，决定底色 / 文字色 / 描边色 | `LhTagType` | `Default` |
| `size` | 标签尺寸，映射到尺寸令牌 | `LhTagSize` | `Medium` |
| `plain` | 是否描边态（语义浅底 + 语义文字 + 语义描边） | `boolean` | `false` |
| `round` | 是否圆角态（圆角 = 高度一半） | `boolean` | `false` |
| `closable` | 是否显示关闭符；点击触发 `onClose` | `boolean` | `false` |
| `onClose` | 点击关闭符时触发 | `() => void` | 空函数 |

### LhTagType

| 值 | 实心底 | 实心文字 | plain 底 / 文字 / 描边 |
| --- | --- | --- | --- |
| `Default` | `color.background.default` | `color.text.primary` | —（默认即中性） |
| `Primary` | `color.primary.default` | `color.onPrimary` | `color.primary.bg` / `.default` / `.default` |
| `Success` | `color.success.default` | `color.onPrimary` | `color.success.bg` / `.default` / `.default` |
| `Warning` | `color.warning.default` | `color.onPrimary` | `color.warning.bg` / `.default` / `.default` |
| `Danger` | `color.danger.default` | `color.onPrimary` | `color.danger.bg` / `.default` / `.default` |
| `Info` | `color.info.default` | `color.onPrimary` | `color.info.bg` / `.default` / `.default` |

默认类型描边取 `color.border.base`；语义类型实心态描边透明。

### LhTagSize

| 值 | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `Small` | `tag.height.small`（20vp） | `tag.paddingHorizontal.small`（8vp） | `tag.fontSize.small`（12） |
| `Medium` | `tag.height.medium`（24vp） | `tag.paddingHorizontal.medium`（12vp） | `tag.fontSize.medium`（13） |
| `Large` | `tag.height.large`（28vp） | `tag.paddingHorizontal.large`（16vp） | `tag.fontSize.large`（14） |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `tag.height.{small,medium,large}` | 三档高度（round 态圆角取其一半） |
| `tag.paddingHorizontal.{small,medium,large}` | 三档横向内边距 |
| `tag.fontSize.{small,medium,large}` | 三档字号 |
| `tag.borderRadius` / `tag.borderWidth` | 基础圆角与描边宽度 |
| `color.background.default` / `color.text.primary` / `color.border.base` | 默认类型三色 |
| `color.<sem>.default` / `color.onPrimary` | 语义类型实心底 / 文字 |
| `color.<sem>.bg` | plain 态浅底 |
| `spacing.xs` | 关闭符与文字间距 |

## 黄金用例对照

`cases/tag.json` 的 6 条断言与 hypium 测试的对应关系（`entry/src/test/Tag.test.ets`）：

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `default-type-renders-text` | 默认类型中性底/文字 | `default_type_uses_neutral_tokens` |
| `primary-type-uses-primary-tokens` | 主色类型消费主色令牌 | `primary_type_uses_primary_tokens` |
| `plain-uses-bg-tokens` | 描边态消费语义浅底令牌 | `plain_uses_bg_tokens` |
| `small-size-uses-small-tokens` | 小号消费 small 尺寸令牌 | `small_size_uses_small_tokens` |
| `round-makes-radius-half-height` | 圆角态取高度一半 | `round_makes_radius_half_height` |
| `closable-tap-emits-onclose` | 点击关闭符触发 onClose | `closable_close_gap_uses_spacing_xs`（间距令牌侧证） |

另有暗色专项：`dark_colors_come_from_dark_tokens` / `dimensions_are_identical_in_dark_mode`。
运行：DevEco Studio 右键 `entry/src/test` → Run Tests。
