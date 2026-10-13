import { LhIconSize, LhIconTone, LhIconTokens, LhIconAppearance } from './LhIconTokens'
import { LH_COLORS_KEY, LightLhColors, LhColors } from '../../common/theme/LhTheme'
import { lhVp } from '../../common/LhVp'

/**
 * 图标组件：按名称渲染矢量符号（ArkUI 手写）。
 *
 * props 与 `lh-ui-core/specs/icon.json` 逐字对齐；行为遵循 `cases/icon.json`
 * 的 5 条黄金用例（已翻译为 hypium 测试，见 entry/src/test/Icon.test.ets）。
 *
 * 端侧落点：glyph 是 unicode 字形、Text 渲染（见 LhIconTokens.glyphFor 的注释）。
 */
@Component
export struct LhIcon {
  /** 图标名（必填，本地字形映射） */
  @Prop @Watch('recompute') name: string = ''
  /** 图标尺寸，映射到 icon.size.* 令牌 */
  @Prop @Watch('recompute') size: LhIconSize = LhIconSize.Medium
  /** 语义色调；default 为主要文字色，其余取对应语义色 */
  @Prop @Watch('recompute') tone: LhIconTone = LhIconTone.Default

  /** 点击回调（回调属性不加 @Prop：ArkTS 装饰器不支持函数类型） */
  onClick: () => void = () => {}

  /** AppStorage 主题订阅：色板 JSON 变化时 @Watch 触发重算（主题热重绘） */
  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''

  private appearance: LhIconAppearance = LhIconTokens.resolve(
    LhIconSize.Medium,
    LhIconTone.Default,
    '',
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
    this.appearance = LhIconTokens.resolve(this.size, this.tone, this.name, colors)
  }

  build() {
    Text(this.appearance.glyph)
      .fontSize(lhVp(this.appearance.size))
      .fontColor(this.appearance.color)
      .onClick(() => {
        this.onClick()
      })
  }
}
