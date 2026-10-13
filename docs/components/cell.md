# Cell 单元格

列表行单元格。标题 + 说明 + 右侧值的经典三段式布局，支持图标、必填红星、分隔线与点击箭头。

> 契约源：`lh-ui-core/specs/cell.json` ·
> 黄金用例：`lh-ui-core/cases/cell.json`（6 条，已翻译为 hypium 测试）

## 基本用法

`title` 为主文字，`value` 右对齐，`label` 为标题下方的次要说明。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell 基本</span></div>
  <div class="sim-screen">
    <div style="border-radius: var(--lh-radius-base); overflow: hidden;">
      <div class="sim-cell sim-cell--bordered">
        <div class="sim-cell__main"><div class="sim-cell__title">标题文字</div></div>
        <div class="sim-cell__value">右侧值</div>
      </div>
      <div class="sim-cell sim-cell--bordered">
        <div class="sim-cell__main">
          <div class="sim-cell__title">带说明</div>
          <div class="sim-cell__label">这是说明文字</div>
        </div>
      </div>
      <div class="sim-cell">
        <div class="sim-cell__main"><div class="sim-cell__title">无分隔线（bordered=false）</div></div>
      </div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

```typescript
LhCell({ title: '标题文字', value: '右侧值', label: '说明文字' })
```

## 图标 / 必填 / 可点击

`icon` 在左侧绘制图标，`required` 在标题前绘制必填红星（取 `color.danger.default`），
`clickable` 为 true 时右侧出现指示箭头并响应点击。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell 变体</span></div>
  <div class="sim-screen">
    <div style="border-radius: var(--lh-radius-base); overflow: hidden;">
      <div class="sim-cell sim-cell--bordered">
        <span class="sim-cell__icon">⌕</span>
        <div class="sim-cell__main"><div class="sim-cell__title">带图标</div></div>
        <div class="sim-cell__value">可点击</div>
        <span class="sim-cell__arrow">→</span>
      </div>
      <div class="sim-cell sim-cell--bordered">
        <div class="sim-cell__main">
          <div class="sim-cell__title"><span class="sim-cell__required">＊</span>必填项</div>
        </div>
      </div>
      <div class="sim-cell">
        <div class="sim-cell__main"><div class="sim-cell__title">可点击单元格</div></div>
        <span class="sim-cell__arrow">→</span>
      </div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `title` | 标题（主文字） | `string` | `''` |
| `value` | 右侧值（右对齐次文字） | `string` | `''` |
| `label` | 标题下方的说明文字 | `string` | `''` |
| `bordered` | 是否绘制底部分隔线 | `boolean` | `true` |
| `clickable` | 是否可点击；为 true 时显示右侧箭头并响应点击 | `boolean` | `false` |
| `required` | 是否在标题前显示必填红星 | `boolean` | `false` |
| `icon` | 左侧图标名（本地图形体系渲染） | `string?` | `undefined` |
| `onClick` | 点击回调；`clickable` 为 false 时不触发 | `() => void` | 空函数 |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `cell.paddingHorizontal` / `cell.paddingVertical` | 单元格内边距（16 / 8vp） |
| `cell.fontSizeTitle` / `cell.fontSizeLabel` / `cell.fontSizeValue` | 三段文字字号（14 / 13 / 14） |
| `cell.gap` | 标题与说明的垂直间距 |
| `color.text.primary` / `color.text.secondary` | 标题色 / 说明与值色 |
| `color.border.lighter` | 底部分隔线色 |
| `color.danger.default` | 必填红星色 |
| `icon.size.medium` | 左侧图标与右侧箭头尺寸 |

## 黄金用例对照

`cases/cell.json` 的 6 条断言与 hypium 测试的对应关系（`entry/src/test/Cell.test.ets`）：

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `title-and-value-render` | 标题与值消费字号令牌 | `title_and_value_use_font_tokens` |
| `label-renders-secondary-tone` | 说明取次要文字色 | `label_uses_secondary_tone` |
| `required-uses-danger-token` | 必填红星取危险色 | `required_uses_danger_token` |
| `bordered-emits-line-command` | 分隔线消费描边令牌 | `bordered_uses_border_lighter_token` |
| `clickable-emits-onclick` | 可点击时触发回调 | `clickable_state_is_resolved` |
| `not-clickable-no-onclick` | 不可点击时不触发 | `clickable_state_is_resolved`（gate 断言） |

另有暗色专项：`dark_colors_come_from_dark_tokens` / `dimensions_are_identical_in_dark_mode`。
运行：DevEco Studio 右键 `entry/src/test` → Run Tests。
