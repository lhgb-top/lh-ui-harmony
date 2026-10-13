import { LhTextareaTokens, LhTextareaAppearance } from './LhTextareaTokens'
import { LH_COLORS_KEY, LightLhColors, LhColors } from '../../common/theme/LhTheme'
import { lhVp } from '../../common/LhVp'

/**
 * 多行输入框组件：可伸缩高度的长文本录入（ArkUI 手写）。
 *
 * props 与 `lh-ui-core/specs/textarea.json` 逐字对齐；行为遵循 `cases/textarea.json`
 * 的 6 条黄金用例（已翻译为 hypium 测试，见 entry/src/test/Textarea.test.ets）。
 *
 * 受控语义与 LhInput 同构：value 由宿主持有，输入时通过 onValueChange 上报。
 */
@Component
export struct LhTextarea {
  /** 当前文本值（受控） */
  @Prop value: string = ''
  /** 占位提示文字，取 color.text.placeholder 令牌 */
  @Prop placeholder: string = ''
  /** 初始可见行数；高度随行数与内容增长 */
  @Prop @Watch('recompute') rows: number = 3
  /** 是否禁用；禁用时不响应输入、不触发 onValueChange 且呈现禁用样式 */
  @Prop @Watch('recompute') disabled: boolean = false
  /** 是否只读；只读时可聚焦但不接受输入、不触发 onValueChange */
  @Prop @Watch('recompute') readonly: boolean = false
  /** 是否在右下角显示字数统计（当前长度 / 最大长度） */
  @Prop showCount: boolean = false
  /** 最大字符数；超出时截断新输入；showCount 时作为分母 */
  @Prop maxlength?: number = undefined

  /** 文本变化时触发；disabled 或 readonly 为 true 时不触发（回调属性不加 @Prop） */
  onValueChange: (value: string) => void = () => {}
  onFocus: () => void = () => {}
  onBlur: () => void = () => {}

  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''
  @State focused: boolean = false

  private appearance: LhTextareaAppearance = LhTextareaTokens.resolve(3, false, false, LightLhColors())

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    let colors = LightLhColors()
    if (this.colorsJson !== '') {
      colors = JSON.parse(this.colorsJson) as LhColors
    }
    this.appearance = LhTextareaTokens.resolve(this.rows, this.disabled, this.focused, colors)
  }

  build() {
    Column() {
      TextArea({
        text: this.value,
        placeholder: this.placeholder,
      })
        .fontSize(lhVp(this.appearance.fontSize))
        .fontColor(this.appearance.textColor)
        .placeholderColor(this.appearance.placeholderColor)
        .backgroundColor(Color.Transparent)
        .maxLength(this.maxlength === undefined ? -1 : this.maxlength)
        .readOnly(this.readonly)
        .enabled(this.appearance.enabled)
        .constraintSize({ minHeight: lhVp(LhTextareaTokens.heightForRows(this.rows, this.appearance)) })
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
          this.onValueChange(LhTextareaTokens.truncate(newValue, this.maxlength))
        })

      if (this.showCount) {
        Row() {
          Blank()
          Text(LhTextareaTokens.countText(this.value, this.maxlength))
            .fontSize(lhVp(this.appearance.countFontSize))
            .fontColor(this.appearance.countColor)
            .margin({ top: lhVp(this.appearance.paddingVertical) })
        }
        .width('100%')
      }
    }
    .padding({
      left: lhVp(this.appearance.paddingHorizontal),
      right: lhVp(this.appearance.paddingHorizontal),
      top: lhVp(this.appearance.paddingVertical),
      bottom: lhVp(this.appearance.paddingVertical),
    })
    .backgroundColor(this.appearance.containerColor)
    .borderRadius(lhVp(this.appearance.borderRadius))
    .border({
      width: lhVp(this.appearance.borderWidth),
      color: this.appearance.borderColor,
    })
  }
}
