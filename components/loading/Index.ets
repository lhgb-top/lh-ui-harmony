import { LhLoadingSize, LhLoadingTone, LhLoadingTokens, LhLoadingAppearance } from './LhLoadingTokens'
import { LH_COLORS_KEY, LightLhColors, LhColors } from '../../common/theme/LhTheme'
import { lhVp } from '../../common/LhVp'

/**
 * 加载指示器组件：环形旋转动画（ArkUI 手写）。
 *
 * props 与 `lh-ui-core/specs/loading.json` 逐字对齐；行为遵循 `cases/loading.json`
 * 的 5 条黄金用例（已翻译为 hypium 测试，见 entry/src/test/Loading.test.ets）。
 *
 * 旋转动画由 ArkUI 的 LoadingProgress 内置驱动（spec 的「旋转交由后端驱动」在
 * 本端由平台动画承担）。
 */
@Component
export struct LhLoading {
  /** 指示器直径，映射到 loading.size.* 令牌 */
  @Prop @Watch('recompute') size: LhLoadingSize = LhLoadingSize.Medium
  /** 环色，取对应语义色令牌 */
  @Prop @Watch('recompute') tone: LhLoadingTone = LhLoadingTone.Primary

  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''

  private appearance: LhLoadingAppearance = LhLoadingTokens.resolve(
    LhLoadingSize.Medium, LhLoadingTone.Primary, LightLhColors(),
  )

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    let colors = LightLhColors()
    if (this.colorsJson !== '') {
      colors = JSON.parse(this.colorsJson) as LhColors
    }
    this.appearance = LhLoadingTokens.resolve(this.size, this.tone, colors)
  }

  build() {
    LoadingProgress()
      .width(lhVp(this.appearance.size))
      .height(lhVp(this.appearance.size))
      .color(this.appearance.color)
  }
}
