# Radio 单选框

单选控件原子。组件本身不含组逻辑，由宿主维护单选组（`value` + `checked`）。

> 契约源：`lh-ui-core/specs/radio.json` ·
> 黄金用例：`lh-ui-core/cases/radio.json`（6 条，已翻译为 hypium 测试）

## 基本用法

由未选中变为选中时触发 `onChange(true)`；已选中时点击不触发（黄金用例
`tap-checked-keeps-checked`）。单选组由宿主维护：

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Radio 单选组</span></div>
  <div class="sim-screen">
    <div class="sim-row" style="flex-direction: column; align-items: flex-start;">
      <label class="sim-radio sim-radio--checked">
        <span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>
        <span class="sim-radio__label">选项一</span>
      </label>
      <label class="sim-radio">
        <span class="sim-radio__ring"></span><span class="sim-radio__label">选项二</span>
      </label>
      <label class="sim-radio sim-radio--disabled">
        <span class="sim-radio__ring"></span><span class="sim-radio__label">禁用态</span>
      </label>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

```typescript
LhRadio({
  label: '选项一',
  value: 'a',
  checked: this.picked === 'a',
  onChange: () => { this.picked = 'a' },
})
```

## 尺寸

三档尺寸映射到 `radio.size` 令牌；内圆点直径按 `radio.dotScale`（50%）等比缩放。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Radio 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <label class="sim-radio sim-radio--checked sim-radio--small">
        <span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>
        <span class="sim-radio__label">小</span>
      </label>
      <label class="sim-radio sim-radio--checked">
        <span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>
        <span class="sim-radio__label">中</span>
      </label>
      <label class="sim-radio sim-radio--checked sim-radio--large">
        <span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>
        <span class="sim-radio__label">大</span>
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
| `disabled` | 是否禁用；禁用时不触发 `onChange` | `boolean` | `false` |
| `label` | 文字标签 | `string` | `''` |
| `value` | 该选项的值（宿主据此维护单选组） | `string` | `''` |
| `size` | 单选框尺寸，映射到 `radio.size` 令牌 | `LhRadioSize` | `Medium` |
| `onChange` | 由未选中变为选中时触发 `(true)`；已选中不触发 | `(checked: boolean) => void` | 空函数 |

### LhRadioSize

| 值 | size |
| --- | --- |
| `Small` | `radio.size.small`（16vp） |
| `Medium` | `radio.size.medium`（20vp） |
| `Large` | `radio.size.large`（24vp） |

选中态：外环描边 `color.primary.default`，内圆点同色，直径 = 外环尺寸 × `radio.dotScale`；
未选中态描边 `color.border.base`；禁用态取 `color.disabled.*`。

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `radio.size.{small,medium,large}` | 三档外环尺寸 |
| `radio.ringWidth` | 外环描边宽度（2vp） |
| `radio.dotScale` | 内圆点相对外环直径的比例（50% 分数） |
| `radio.gap` | 外环与文字间距（8vp） |
| `color.primary.default` | 选中描边与圆点色 |
| `color.border.base` | 未选中描边色 |
| `color.disabled.{text,border}` | 禁用态色 |
| `typography.fontSize.base` | 标签字号 |

## 黄金用例对照

`cases/radio.json` 的 6 条断言与 hypium 测试的对应关系（`entry/src/test/Radio.test.ets`）：

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `tap-unchecked-emits-onchange` | 未选中点击触发 onChange | `unchecked_is_interactive` |
| `tap-checked-keeps-checked` | 已选中点击不触发 | `checked_still_interactive_but_component_gates` |
| `disabled-blocks-change` | 禁用态不触发 onChange | `disabled_is_not_interactive` |
| `checked-uses-primary-tokens` | 选中态消费主色令牌 | `checked_uses_primary_tokens` |
| `unchecked-uses-border-token` | 未选中态消费描边令牌 | `unchecked_uses_border_token` |
| `small-size-uses-small-token` | 小号取 small 尺寸令牌 | `small_size_uses_small_token` / `dot_size_scales_with_size_token` |

另有暗色专项：`dark_colors_come_from_dark_tokens` / `dimensions_are_identical_in_dark_mode`。
运行：DevEco Studio 右键 `entry/src/test` → Run Tests。
