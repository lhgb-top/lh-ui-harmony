import { LhTagType, LhTagSize, LhTagTokens, LhTagAppearance } from './LhTagTokens'
import { LH_COLORS_KEY, LightLhColors, LhColors } from '../../common/theme/LhTheme'
import { LhIconTokens } from '../icon/LhIconTokens'
import { lhVp } from '../../common/LhVp'

/**
 * 标签组件：小体积状态标记（ArkUI 手写）。
 *
 * props 与 `lh-ui-core/specs/tag.json` 逐字对齐；行为遵循 `cases/tag.json`
 * 的 6 条黄金用例（已翻译为 hypium 测试，见 entry/src/test/Tag.test.ets）。
 */
@Component
export struct LhTag {
  /** 标签文字（spec 的 default 插槽） */
  @Prop text: string = ''
  /** 语义类型，决定底色、文字色与描边色 */
  @Prop @Watch('recompute') type: LhTagType = LhTagType.Default
  /** 标签尺寸，映射到 tag.height / paddingHorizontal / fontSize 令牌 */
  @Prop @Watch('recompute') size: LhTagSize = LhTagSize.Medium
  /** 是否为浅底描边形态 */
  @Prop @Watch('recompute') plain: boolean = false
  /** 是否为胶囊形态（圆角取高度一半） */
  @Prop @Watch('recompute') round: boolean = false
  /** 是否显示关闭符；点击关闭符区域触发 onClose */
  @Prop @Watch('recompute') closable: boolean = false

  /** 点击关闭符时触发（回调属性不加 @Prop） */
  onClose: () => void = () => {}

  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''

  private appearance: LhTagAppearance = LhTagTokens.resolve(
    LhTagType.Default,
    LhTagSize.Medium,
    false,
    false,
    LightLhColors(),
  )

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    let colors = LightLhColors()
    if (this.colorsJson !== '') {
      colors = JSON.parse(this.colorsJson) as LhColors
    }
    this.appearance = LhTagTokens.resolve(this.type, this.size, this.plain, this.round, colors)
  }

  build() {
    Row() {
      Text(this.text)
        .fontSize(lhVp(this.appearance.fontSize))
        .fontColor(this.appearance.contentColor)
        .maxLines(1)
        .textOverflow(TextOverflow.Ellipsis)

      if (this.closable) {
        // 关闭符：两条对角线，端侧落点为 ✕ 字形；点击其区域触发 onClose
        Text(LhIconTokens.glyphFor('close'))
          .fontSize(lhVp(this.appearance.fontSize))
          .fontColor(this.appearance.contentColor)
          .margin({ left: lhVp(this.appearance.closeGap) })
          .onClick(() => {
            this.onClose()
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
