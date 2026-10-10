# 快速开始

## 最小示例

```typescript
import { LhButton } from '../components/button/Index'
import { LhButtonType } from '../components/button/LhButtonTokens'
import { LhTheme } from '../common/theme/LhThemeApply'

@Entry
@Component
struct Demo {
  aboutToAppear(): void {
    LhTheme.apply(false) // 注入明色板；切暗色传 true
  }

  build() {
    Column() {
      LhButton({
        onClick: () => { /* 处理点击 */ },
        type: LhButtonType.Primary,
        text: '主要按钮',
      })
    }
  }
}
```

`LhTheme.apply(isDark)` 把色板序列化进 AppStorage，所有 Lh 组件自动消费；不调用时回退明色板。

## 类型与尺寸

```typescript
// 六种类型
LhButton({ onClick: () => {}, text: '默认' })                        // Default
LhButton({ onClick: () => {}, type: LhButtonType.Primary, text: '主要' })
LhButton({ onClick: () => {}, type: LhButtonType.Success, text: '成功' })
LhButton({ onClick: () => {}, type: LhButtonType.Warning, text: '警告' })
LhButton({ onClick: () => {}, type: LhButtonType.Danger, text: '危险' })
LhButton({ onClick: () => {}, type: LhButtonType.Info, text: '信息' })

// 三种尺寸
LhButton({ onClick: () => {}, size: LhButtonSize.Small, text: '小型' })
LhButton({ onClick: () => {}, size: LhButtonSize.Medium, text: '中型' })
LhButton({ onClick: () => {}, size: LhButtonSize.Large, text: '大型' })
```

## 状态

```typescript
// 禁用：不响应点击（.enabled 拦截），呈现禁用样式
LhButton({ onClick: () => {}, disabled: true, text: '禁用' })

// 加载中：显示指示器，不触发 onClick
LhButton({ onClick: () => {}, loading: true, text: '加载中' })

// 两者共存：按禁用优先处理（黄金用例 disabled-precedes-loading）
LhButton({ onClick: () => {}, disabled: true, loading: true, text: '禁用优先' })
```

## 图标与花纹底

```typescript
// 图标名按本地图标体系解析（SymbolGlyph 映射见 LhButtonTokens.iconFor，未登记名不绘制）
LhButton({ onClick: () => {}, type: LhButtonType.Primary, icon: 'search', text: '搜索' })

// 国风花纹底纹（消费 color.decoration 令牌）
LhButton({ onClick: () => {}, type: LhButtonType.Primary, bgPattern: true, text: '花纹底' })
```

## 明暗主题

```typescript
LhTheme.apply(true)  // 全局切暗色；所有组件下次外观解析时自动跟随
```

## 组件示例预览

原生 UI 无法在浏览器实时渲染，本站用**内联静态 HTML 手机框模拟器**展示外观：

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>lh-ui-harmony</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">默认按钮</button>
      <button class="sim-btn sim-btn--primary">主要按钮</button>
      <button class="sim-btn sim-btn--success">成功</button>
      <button class="sim-btn sim-btn--warning">警告</button>
      <button class="sim-btn sim-btn--danger">危险</button>
      <button class="sim-btn sim-btn--info">信息</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">小型</button>
      <button class="sim-btn sim-btn--primary sim-btn--large">大型</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">禁用</button>
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>加载中
      </button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>搜索</button>
      <button class="sim-btn sim-btn--primary sim-btn--pattern">花纹底</button>
    </div>
  </div>
</div>
<p class="sim-note">鸿蒙（ArkUI）外观的 HTML 模拟预览，非真机渲染；样式值全部取自 core 令牌快照，与真机同源同值。真机外观以 entry 演示应用与设备截图为准。</p>

> 模拟器的暗色与站点联动：右上角切换主题，手机框内颜色即变（暗色令牌由 core 预计算）。
