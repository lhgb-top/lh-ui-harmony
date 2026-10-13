# Checkbox 复选框

三态选中控件。支持选中 / 未选中 / 半选（不确定）三态，可禁用。

> 契约源：`lh-ui-core/specs/checkbox.json` ·
> 黄金用例：`lh-ui-core/cases/checkbox.json`（6 条，已翻译为 hypium 测试）

## 基本用法

`checked` 受控，点击切换并触发 `onChange` 携带新选中态。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Checkbox 基本</span></div>
  <div class="sim-screen">
    <div class="sim-row" style="flex-direction: column; align-items: flex-start;">
      <label class="sim-checkbox sim-checkbox--checked">
        <span class="sim-checkbox__box">✓</span><span class="sim-checkbox__label">已选中</span>
      </label>
      <label class="sim-checkbox">
        <span class="sim-checkbox__box"></span><span class="sim-checkbox__label">未选中</span>
      </label>
      <label class="sim-checkbox sim-checkbox--indeterminate">
        <span class="sim-checkbox__box">－</span><span class="sim-checkbox__label">半选态</span>
      </label>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

```typescript
LhCheckbox({
  checked: this.agreed,
  label: '同意服务条款',
  onChange: (checked: boolean) => { this.agreed = checked },
})
```

## 半选与禁用

`indeterminate` 为 true 时呈现次要色横杠；点击半选态变为**选中**
（黄金用例 `indeterminate-becomes-checked`）。`disabled` 阻止切换。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Checkbox 尺寸与禁用</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <label class="sim-checkbox sim-checkbox--checked sim-checkbox--small">
        <span class="sim-checkbox__box">✓</span><span class="sim-checkbox__label">小</span>
      </label>
      <label class="sim-checkbox sim-checkbox--checked">
        <span class="sim-checkbox__box">✓</span><span class="sim-checkbox__label">中</span>
      </label>
      <label class="sim-checkbox sim-checkbox--checked sim-checkbox--large">
        <span class="sim-checkbox__box">✓</span><span class="sim-checkbox__label">大</span>
      </label>
    </div>
    <div class="sim-row">
      <label class="sim-checkbox sim-checkbox--checked sim-checkbox--disabled">
        <span class="sim-checkbox__box">✓</span><span class="sim-checkbox__label">禁用选中</span>
      </label>
      <label class="sim-checkbox sim-checkbox--disabled">
        <span class="sim-checkbox__box"></span><span class="sim-checkbox__label">禁用未选</span>
      </label>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `checked` | 是否选中 | `boolean` | `false` |
| `indeterminate` | 是否半选（不确定）；点击后变为选中 | `boolean` | `false` |
| `disabled` | 是否禁用；禁用时不触发 `onChange` | `boolean` | `false` |
| `label` | 文字标签 | `string` | `''` |
| `size` | 复选框尺寸，映射到 `checkbox.size` 令牌 | `LhCheckboxSize` | `Medium` |
| `onChange` | 点击切换时触发，携带新选中态 | `(checked: boolean) => void` | 空函数 |

### LhCheckboxSize

| 值 | size |
| --- | --- |
| `Small` | `checkbox.size.small`（16vp） |
| `Medium` | `checkbox.size.medium`（20vp） |
| `Large` | `checkbox.size.large`（24vp） |

选中态：底色 `color.primary.default`、勾 `color.onPrimary`、描边主色；
未选中态：透明底、描边 `color.border.base`；半选态：次要色横杠；禁用态取 `color.disabled.*`。

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `checkbox.size.{small,medium,large}` | 三档尺寸 |
| `checkbox.borderRadius` / `checkbox.borderWidth` | 圆角与描边宽度（2 / 2vp） |
| `checkbox.checkWidth` | 勾形描边宽度 |
| `checkbox.gap` | 复选框与文字间距（8vp） |
| `color.primary.default` / `color.onPrimary` | 选中底 / 勾色 |
| `color.border.base` | 未选中描边色 |
| `color.text.secondary` | 半选横杠色 |
| `color.disabled.{bg,text,border}` | 禁用态三色 |
| `typography.fontSize.base` | 标签字号 |

## 黄金用例对照

`cases/checkbox.json` 的 6 条断言与 hypium 测试的对应关系（`entry/src/test/Checkbox.test.ets`）：

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | 点击切换并触发 onChange | `tap_toggles_checked` |
| `tap-checked-unchecks` | 选中态点击变为未选中 | `tap_checked_unchecks` |
| `disabled-blocks-change` | 禁用态不触发 onChange | `disabled_is_not_interactive` |
| `checked-uses-primary-tokens` | 选中态消费主色令牌 | `checked_uses_primary_tokens` |
| `unchecked-uses-border-token` | 未选中态消费描边令牌 | `unchecked_uses_border_token` |
| `indeterminate-becomes-checked` | 半选态点击变为选中 | `indeterminate_becomes_checked` / `indeterminate_uses_dash_mark` |

另有暗色专项：`dark_colors_come_from_dark_tokens` / `dimensions_are_identical_in_dark_mode`。
运行：DevEco Studio 右键 `entry/src/test` → Run Tests。
