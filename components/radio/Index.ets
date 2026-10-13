import { LhRadioSize, LhRadioTokens, LhRadioAppearance } from './LhRadioTokens'
import { LH_COLORS_KEY, LightLhColors, LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'
import { lhVp } from '../../common/LhVp'

/**
 * 单选框组件：圆环选中控件（ArkUI 手写）。
 *
 * props 与 `lh-ui-core/specs/radio.json` 逐字对齐；行为遵循 `cases/radio.json`
 * 的 6 条黄金用例（已翻译为 hypium 测试，见 entry/src/test/Radio.test.ets）。
 *
 * 点击命中整个行（圆环 + 标签区域）：仅当未选中且未禁用时变为选中并触发
 * onChange(checked=true)；已选中时点击不触发。组件本身不含组逻辑，由宿主维护单选组。
 */
@Component
export struct LhRadio {
  /** 是否选中 */
  @Prop @Watch('recompute') checked: boolean = false
  /** 是否禁用；禁用时不响应点击且呈现禁用样式 */
  @Prop @Watch('recompute') disabled: boolean = false
  /** 文字标签（绘制在圆环右侧） */
  @Prop label: string = ''
  /** 单选值（组内标识，组件本身不含组逻辑，由宿主维护单选组） */
  @Prop value: string = ''
  /** 圆环尺寸，映射到 radio.size.* 令牌 */
  @Prop @Watch('recompute') size: LhRadioSize = LhRadioSize.Medium

  /** 由未选中变为选中时触发；已选中时点击不触发，disabled 为 true 时不触发（回调属性不加 @Prop） */
  onChange: (checked: boolean) => void = () => {}

  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''

  private appearance: LhRadioAppearance = LhRadioTokens.resolve(
    false, false, LhRadioSize.Medium, LightLhColors(),
  )

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    let colors = LightLhColors()
    if (this.colorsJson !== '') {
      colors = JSON.parse(this.colorsJson) as LhColors
    }
    this.appearance = LhRadioTokens.resolve(this.checked, this.disabled, this.size, colors)
  }

  build() {
    Row() {
      // 外环（描边圆 + 内圆点）
      Stack() {
        if (this.appearance.showDot) {
          // 选中时内部画实心圆点，直径 = 尺寸 × dotScale
          Circle()
            .width(lhVp(this.appearance.dotSize))
            .height(lhVp(this.appearance.dotSize))
            .fill(this.appearance.dotColor)
        }
      }
      .width(lhVp(this.appearance.size))
      .height(lhVp(this.appearance.size))
      .borderRadius(lhVp(this.appearance.size / 2))
      .border({
        width: lhVp(this.appearance.ringWidth),
        color: this.appearance.ringColor,
      })

      if (this.label !== '') {
        Text(this.label)
          .fontSize(lhVp(LhTokens.Typography.FontSize.base))
          .fontColor(this.appearance.labelColor)
          .margin({ left: lhVp(this.appearance.gap) })
      }
    }
    .alignItems(VerticalAlign.Center)
    .enabled(this.appearance.enabled)
    .onClick(() => {
      // 状态 gate：仅当未选中且未禁用时变为选中并触发 onChange(checked=true)
      if (!this.appearance.enabled || this.checked) {
        return
      }
      this.onChange(true)
    })
  }
}
