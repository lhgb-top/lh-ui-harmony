# Switch 开关

开关控件。点击翻转开合态，支持禁用与加载中遮罩。

> 契约源：`lh-ui-core/specs/switch.json` ·
> 黄金用例：`lh-ui-core/cases/switch.json`（6 条，已翻译为 hypium 测试）

## 基本用法

`checked` 受控，点击翻转并触发 `onChange` 携带新开合态。滑块位移动画取
`motion.duration.base`。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Switch 基本</span></div>
  <div class="sim-screen">
    <div class="sim-row" style="gap: var(--lh-spacing-xl);">
      <span class="sim-switch sim-switch--checked"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

```typescript
LhSwitch({
  checked: this.enabled,
  onChange: (checked: boolean) => { this.enabled = checked },
})
```

## 尺寸

三档尺寸映射到 `switch.width` / `switch.height` 令牌；轨道圆角与滑块偏移随高度换算。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Switch 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row" style="gap: var(--lh-spacing-xl);">
      <span class="sim-switch sim-switch--checked sim-switch--small"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--checked"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--checked sim-switch--large"><span class="sim-switch__thumb"></span></span>
    </div>
    <div class="sim-row" style="gap: var(--lh-spacing-xl);">
      <span class="sim-switch sim-switch--small"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--large"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

## 状态

`disabled` 与 `loading` 都阻止切换（黄金用例 `loading-blocks-change`）；
加载中时轨道中央显示平台指示器。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Switch 状态</span></div>
  <div class="sim-screen">
    <div class="sim-row" style="gap: var(--lh-spacing-xl);">
      <span class="sim-switch sim-switch--checked sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--checked sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `checked` | 是否开启 | `boolean` | `false` |
| `disabled` | 是否禁用；禁用时不触发 `onChange` | `boolean` | `false` |
| `loading` | 是否加载中；加载时不触发 `onChange`，轨道显示指示器 | `boolean` | `false` |
| `size` | 开关尺寸，映射到尺寸令牌 | `LhSwitchSize` | `Medium` |
| `onChange` | 点击切换时触发，携带新开合态 | `(checked: boolean) => void` | 空函数 |

### LhSwitchSize

| 值 | width | height |
| --- | --- | --- |
| `Small` | `switch.width.small`（36vp） | `switch.height.small`（20vp） |
| `Medium` | `switch.width.medium`（44vp） | `switch.height.medium`（24vp） |
| `Large` | `switch.width.large`（52vp） | `switch.height.large`（28vp） |

开轨底色 `color.primary.default`；关轨底色 `color.background.disabled`；
滑块 `color.onPrimary`，直径 = 高度 − 2 × `switch.gap`。

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `switch.width.{small,medium,large}` | 三档轨道宽度 |
| `switch.height.{small,medium,large}` | 三档轨道高度（圆角与滑块偏移据此换算） |
| `switch.gap` | 滑块与轨道之间的留白（2vp） |
| `color.primary.default` | 开轨底色 |
| `color.background.disabled` | 关轨底色 |
| `color.onPrimary` | 滑块色 |
| `color.disabled.*` | 禁用态色 |
| `motion.duration.base` | 滑块位移动画时长（300ms） |

## 黄金用例对照

`cases/switch.json` 的 6 条断言与 hypium 测试的对应关系（`entry/src/test/Switch.test.ets`）：

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | 点击翻转并触发 onChange | `enabled_is_interactive` |
| `tap-checked-turns-off` | 开启态点击关闭 | `thumb_offset_follows_checked`（位移断言） |
| `disabled-blocks-change` | 禁用态不触发 onChange | `disabled_is_not_interactive` |
| `loading-blocks-change` | 加载态不触发 onChange | `loading_is_not_interactive` |
| `checked-uses-primary-token` | 开轨消费主色令牌 | `checked_uses_primary_token` |
| `unchecked-uses-border-token` | 关轨消费禁用底色令牌 | `unchecked_uses_border_token` |

另有暗色专项：`dark_colors_come_from_dark_tokens` / `dimensions_are_identical_in_dark_mode`。
运行：DevEco Studio 右键 `entry/src/test` → Run Tests。
