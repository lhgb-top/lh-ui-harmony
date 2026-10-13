import { LhTextLevel, LhTextWeight, LhTextTone, LhTextAlign, LhTextTokens, LhTextAppearance } from './LhTextTokens'
import { LH_COLORS_KEY, LightLhColors, LhColors } from '../../common/theme/LhTheme'
import { lhVp } from '../../common/LhVp'

/**
 * 文本组件：消费全局排版令牌的展示型原语（ArkUI 手写）。
 *
 * props 与 `lh-ui-core/specs/text.json` 逐字对齐；行为遵循 `cases/text.json`
 * 的 5 条黄金用例（已翻译为 hypium 测试，见 entry/src/test/Text.test.ets）。
 *
 * spec 的「绘制指令为 draw_text」端侧落点就是 ArkUI 的单个 Text 节点——
 * 每个外观属性绑定一个令牌，不引入额外容器（对齐在行盒宽度内生效）。
 */
@Component
export struct LhText {
  /** 文本内容（spec 的 default 插槽；渲染数据，@Prop 不需 @Watch） */
  @Prop content: string = ''
  /** 字号级别，映射到 typography.fontSize.<level> 令牌 */
  @Prop @Watch('recompute') level: LhTextLevel = LhTextLevel.Base
  /** 字重，映射到 typography.fontWeight.<weight> 令牌 */
  @Prop @Watch('recompute') weight: LhTextWeight = LhTextWeight.Primary
  /** 文字色调，映射到 color.text.<tone> 或 color.selected 令牌 */
  @Prop @Watch('recompute') tone: LhTextTone = LhTextTone.Primary
  /** 水平对齐方式（在行盒宽度内生效；由容器决定宽度，组件不强行铺满） */
  @Prop align: LhTextAlign = LhTextAlign.Start

  /** AppStorage 主题订阅：色板 JSON 变化时 @Watch 触发重算（主题热重绘） */
  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''

  private appearance: LhTextAppearance = LhTextTokens.resolve(
    LhTextLevel.Base,
    LhTextWeight.Primary,
    LhTextTone.Primary,
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
    this.appearance = LhTextTokens.resolve(this.level, this.weight, this.tone, colors)
  }

  build() {
    Text(this.content)
      .fontSize(lhVp(this.appearance.fontSize))
      .fontWeight(this.appearance.fontWeight)
      .fontColor(this.appearance.fontColor)
      // spec：行高取 typography.lineHeight.primary，layout 高度 = 字号 × 行高
      .lineHeight(lhVp(this.appearance.fontSize * this.appearance.lineHeight))
      .textAlign(LhTextTokens.alignFor(this.align))
  }
}
