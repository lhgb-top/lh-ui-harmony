import { LhInputType, LhInputSize, LhInputTokens, LhInputAppearance } from './LhInputTokens'
import { LH_COLORS_KEY, LightLhColors, LhColors } from '../../common/theme/LhTheme'
import { LhIconTokens } from '../icon/LhIconTokens'
import { lhVp } from '../../common/LhVp'

/**
 * 输入框组件：单行文本录入（ArkUI 手写）。
 *
 * props 与 `lh-ui-core/specs/input.json` 逐字对齐；行为遵循 `cases/input.json`
 * 的 8 条黄金用例（已翻译为 hypium 测试，见 entry/src/test/Input.test.ets）。
 *
 * 受控语义：value 是外部传入的当前值，输入时通过 onValueChange 上报新值，
 * 由宿主回写 value（与 react 的受控 input 同构）。
 */
@Component
export struct LhInput {
  /** 当前文本值（受控） */
  @Prop value: string = ''
  /** 占位提示文字，取 color.text.placeholder 令牌 */
  @Prop placeholder: string = ''
  /** 输入类型；password 时以圆点掩码显示 */
  @Prop type: LhInputType = LhInputType.Text
  /** 输入框尺寸，映射到 input.height / paddingHorizontal / fontSize 令牌 */
  @Prop @Watch('recompute') size: LhInputSize = LhInputSize.Medium
  /** 是否禁用；禁用时不响应输入、不触发 onValueChange 且呈现禁用样式 */
  @Prop @Watch('recompute') disabled: boolean = false
  /** 是否只读；只读时可聚焦但不接受输入、不触发 onValueChange */
  @Prop @Watch('recompute') readonly: boolean = false
  /** 是否显示清除按钮；value 非空时点击触发 onValueChange("") */
  @Prop clearable: boolean = false
  /** 最大字符数；超出时截断新输入 */
  @Prop maxlength?: number = undefined

  /** 文本变化时触发；disabled 或 readonly 为 true 时不触发（回调属性不加 @Prop） */
  onValueChange: (value: string) => void = () => {}
  /** 获得焦点时触发 */
  onFocus: () => void = () => {}
  /** 失去焦点时触发 */
  onBlur: () => void = () => {}

  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''
  /** 聚焦态：聚焦环据此切换（外观变化驱动 @Watch 重算） */
  @State focused: boolean = false

  private appearance: LhInputAppearance = LhInputTokens.resolve(
    LhInputSize.Medium, false, false, LightLhColors(),
  )

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    let colors = LightLhColors()
    if (this.colorsJson !== '') {
      colors = JSON.parse(this.colorsJson) as LhColors
    }
    this.appearance = LhInputTokens.resolve(this.size, this.disabled, this.focused, colors)
  }

  build() {
    Row() {
      TextInput({
        text: this.value,
        placeholder: this.placeholder,
      })
        .type(this.type === LhInputType.Password ? InputType.Password : InputType.Normal)
        .fontSize(lhVp(this.appearance.fontSize))
        .fontColor(this.appearance.textColor)
        .placeholderColor(this.appearance.placeholderColor)
        .backgroundColor(Color.Transparent)
        .maxLength(this.maxlength === undefined ? -1 : this.maxlength)
        .readOnly(this.readonly)
        .enabled(this.appearance.enabled)
        .layoutWeight(1)
        .onFocus(() => {
          this.focused = true
          this.recompute()
          this.onFocus()
        })
        .onBlur(() => {
          this.focused = false
          this.recompute()
          this.onBlur()
        })
        .onChange((newValue: string) => {
          // 状态 gate：disabled 或 readonly 为 true 时不触发 onValueChange
          if (this.disabled || this.readonly) {
            return
          }
          this.onValueChange(LhInputTokens.truncate(newValue, this.maxlength))
        })

      if (this.clearable && this.value !== '' && !this.disabled && !this.readonly) {
        // 清除按钮；点击触发 onValueChange("")
        Text(LhIconTokens.glyphFor('close'))
          .fontSize(lhVp(this.appearance.clearIconSize))
          .fontColor(this.appearance.placeholderColor)
          .margin({ left: lhVp(this.appearance.paddingHorizontal) })
          .onClick(() => {
            this.onValueChange('')
          })
      }
    }
    .height(lhVp(this.appearance.height))
    .padding({ left: lhVp(this.appearance.paddingHorizontal), right: lhVp(this.appearance.paddingHorizontal) })
    .backgroundColor(this.appearance.containerColor)
    .borderRadius(lhVp(this.appearance.borderRadius))
    .border({
      width: lhVp(this.appearance.borderWidth),
      color: this.appearance.borderColor,
    })
  }
}
