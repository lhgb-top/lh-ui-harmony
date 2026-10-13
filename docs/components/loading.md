# Loading 加载

环形旋转加载指示器。支持三档尺寸与五种语义色。

> 契约源：`lh-ui-core/specs/loading.json` ·
> 黄金用例：`lh-ui-core/cases/loading.json`（5 条，已翻译为 hypium 测试）

旋转动画由 ArkUI 的 `LoadingProgress` 内置驱动（spec 的「旋转交由后端驱动」在本端由平台动画承担）。

## 尺寸

三档尺寸映射到 `loading.size` 令牌。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Loading 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row" style="gap: var(--lh-spacing-xl);">
      <span class="sim-loading sim-loading--small"></span>
      <span class="sim-loading"></span>
      <span class="sim-loading sim-loading--large"></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

```typescript
LhLoading({ size: LhLoadingSize.Large })
```

## 色调

`tone` 决定环色，与语义色令牌一一对应。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Loading 色调</span></div>
  <div class="sim-screen">
    <div class="sim-row" style="gap: var(--lh-spacing-xl);">
      <span class="sim-loading"></span>
      <span class="sim-loading sim-loading--success"></span>
      <span class="sim-loading sim-loading--warning"></span>
      <span class="sim-loading sim-loading--danger"></span>
      <span class="sim-loading sim-loading--info"></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（鸿蒙 / ArkUI 外观），非真机渲染</p>

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `size` | 指示器直径，映射到 `loading.size` 令牌 | `LhLoadingSize` | `Medium` |
| `tone` | 环色，取对应语义色令牌 | `LhLoadingTone` | `Primary` |

### LhLoadingSize

| 值 | size |
| --- | --- |
| `Small` | `loading.size.small`（16vp） |
| `Medium` | `loading.size.medium`（20vp） |
| `Large` | `loading.size.large`（24vp） |

### LhLoadingTone

| 值 | 环色 |
| --- | --- |
| `Primary` | `color.primary.default` |
| `Success` | `color.success.default` |
| `Warning` | `color.warning.default` |
| `Danger` | `color.danger.default` |
| `Info` | `color.info.default` |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `loading.size.{small,medium,large}` | 三档直径 |
| `loading.strokeWidth` | 环描边宽度（2vp） |
| `color.{primary,success,warning,danger,info}.default` | 五种环色 |

## 黄金用例对照

`cases/loading.json` 的 5 条断言与 hypium 测试的对应关系（`entry/src/test/Loading.test.ets`）：

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `medium-size-uses-medium-token` | 中号取 medium 尺寸令牌 | `medium_size_uses_medium_token` |
| `large-size-uses-large-token` | 大号取 large 尺寸令牌 | `large_size_uses_large_token` |
| `primary-tone-uses-primary-token` | 主色调取主色令牌 | `primary_tone_uses_primary_token` |
| `success-tone-uses-success-token` | 成功色调取成功色令牌 | `success_tone_uses_success_token` |
| `render-emits-ring-command` | 渲染发射环形命令 | 端侧无对应命令（`LoadingProgress` 平台组件，描边宽度见 `stroke_width_uses_token`） |

另有暗色专项：`dark_colors_come_from_dark_tokens` / `dimensions_are_identical_in_dark_mode`。
运行：DevEco Studio 右键 `entry/src/test` → Run Tests。
