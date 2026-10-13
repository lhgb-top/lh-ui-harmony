import { LhSwitchSize, LhSwitchTokens, LhSwitchAppearance } from './LhSwitchTokens'
import { LH_COLORS_KEY, LightLhColors, LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'
import { lhVp } from '../../common/LhVp'

/**
 * 开关组件：胶囊轨道 + 圆形滑块的两态切换控件（ArkUI 手写）。
 *
 * props 与 `lh-ui-core/specs/switch.json` 逐字对齐；行为遵循 `cases/switch.json`
 * 的 6 条黄金用例（已翻译为 hypium 测试，见 entry/src/test/Switch.test.ets）。
 *
 * 点击命中轨道区域：翻转开关态并触发 onChange 携带新开关态。
 */
@Component
export struct LhSwitch {
  /** 是否开启 */
  @Prop @Watch('recompute') checked: boolean = false
  /** 是否禁用；禁用时不响应点击且呈现禁用样式 */
  @Prop @Watch('recompute') disabled: boolean = false
  /** 是否加载中；加载中滑块位置显示加载环且不响应点击 */
  @Prop @Watch('recompute') loading: boolean = false
  /** 开关尺寸，映射到 switch.width / switch.height 令牌 */
  @Prop @Watch('recompute') size: LhSwitchSize = LhSwitchSize.Medium

  /** 点击切换开关态时触发；disabled 或 loading 为 true 时不触发（回调属性不加 @Prop） */
  onChange: (checked: boolean) => void = () => {}

  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''

  private appearance: LhSwitchAppearance = LhSwitchTokens.resolve(
    false, false, false, LhSwitchSize.Medium, LightLhColors(),
  )

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    let colors = LightLhColors()
    if (this.colorsJson !== '') {
      colors = JSON.parse(this.colorsJson) as LhColors
    }
    this.appearance = LhSwitchTokens.resolve(this.checked, this.disabled, this.loading, this.size, colors)
  }

  build() {
    Stack() {
      if (this.loading) {
        // 加载中：滑块位置改画加载环（主色）
        LoadingProgress()
          .width(lhVp(this.appearance.thumbSize))
          .height(lhVp(this.appearance.thumbSize))
          .color(this.appearance.loadingColor)
          .offset({ x: lhVp(this.appearance.thumbOffset) })
      } else {
        // 滑块（圆形）
        Circle()
          .width(lhVp(this.appearance.thumbSize))
          .height(lhVp(this.appearance.thumbSize))
          .fill(this.appearance.thumbColor)
          .offset({ x: lhVp(this.appearance.thumbOffset) })
          .animation({
            duration: LhTokens.Motion.Duration.base,
            curve: Curve.EaseInOut,
          })
      }
    }
    .width(lhVp(this.appearance.width))
    .height(lhVp(this.appearance.height))
    .backgroundColor(this.appearance.trackColor)
    .borderRadius(lhVp(this.appearance.borderRadius))
    .alignContent(Alignment.Start)
    .enabled(this.appearance.enabled)
    .onClick(() => {
      // 状态 gate：disabled 或 loading 为 true 时不触发
      if (!this.appearance.enabled) {
        return
      }
      this.onChange(!this.checked)
    })
  }
}
