# Dialog 对话框

声明式模态对话框。标题 + 内容 + 确认 / 取消按钮，遮罩层与卡片分层渲染。

> 契约源：`lh-ui-core/specs/dialog.json` ·
> 黄金用例：`lh-ui-core/cases/dialog.json`（8 条，已翻译为 hypium 测试）

::: tip 声明式可见性
`visible` 为 false 时不渲染任何内容。确认 / 取消后组件触发 `onClose`，
宿主据此把 `visible` 置回 false（与 react 的 `open` / `onClose` 同构）。
组件须作为页面 `Stack` 的最后子节点挂载，层级由 `zIndex` 令牌承担。
:::

## 基本用法

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dialog 基本用法</span></div>
  <div class="sim-screen" style="position: relative; min-height: 320px;">
    <div class="sim-dialog-overlay">
      <div class="sim-dialog">
        <h3 class="sim-dialog__title">删除确认</h3>
        <p class="sim-dialog__content">删除后不可恢复，确定要删除这条记录吗？</p>
        <div class="sim-dialog__actions">
          <button class="sim-btn">取消</button>
          <button class="sim-btn sim-btn--primary">确认</button>
        </div>
      </div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

```typescript
LhDialog({
  visible: this.dialogVisible,
  title: '删除确认',
  content: '删除后不可恢复，确定要删除这条记录吗？',
  type: LhDialogType.Warning,
  closable: true,
  onConfirm: () => {},
  onCancel: () => {},
  onClose: () => { this.dialogVisible = false },
})
```

## 类型

`type` 决定确认按钮的语义类型（映射到 `LhButtonType`）；危险类型确认按钮取危险色。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dialog 危险类型</span></div>
  <div class="sim-screen" style="position: relative; min-height: 320px;">
    <div class="sim-dialog-overlay">
      <div class="sim-dialog">
        <h3 class="sim-dialog__title">清空全部</h3>
        <p class="sim-dialog__content">此操作将清空当前所有数据，且不可恢复。</p>
        <div class="sim-dialog__actions">
          <button class="sim-btn">取消</button>
          <button class="sim-btn sim-btn--danger">确认清空</button>
        </div>
      </div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `visible` | 是否显示；为 false 时不渲染任何内容 | `boolean` | `false` |
| `title` | 标题 | `string` | `''` |
| `content` | 正文内容 | `string` | `''` |
| `type` | 语义类型，决定确认按钮的类型 | `LhDialogType` | `Default` |
| `confirmText` | 确认按钮文字 | `string` | `'确认'` |
| `cancelText` | 取消按钮文字 | `string` | `'取消'` |
| `closable` | 点击遮罩区域是否触发 `onClose` | `boolean` | `false` |
| `onConfirm` | 点击确认按钮时触发（随后触发 `onClose`） | `() => void` | 空函数 |
| `onCancel` | 点击取消按钮时触发（随后触发 `onClose`） | `() => void` | 空函数 |
| `onClose` | 确认 / 取消 / 点击可关闭遮罩后触发 | `() => void` | 空函数 |

### LhDialogType

| 值 | 确认按钮类型 |
| --- | --- |
| `Default` | `LhButtonType.Default` |
| `Primary` | `LhButtonType.Primary` |
| `Success` | `LhButtonType.Success` |
| `Warning` | `LhButtonType.Warning` |
| `Danger` | `LhButtonType.Danger` |
| `Info` | `LhButtonType.Info` |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `dialog.width` | 内容卡宽度（320vp） |
| `dialog.paddingHorizontal` / `dialog.paddingVertical` | 卡片内边距（20 / 20vp） |
| `dialog.titleFontSize` / `dialog.contentFontSize` | 标题 / 正文字号（16 / 14） |
| `dialog.gap` | 标题与正文、正文与按钮组的间距（12vp） |
| `dialog.borderRadius` | 卡片圆角 |
| `color.background.default` / `color.background.overlay` | 卡片底色 / 遮罩色 |
| `color.text.primary` / `color.text.regular` | 标题 / 正文色 |
| `shadow.base` | 卡片阴影 |
| `zIndex.modalBackdrop` / `zIndex.modal` | 遮罩 / 弹层层级 |

## 黄金用例对照

`cases/dialog.json` 的 8 条断言与 hypium 测试的对应关系（`entry/src/test/Dialog.test.ets`）：

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `confirm-emits-onconfirm` | 确认触发 onConfirm | `confirm_button_type_maps_from_dialog_type` |
| `cancel-emits-oncancel` | 取消触发 onCancel | `type_variants_map_to_button_types` |
| `confirm-also-emits-onclose` | 确认同时触发 onClose | `type_variants_map_to_button_types` |
| `closable-overlay-emits-onclose` | 可关闭遮罩点击触发 onClose | `overlay_and_zindex_use_tokens` |
| `not-closable-blocks-overlay-close` | 不可关闭遮罩吞掉点击 | `overlay_and_zindex_use_tokens` |
| `hidden-not-rendered` | 隐藏时不渲染 | `card_dimensions_use_tokens`（visible gate） |
| `title-renders-text` | 标题消费字号令牌 | `title_and_content_use_font_tokens` |
| `danger-type-uses-danger-token` | 危险类型确认按钮取危险色 | `danger_type_uses_danger_token` |

另有暗色专项：`dark_colors_come_from_dark_tokens` / `dimensions_are_identical_in_dark_mode`。
运行：DevEco Studio 右键 `entry/src/test` → Run Tests。
