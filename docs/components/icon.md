# Icon 图标

图标组件。按本地图形体系把图标名解析为字形渲染，支持尺寸与语义色调。

> 契约源：`lh-ui-core/specs/icon.json` ·
> 黄金用例：`lh-ui-core/cases/icon.json`（5 条，已翻译为 hypium 测试）

::: tip 端侧落点说明
鸿蒙端当前用 unicode 字形占位（`LhIconTokens.glyphFor`），生产环境应替换为
SymbolGlyph / 矢量资产；这与 button 的 `Text('◆')` 占位策略一致。已登记图标名见下方「图标名」一节。
:::

## 尺寸

三档尺寸映射到 `icon.size` 令牌。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Icon 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon sim-icon--small">⌕</span>
      <span class="sim-icon">⌕</span>
      <span class="sim-icon sim-icon--large">⌕</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

```typescript
LhIcon({ name: 'search', size: LhIconSize.Large })
```

## 色调

`tone` 决定字形颜色，与语义色令牌一一对应；默认色调取 `color.text.primary`。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Icon 色调</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon">✓ 默认</span>
      <span class="sim-icon sim-icon--primary">✓ 主色</span>
      <span class="sim-icon sim-icon--success">✓ 成功</span>
    </div>
    <div class="sim-row">
      <span class="sim-icon sim-icon--warning">⚠ 警告</span>
      <span class="sim-icon sim-icon--danger">✕ 危险</span>
      <span class="sim-icon sim-icon--info">ℹ 信息</span>
    </div>
    <div class="sim-row">
      <span class="sim-icon sim-icon--regular">✓ 常规</span>
      <span class="sim-icon sim-icon--secondary">✓ 次要</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

## 图标名

`glyphFor` 当前登记的图标名与字形：`search` ⌕、`refresh` ↻、`check` ✓、`close` ✕、
`warning` ⚠、`info` ℹ、`back` ←、`more` ⋯、`star` ★、`edit` ✎、`delete` ⌫、
`plus` ＋、`minus` －、`arrow` →。未登记名回退 `◆`。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>已登记图标</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon">⌕</span><span class="sim-icon">↻</span><span class="sim-icon">✓</span>
      <span class="sim-icon">✕</span><span class="sim-icon">⚠</span><span class="sim-icon">ℹ</span>
      <span class="sim-icon">←</span><span class="sim-icon">⋯</span>
    </div>
    <div class="sim-row">
      <span class="sim-icon">★</span><span class="sim-icon">✎</span><span class="sim-icon">⌫</span>
      <span class="sim-icon">＋</span><span class="sim-icon">－</span><span class="sim-icon">→</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `name` | 图标名（本地图形体系解析，未登记名回退 `◆`） | `string` | `''` |
| `size` | 图标尺寸，映射到 `icon.size` 令牌 | `LhIconSize` | `Medium` |
| `tone` | 语义色调，决定字形颜色 | `LhIconTone` | `Default` |
| `onClick` | 点击回调 | `() => void` | 空函数 |

### LhIconSize

| 值 | size |
| --- | --- |
| `Small` | `icon.size.small`（16vp） |
| `Medium` | `icon.size.medium`（20vp） |
| `Large` | `icon.size.large`（24vp） |

### LhIconTone

| 值 | 字形色 |
| --- | --- |
| `Default` | `color.text.primary` |
| `Primary` | `color.primary.default` |
| `Success` | `color.success.default` |
| `Warning` | `color.warning.default` |
| `Danger` | `color.danger.default` |
| `Info` | `color.info.default` |
| `Regular` | `color.text.regular` |
| `Secondary` | `color.text.secondary` |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `icon.size.{small,medium,large}` | 三档尺寸 |
| `color.text.primary` | 默认色调 |
| `color.text.regular` / `color.text.secondary` | 常规 / 次要色调 |
| `color.{primary,success,warning,danger,info}.default` | 语义色调 |

## 黄金用例对照

`cases/icon.json` 的 5 条断言与 hypium 测试的对应关系（`entry/src/test/Icon.test.ets`）：

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `click-emits-onclick` | 点击触发回调（端侧为 `onClick` 属性） | `glyph_maps_registered_name`（端侧按声明式回调对齐） |
| `default-tone-uses-text-primary` | 默认色调取主文字色 | `default_tone_uses_text_primary` |
| `primary-tone-uses-primary-token` | 主色调取主色令牌 | `primary_tone_uses_primary_token` |
| `small-size-uses-small-token` | 小号取 small 尺寸令牌 | `small_size_uses_small_token` |
| `render-emits-icon-command` | 渲染发射图标命令 | 端侧无对应命令（声明式渲染，字形映射见 `glyph_maps_registered_name` / `glyph_falls_back_for_unknown_name`） |

另有暗色专项：`dark_colors_come_from_dark_tokens` / `dimensions_are_identical_in_dark_mode`。
运行：DevEco Studio 右键 `entry/src/test` → Run Tests。
