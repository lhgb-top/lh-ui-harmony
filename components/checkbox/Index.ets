import {
  LhCheckboxSize,
  LhCheckboxMark,
  LhCheckboxTokens,
  LhCheckboxAppearance,
} from './LhCheckboxTokens'
import { LH_COLORS_KEY, LightLhColors, LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'
import { LhIconTokens } from '../icon/LhIconTokens'
import { lhVp } from '../../common/LhVp'

/**
 * 复选框组件：三态选中控件（ArkUI 手写）。
 *
 * props 与 `lh-ui-core/specs/checkbox.json` 逐字对齐；行为遵循 `cases/checkbox.json`
 * 的 6 条黄金用例（已翻译为 hypium 测试，见 entry/src/test/Checkbox.test.ets）。
 *
 * 点击命中整个行（方框 + 标签区域）：indeterminate 变为选中，否则翻转选中态，
 * 并触发 onChange 携带新选中态。
 */
@Component
export struct LhCheckbox {
  /** 是否选中 */
  @Prop @Watch('recompute') checked: boolean = false
  /** 是否为不确定态（横杠指示）；点击后变为选中 */
  @Prop @Watch('recompute') indeterminate: boolean = false
  /** 是否禁用；禁用时不响应点击且呈现禁用样式 */
  @Prop @Watch('recompute') disabled: boolean = false
  /** 文字标签（绘制在方框右侧） */
  @Prop label: string = ''
  /** 方框尺寸，映射到 checkbox.size.* 令牌 */
  @Prop @Watch('recompute') size: LhCheckboxSize = LhCheckboxSize.Medium

  /** 点击切换选中态时触发；disabled 为 true 时不触发（回调属性不加 @Prop） */
  onChange: (checked: boolean) => void = () => {}

  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''

  private appearance: LhCheckboxAppearance = LhCheckboxTokens.resolve(
    false, false, false, LhCheckboxSize.Medium, LightLhColors(),
  )

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    let colors = LightLhColors()
    if (this.colorsJson !== '') {
      colors = JSON.parse(this.colorsJson) as LhColors
    }
    this.appearance = LhCheckboxTokens.resolve(
      this.checked, this.indeterminate, this.disabled, this.size, colors,
    )
  }

  build() {
    Row() {
      // 方框（实心底 + 指示符）
      Stack() {
        if (this.appearance.mark === LhCheckboxMark.Check) {
          // 选中：勾形（端侧落点为 ✓ 字形）
          Text(LhIconTokens.glyphFor('check'))
            .fontSize(lhVp(this.appearance.size))
            .fontColor(this.appearance.markColor)
        } else if (this.appearance.mark === LhCheckboxMark.Dash) {
          // 不确定：横杠
          Text('－')
            .fontSize(lhVp(this.appearance.size))
            .fontColor(this.appearance.markColor)
        }
      }
      .width(lhVp(this.appearance.size))
      .height(lhVp(this.appearance.size))
      .backgroundColor(this.appearance.containerColor)
      .borderRadius(lhVp(this.appearance.borderRadius))
      .border({
        width: lhVp(this.appearance.borderWidth),
        color: this.appearance.borderColor,
      })

      if (this.label !== '') {
        Text(this.label)
          .fontSize(lhVp(this.labelFontSize()))
          .fontColor(this.appearance.labelColor)
          .margin({ left: lhVp(this.appearance.gap) })
      }
    }
    .alignItems(VerticalAlign.Center)
    .enabled(this.appearance.enabled)
    .onClick(() => {
      // 状态 gate：disabled 为 true 时不触发
      if (!this.appearance.enabled) {
        return
      }
      this.onChange(LhCheckboxTokens.nextChecked(this.checked, this.indeterminate))
    })
  }

  /** 标签字号：复选框标签取正文基准字号（typography.fontSize.base） */
  private labelFontSize(): number {
    return LhTokens.Typography.FontSize.base
  }
}
