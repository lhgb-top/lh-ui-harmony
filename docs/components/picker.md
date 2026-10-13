# Picker 选择器

底部弹层单列滚轮选择器。候选项为字符串数组，选中值为索引。

> 契约源：`lh-ui-core/specs/picker.json` ·
> 黄金用例：`lh-ui-core/cases/picker.json`（8 条，已翻译为 hypium 测试）

::: tip 声明式可见性
`visible` 为 false 时不渲染任何内容；确认 / 取消后触发 `onClose`，宿主据此置回 false。
组件须作为页面 `Stack` 的最后子节点挂载。`value` 为选中项索引（0 基），
越界时钳制到候选项范围内（黄金用例 `clamp-*`）。
:::

## 基本用法

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Picker 基本用法</span></div>
  <div class="sim-screen" style="position: relative; min-height: 360px;">
    <div class="sim-picker-overlay">
      <div class="sim-picker">
        <div class="sim-picker__toolbar">
          <button class="sim-picker__cancel">取消</button>
          <span class="sim-picker__title">请选择</span>
          <button class="sim-picker__confirm">确认</button>
        </div>
        <div class="sim-picker__wheel">
          <div class="sim-picker__item sim-picker__item--adjacent">选项一</div>
          <div class="sim-picker__item sim-picker__item--active">选项二</div>
          <div class="sim-picker__item sim-picker__item--adjacent">选项三</div>
        </div>
      </div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

```typescript
LhPicker({
  visible: this.pickerVisible,
  options: ['选项一', '选项二', '选项三'],
  value: this.pickedIndex,
  title: '请选择',
  onValueChange: (value: number) => { this.pickedIndex = value },
  onConfirm: (value: number) => { this.pickedIndex = value },
  onCancel: () => {},
  onClose: () => { this.pickerVisible = false },
})
```

滚轮选中项随拖动实时更新（`onValueChange`），确认时携带当前索引触发 `onConfirm`。

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `visible` | 是否显示；为 false 时不渲染任何内容 | `boolean` | `false` |
| `options` | 候选项文本数组（单列） | `string[]` | `[]` |
| `value` | 选中项索引（0 基）；越界钳制到候选项范围内 | `number` | `0` |
| `title` | 工具栏中间的标题 | `string` | `''` |
| `confirmText` | 确认按钮文字 | `string` | `'确认'` |
| `cancelText` | 取消按钮文字 | `string` | `'取消'` |
| `onValueChange` | 滚轮停止且选中项变化时触发 | `(value: number) => void` | 空函数 |
| `onConfirm` | 点击确认时触发，携带当前选中索引（随后触发 `onClose`） | `(value: number) => void` | 空函数 |
| `onCancel` | 点击取消时触发（随后触发 `onClose`） | `() => void` | 空函数 |
| `onClose` | 确认 / 取消后触发 | `() => void` | 空函数 |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `picker.height` | 面板高度（260vp） |
| `picker.toolbarHeight` | 顶部工具栏高度（44vp） |
| `picker.itemHeight` | 候选项高度（滚轮单页高度，40vp） |
| `picker.itemFontSize` | 候选项字号（14） |
| `picker.borderRadius` | 面板顶部圆角 |
| `color.background.default` / `color.background.overlay` | 面板底色 / 遮罩色 |
| `color.text.primary` / `color.text.secondary` | 选中项 / 相邻项文字色 |
| `color.primary.default` | 确认按钮与选中项高亮色 |
| `color.border.lighter` | 工具栏与滚轮选中区分隔线 |
| `shadow.base` | 面板阴影 |
| `zIndex.modalBackdrop` / `zIndex.modal` | 遮罩 / 弹层层级 |
| `typography.fontSize.medium` / `fontSize.base` | 标题 / 按钮字号 |

## 黄金用例对照

`cases/picker.json` 的 8 条断言与 hypium 测试的对应关系（`entry/src/test/Picker.test.ets`）：

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `confirm-emits-onconfirm-with-value` | 确认携带当前值触发 onConfirm | `resolve_clamps_selected_index` |
| `confirm-also-emits-onclose` | 确认同时触发 onClose | `toolbar_colors_use_tokens` |
| `cancel-emits-oncancel` | 取消触发 onCancel | `toolbar_colors_use_tokens` |
| `scroll-emits-onvaluechange` | 滚轮变化触发 onValueChange | `wheel_height_minus_toolbar` |
| `clamp-negative-value-to-zero` | 负索引钳制到 0 | `clamp_negative_value_to_zero` |
| `clamp-overflow-value-to-last` | 溢出索引钳制到末项 | `clamp_overflow_value_to_last` |
| `title-renders-text` | 标题渲染文字 | `toolbar_colors_use_tokens` |
| `hidden-not-rendered` | 隐藏时不渲染 | `overlay_and_zindex_use_tokens`（visible gate） |

另有暗色专项：`dark_colors_come_from_dark_tokens` / `dimensions_are_identical_in_dark_mode`。
运行：DevEco Studio 右键 `entry/src/test` → Run Tests。
