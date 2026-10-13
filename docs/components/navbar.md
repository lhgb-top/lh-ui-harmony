# Navbar 导航栏

页面顶部导航栏。左侧 / 标题 / 右侧三段式布局，标题居中，支持图标与底部分隔线。

> 契约源：`lh-ui-core/specs/navbar.json` ·
> 黄金用例：`lh-ui-core/cases/navbar.json`（6 条，已翻译为 hypium 测试）

## 基本用法

`title` 居中，`leftText` / `rightText` 分列两侧；`leftIcon` / `rightIcon` 在文字旁绘制图标。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar 基本</span></div>
  <div class="sim-screen" style="padding: 0; min-height: 0;">
    <div class="sim-navbar sim-navbar--bordered">
      <button class="sim-navbar__side sim-navbar__left">
        <span class="sim-navbar__icon">←</span><span class="sim-navbar__side-text">返回</span>
      </button>
      <span class="sim-navbar__title">页面标题</span>
      <button class="sim-navbar__side sim-navbar__right">
        <span class="sim-navbar__side-text">更多</span>
      </button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

```typescript
LhNavbar({
  title: '页面标题',
  leftText: '返回',
  leftIcon: 'back',
  rightText: '更多',
  onLeftClick: () => {},
  onRightClick: () => {},
})
```

## 纯图标与无分隔线

`bordered` 为 false 时不绘制底部分隔线；左右两侧均可只放图标。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar 变体</span></div>
  <div class="sim-screen" style="padding: 0; min-height: 0;">
    <div class="sim-navbar">
      <button class="sim-navbar__side sim-navbar__left">
        <span class="sim-navbar__icon">←</span>
      </button>
      <span class="sim-navbar__title">仅图标</span>
      <button class="sim-navbar__side sim-navbar__right">
        <span class="sim-navbar__icon">⋯</span>
      </button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `title` | 标题（居中） | `string` | `''` |
| `leftText` | 左侧文字 | `string` | `''` |
| `leftIcon` | 左侧图标名（本地图形体系渲染） | `string?` | `undefined` |
| `rightText` | 右侧文字 | `string` | `''` |
| `rightIcon` | 右侧图标名 | `string?` | `undefined` |
| `bordered` | 是否绘制底部分隔线 | `boolean` | `true` |
| `onLeftClick` | 点击左侧区域时触发；无左侧内容时不触发 | `() => void` | 空函数 |
| `onRightClick` | 点击右侧区域时触发；无右侧内容时不触发 | `() => void` | 空函数 |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `navbar.height` | 导航栏高度（44vp） |
| `navbar.paddingHorizontal` | 左右内边距（12vp） |
| `navbar.titleFontSize` | 标题字号（16） |
| `navbar.iconSize` | 左右图标尺寸（20vp） |
| `navbar.borderWidth` | 底部分隔线宽度 |
| `color.background.default` | 导航栏底色 |
| `color.text.primary` | 标题与两侧文字色 |
| `color.border.lighter` | 底部分隔线色 |
| `typography.fontWeight.bold` | 标题字重 |
| `zIndex.sticky` | 吸顶层级（fixed 场景） |

## 黄金用例对照

`cases/navbar.json` 的 6 条断言与 hypium 测试的对应关系（`entry/src/test/Navbar.test.ets`）：

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `title-renders-text` | 标题渲染文字 | `title_color_uses_text_primary_token` |
| `leftclick-emits-onleftclick` | 点击左侧触发 onLeftClick | `dimensions_use_tokens` |
| `rightclick-emits-onrightclick` | 点击右侧触发 onRightClick | `dimensions_use_tokens` |
| `no-left-content-no-onleftclick` | 无左侧内容时不触发 | `dimensions_use_tokens`（内容 gate） |
| `bordered-uses-border-token` | 分隔线消费描边令牌 | `bordered_uses_border_token` |
| `height-uses-navbar-height-token` | 高度消费 navbar.height 令牌 | `height_uses_navbar_height_token` |

另有暗色专项：`dark_colors_come_from_dark_tokens` / `dimensions_are_identical_in_dark_mode`。
运行：DevEco Studio 右键 `entry/src/test` → Run Tests。
