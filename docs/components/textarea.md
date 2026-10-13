# Textarea 多行输入

多行文本输入。高度随行数与内容增长，支持字数统计与字数上限。

> 契约源：`lh-ui-core/specs/textarea.json` ·
> 黄金用例：`lh-ui-core/cases/textarea.json`（6 条，已翻译为 hypium 测试）

## 基本用法

`rows` 决定初始可见行数，最小高度取 `textarea.minHeight` 令牌。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea 基本</span></div>
  <div class="sim-screen">
    <div class="sim-row" style="display: block;">
      <div class="sim-textarea">
        <textarea class="sim-textarea__field" placeholder="请输入备注内容" rows="3" readonly></textarea>
      </div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

```typescript
LhTextarea({
  value: this.remark,
  placeholder: '请输入备注内容',
  rows: 3,
  onValueChange: (value: string) => { this.remark = value },
})
```

## 字数统计

`showCount` 为 true 时在右下角显示字数统计：设置 `maxlength` 显示 `当前/上限`，
不设置时只显示当前长度。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea 字数统计</span></div>
  <div class="sim-screen">
    <div class="sim-row" style="display: block;">
      <div class="sim-textarea">
        <textarea class="sim-textarea__field" rows="3" readonly>鸿蒙端多行输入框示例文字</textarea>
        <span class="sim-textarea__count">11/50</span>
      </div>
    </div>
    <div class="sim-row" style="display: block;">
      <div class="sim-textarea sim-textarea--focused">
        <textarea class="sim-textarea__field" placeholder="聚焦态（focus 环）" rows="2" readonly></textarea>
        <span class="sim-textarea__count">0</span>
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
| `rows` | 初始可见行数；高度随行数与内容增长 | `number` | `3` |
| `disabled` | 是否禁用；禁用时不响应输入、不触发 `onValueChange` | `boolean` | `false` |
| `readonly` | 是否只读；只读时可聚焦但不接受输入 | `boolean` | `false` |
| `showCount` | 是否在右下角显示字数统计 | `boolean` | `false` |
| `maxlength` | 最大字符数；超出截断；`showCount` 时作为分母 | `number?` | `undefined` |
| `onValueChange` | 文本变化时触发；`disabled` / `readonly` 时不触发 | `(value: string) => void` | 空函数 |
| `onFocus` | 获得焦点时触发 | `() => void` | 空函数 |
| `onBlur` | 失去焦点时触发 | `() => void` | 空函数 |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `textarea.minHeight` | 无内容时的最小高度（72vp，约三行） |
| `textarea.paddingHorizontal` / `textarea.paddingVertical` | 内边距（12 / 12vp） |
| `textarea.fontSize` | 输入字号（14） |
| `textarea.countFontSize` | 字数统计字号（12） |
| `textarea.borderRadius` / `textarea.borderWidth` | 圆角与描边宽度 |
| `textarea.focusRingWidth` | 聚焦环宽度 |
| `typography.lineHeight.primary` | 行高（1.8） |
| `color.text.primary` / `color.text.placeholder` | 输入文字 / 占位文字色 |
| `color.background.default` / `color.background.disabled` | 底色 / 禁用底色 |
| `color.border.base` / `color.focus` | 描边色 / 聚焦色 |

## 黄金用例对照

`cases/textarea.json` 的 6 条断言与 hypium 测试的对应关系（`entry/src/test/Textarea.test.ets`）：

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `input-emits-onvaluechange` | 输入触发 onValueChange | `disabled_is_not_interactive`（gate 反向断言） |
| `disabled-blocks-input` | 禁用态不响应输入 | `disabled_is_not_interactive` |
| `showcount-renders-count` | 字数统计渲染 `当前/上限` | `showcount_renders_count_with_maxlength` |
| `showcount-without-maxlength-renders-length-only` | 无上限时只显示长度 | `showcount_renders_length_only_without_maxlength` |
| `focus-uses-focus-token` | 聚焦态取 focus 令牌 | `focus_uses_focus_token` |
| `maxlength-truncates-input` | 超出上限截断 | `maxlength_truncates_input` |

另有暗色专项：`dark_colors_come_from_dark_tokens` / `dimensions_are_identical_in_dark_mode`。
运行：DevEco Studio 右键 `entry/src/test` → Run Tests。
