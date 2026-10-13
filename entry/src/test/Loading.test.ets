import { LhLoadingSize, LhLoadingTone, LhLoadingTokens, LightLhColors, DarkLhColors, LhTokens, LhDarkTokens } from 'top.lhgb.ui.harmony'
import { describe, it, expect } from '@ohos/hypium'

/**
 * 黄金用例翻译：`lh-ui-core/cases/loading.json` 的 5 条断言。
 */
export default function loadingTest(): void {
  describe('loading', () => {
    const light = LightLhColors()
    const dark = DarkLhColors()

    // case: medium-size-uses-medium-token（默认尺寸）
    it('medium_size_uses_medium_token', 0, () => {
      const a = LhLoadingTokens.resolve(LhLoadingSize.Medium, LhLoadingTone.Primary, light)
      expect(a.size).assertEqual(LhTokens.Loading.Size.medium)
      expect(LhTokens.Loading.Size.medium === LhTokens.Loading.Size.small).assertFalse()
    })

    // case: large-size-uses-large-token
    it('large_size_uses_large_token', 0, () => {
      const a = LhLoadingTokens.resolve(LhLoadingSize.Large, LhLoadingTone.Primary, light)
      expect(a.size).assertEqual(LhTokens.Loading.Size.large)
      expect(LhTokens.Loading.Size.large === LhTokens.Loading.Size.medium).assertFalse()
    })

    // case: primary-tone-uses-primary-token
    it('primary_tone_uses_primary_token', 0, () => {
      const a = LhLoadingTokens.resolve(LhLoadingSize.Medium, LhLoadingTone.Primary, light)
      expect(a.color).assertEqual(LhTokens.Color.Primary.default)
    })

    // case: success-tone-uses-success-token
    it('success_tone_uses_success_token', 0, () => {
      const a = LhLoadingTokens.resolve(LhLoadingSize.Medium, LhLoadingTone.Success, light)
      expect(a.color).assertEqual(LhTokens.Color.Success.default)
    })

    // case: render-emits-ring-command —— 描边宽取 strokeWidth 令牌
    it('stroke_width_uses_token', 0, () => {
      const a = LhLoadingTokens.resolve(LhLoadingSize.Medium, LhLoadingTone.Primary, light)
      expect(a.strokeWidth).assertEqual(LhTokens.Loading.strokeWidth)
    })

    // 暗色专项
    it('dark_colors_come_from_dark_tokens', 0, () => {
      const a = LhLoadingTokens.resolve(LhLoadingSize.Medium, LhLoadingTone.Primary, dark)
      expect(a.color).assertEqual(LhDarkTokens.Color.Primary.default)
    })

    it('dimensions_are_identical_in_dark_mode', 0, () => {
      const la = LhLoadingTokens.resolve(LhLoadingSize.Large, LhLoadingTone.Primary, light)
      const da = LhLoadingTokens.resolve(LhLoadingSize.Large, LhLoadingTone.Primary, dark)
      expect(la.size).assertEqual(da.size)
      expect(la.strokeWidth).assertEqual(da.strokeWidth)
    })
  })
}

