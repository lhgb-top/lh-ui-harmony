# Input 输入框

单行文本输入。支持密码类型、三档尺寸、禁用 / 只读、清除按钮与字数上限。

> 契约源：`lh-ui-core/specs/input.json` ·
> 黄金用例：`lh-ui-core/cases/input.json`（8 条，已翻译为 hypium 测试）

## 基本用法

`value` 受控，`placeholder` 取 `color.text.placeholder` 令牌。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input 基本</span></div>
  <div class="sim-screen">
    <div class="sim-row" style="display: block;">
      <div class="sim-input">
        <input class="sim-input__field" placeholder="请输入内容" value="鸿蒙端输入框" readonly>
      </div>
    </div>
    <div class="sim-row" style="display: block;">
      <div class="sim-input">
        <input class="sim-input__field" placeholder="占位提示文字" readonly>
      </div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

```typescript
LhInput({
  value: this.text,
  placeholder: '请输入内容',
  clearable: true,
  onValueChange: (value: string) => { this.text = value },
})
```

## 聚焦与尺寸

聚焦时描边切换为 `color.focus` 并叠加 `input.focusRingWidth` 宽度的聚焦环；
三档尺寸映射到 `input.height` / `paddingHorizontal` / `fontSize` 令牌。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input 聚焦与尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row" style="display: block;">
      <div class="sim-input sim-input--focused">
        <input class="sim-input__field" placeholder="聚焦态（focus 环）" readonly>
      </div>
    </div>
    <div class="sim-row" style="display: block;">
      <div class="sim-input sim-input--small">
        <input class="sim-input__field" placeholder="小型输入框" readonly>
      </div>
    </div>
    <div class="sim-row" style="display: block;">
      <div class="sim-input sim-input--large">
        <input class="sim-input__field" placeholder="大型输入框" readonly>
      </div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

## 状态与清除

`disabled` 禁用输入且呈现禁用样式；`clearable` 在有值时显示清除按钮，
点击触发 `onValueChange('')`；`maxlength` 超出时截断新输入。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input 状态</span></div>
  <div class="sim-screen">
    <div class="sim-row" style="display: block;">
      <div class="sim-input">
        <input class="sim-input__field" placeholder="密码框" value="••••••" readonly>
      </div>
    </div>
    <div class="sim-row" style="display: block;">
      <div class="sim-input">
        <input class="sim-input__field" value="可清除的内容" readonly>
        <span class="sim-input__clear">✕</span>
      </div>
    </div>
    <div class="sim-row" style="display: block;">
      <div class="sim-input sim-input--disabled">
        <input class="sim-input__field" placeholder="禁用态" disabled>
      </div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `value` | 当前文本值（受控） | `string` | `''` |
| `placeholder` | 占位提示文字 | `string` | `''` |
| `type` | 输入类型；密码类型映射到 ArkUI `InputType.Password` | `LhInputType` | `Text` |
| `size` | 输入框尺寸，映射到尺寸令牌 | `LhInputSize` | `Medium` |
| `disabled` | 是否禁用；禁用时不响应输入、不触发 `onValueChange` | `boolean` | `false` |
| `readonly` | 是否只读；只读时可聚焦但不接受输入 | `boolean` | `false` |
| `clearable` | 是否显示清除按钮（有值时） | `boolean` | `false` |
| `maxlength` | 最大字符数；超出截断；为 `undefined` 时不限制 | `number?` | `undefined` |
| `onValueChange` | 文本变化时触发；`disabled` / `readonly` 时不触发 | `(value: string) => void` | 空函数 |
| `onFocus` | 获得焦点时触发 | `() => void` | 空函数 |
| `onBlur` | 失去焦点时触发 | `() => void` | 空函数 |

### LhInputType

| 值 | 端侧落点 |
| --- | --- |
| `Text` | ArkUI `InputType.Normal` |
| `Password` | ArkUI `InputType.Password`（掩码显示） |

### LhInputSize

| 值 | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `Small` | `input.height.small`（32vp） | `input.paddingHorizontal.small`（12vp） | `input.fontSize.small`（13） |
| `Medium` | `input.height.medium`（40vp） | `input.paddingHorizontal.medium`（16vp） | `input.fontSize.medium`（14） |
| `Large` | `input.height.large`（48vp） | `input.paddingHorizontal.large`（20vp） | `input.fontSize.large`（16） |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `input.height.{small,medium,large}` | 三档高度 |
| `input.paddingHorizontal.{small,medium,large}` | 三档横向内边距 |
| `input.fontSize.{small,medium,large}` | 三档字号 |
| `input.borderRadius` / `input.borderWidth` | 圆角与描边宽度 |
| `input.focusRingWidth` | 聚焦环宽度 |
| `input.clearIconSize` | 清除按钮尺寸（16vp） |
| `color.text.primary` / `color.text.placeholder` | 输入文字 / 占位文字色 |
| `color.background.default` / `color.background.disabled` | 底色 / 禁用底色 |
| `color.border.base` / `color.focus` | 描边色 / 聚焦色 |
| `color.disabled.text` | 禁用文字色 |

## 黄金用例对照

`cases/input.json` 的 8 条断言与 hypium 测试的对应关系（`entry/src/test/Input.test.ets`）：

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `input-emits-onvaluechange` | 输入触发 onValueChange | `disabled_is_not_interactive`（gate 反向断言） |
| `clearable-emits-empty-value` | 清除触发空值回调 | `clear_icon_uses_token`（清除图标消费令牌） |
| `disabled-blocks-input` | 禁用态不响应输入 | `disabled_is_not_interactive` |
| `readonly-blocks-input` | 只读态不响应输入 | `readonly_still_enabled_in_appearance` |
| `placeholder-uses-placeholder-token` | 占位文字取占位令牌 | `placeholder_uses_placeholder_token` |
| `focus-uses-focus-token` | 聚焦态取 focus 令牌 | `focus_uses_focus_token` |
| `small-size-uses-small-tokens` | 小号消费 small 尺寸令牌 | `small_size_uses_small_tokens` |
| `maxlength-truncates-input` | 超出上限截断 | `maxlength_truncates_input` |

另有暗色专项：`dark_colors_come_from_dark_tokens` / `dimensions_are_identical_in_dark_mode`。
运行：DevEco Studio 右键 `entry/src/test` → Run Tests。
