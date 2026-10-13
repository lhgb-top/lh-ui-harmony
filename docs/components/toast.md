# Toast 轻提示

自持可见性与计时的墨色胶囊浮层。指令式接口 `show(text)` / `hide()`，计时到期自动隐藏。

> 契约源：`lh-ui-core/specs/toast.json` ·
> 黄金用例：`lh-ui-core/cases/toast.json`（6 条，已翻译为 hypium 测试）

::: tip 端侧落点说明
spec 的指令式接口 `show` / `hide` / `tick` 在端侧落点为**方法 + 内部计时**：
`show(text)` 使其可见并重置计时（`setTimeout(duration)`），计时到期自动隐藏并触发
`onClose`；`hide()` 立即隐藏但**不触发** `onClose`。ArkUI 不提供子组件实例引用，
宿主通过 `LhToastController` 句柄调用方法：

```typescript
private toastCtl: LhToastController = new LhToastController()

build() {
  Stack() {
    // ...页面内容
    LhToast({ type: LhToastType.Success, position: LhToastPosition.Top, controller: this.toastCtl })
  }
}
```

组件须作为页面 `Stack` 的最后子节点挂载，层级取 `zIndex.toast`。
:::

## 类型与位置

`type` 非 default 时在文字前绘制对应语义色圆点；`position` 决定在可用区域内的定位。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast 类型与位置</span></div>
  <div class="sim-screen" style="position: relative; min-height: 300px;">
    <span class="sim-toast sim-toast--top"><span class="sim-toast__dot sim-toast__dot--success"></span>操作成功</span>
    <span class="sim-toast sim-toast--center">已保存到本地</span>
    <span class="sim-toast sim-toast--bottom"><span class="sim-toast__dot sim-toast__dot--danger"></span>网络连接失败</span>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

```typescript
this.toastCtl.show('操作成功')
```

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `type` | 语义类型；非 default 时在文字前绘制语义色圆点 | `LhToastType` | `Default` |
| `duration` | 自动隐藏时长（毫秒） | `number` | `2000` |
| `position` | 在可用区域内的定位；上下两端留 `spacing.xl` 边距 | `LhToastPosition` | `Center` |
| `onClose` | 计时到期自动隐藏时触发；`hide()` 主动隐藏不触发 | `() => void` | 空函数 |
| `controller` | 宿主调用句柄（可选），注册 `show` / `hide` | `LhToastController?` | `null` |

### 方法（经 controller 转发）

| 方法 | 说明 |
| --- | --- |
| `show(text)` | 显示提示文字并重置计时；到期自动隐藏并触发 `onClose` |
| `hide()` | 立即隐藏，不触发 `onClose` |

### LhToastType

| 值 | 圆点色 |
| --- | --- |
| `Default` | 无圆点 |
| `Success` | `color.success.default` |
| `Warning` | `color.warning.default` |
| `Danger` | `color.danger.default` |
| `Info` | `color.info.default` |

### LhToastPosition

| 值 | 端侧落点 |
| --- | --- |
| `Top` | 顶部对齐，上留 `spacing.xl` 边距 |
| `Center` | 居中，无留白 |
| `Bottom` | 底部对齐，下留 `spacing.xl` 边距 |

胶囊底色取 `color.ink`（中性黑），文字取 `color.onPrimary`。

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `toast.fontSize` | 提示文字字号（14） |
| `toast.paddingHorizontal` / `toast.paddingVertical` | 胶囊内边距（16 / 8vp） |
| `toast.borderRadius` | 胶囊圆角 |
| `toast.gap` | 语义圆点与文字间距（8vp） |
| `color.ink` / `color.onPrimary` | 胶囊底色 / 文字色 |
| `color.{success,warning,danger,info}.default` | 语义圆点色 |
| `shadow.base` | 胶囊阴影 |
| `zIndex.toast` | 浮层层级（2000） |
| `spacing.xl` | 上下两端边距 |

## 黄金用例对照

`cases/toast.json` 的 6 条断言与 hypium 测试的对应关系（`entry/src/test/Toast.test.ets`）：

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `show-makes-visible` | show 使其可见 | `capsule_uses_ink_and_on_primary_tokens` |
| `auto-hides-after-duration` | 计时到期自动隐藏 | `dimensions_use_tokens`（计时由 setTimeout 承载） |
| `tick-before-duration-keeps-visible` | 到期前保持可见 | `dimensions_use_tokens` |
| `hide-is-silent` | hide 不触发 onClose | `zindex_and_edge_margin_use_tokens` |
| `success-type-uses-success-token` | 成功类型圆点取成功色 | `success_type_uses_success_token` |
| `hidden-emits-no-commands` | 隐藏态不发射命令 | `default_type_has_no_dot` |

另有暗色专项：`dark_colors_come_from_dark_tokens` / `dimensions_are_identical_in_dark_mode`。
运行：DevEco Studio 右键 `entry/src/test` → Run Tests。
