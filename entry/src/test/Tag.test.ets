import { LhTagType, LhTagSize, LhTagTokens, LightLhColors, DarkLhColors, LhTokens, LhDarkTokens } from 'top.lhgb.ui.harmony'
import { describe, it, expect } from '@ohos/hypium'

/**
 * 黄金用例翻译：`lh-ui-core/cases/tag.json` 的 6 条断言。
 */
export default function tagTest(): void {
  describe('tag', () => {
    const light = LightLhColors()
    const dark = DarkLhColors()

    // case: default-type-renders-text —— 默认类型取中性令牌
    it('default_type_uses_neutral_tokens', 0, () => {
      const a = LhTagTokens.resolve(LhTagType.Default, LhTagSize.Medium, false, false, light)
      expect(a.containerColor).assertEqual(LhTokens.Color.Background.default)
      expect(a.contentColor).assertEqual(LhTokens.Color.Text.primary)
      expect(a.borderColor).assertEqual(LhTokens.Color.Border.base)
    })

    // case: primary-type-uses-primary-tokens
    it('primary_type_uses_primary_tokens', 0, () => {
      const a = LhTagTokens.resolve(LhTagType.Primary, LhTagSize.Medium, false, false, light)
      expect(a.containerColor).assertEqual(LhTokens.Color.Primary.default)
      expect(a.contentColor).assertEqual(LhTokens.Color.onPrimary)
    })

    // case: plain-uses-bg-tokens —— 浅底形态消费语义浅底令牌
    it('plain_uses_bg_tokens', 0, () => {
      const a = LhTagTokens.resolve(LhTagType.Success, LhTagSize.Medium, true, false, light)
      expect(a.containerColor).assertEqual(LhTokens.Color.Success.bg)
      expect(a.contentColor).assertEqual(LhTokens.Color.Success.default)
    })

    // case: small-size-uses-small-tokens
    it('small_size_uses_small_tokens', 0, () => {
      const a = LhTagTokens.resolve(LhTagType.Default, LhTagSize.Small, false, false, light)
      expect(a.height).assertEqual(LhTokens.Tag.Height.small)
      expect(LhTokens.Tag.Height.small === LhTokens.Tag.Height.large).assertFalse()
    })

    // case: round-makes-radius-half-height —— 胶囊态圆角为高度一半
    it('round_makes_radius_half_height', 0, () => {
      const round = LhTagTokens.resolve(LhTagType.Default, LhTagSize.Medium, false, true, light)
      expect(round.borderRadius).assertEqual(round.height / 2)
      const square = LhTagTokens.resolve(LhTagType.Default, LhTagSize.Medium, false, false, light)
      expect(square.borderRadius).assertEqual(LhTokens.Tag.borderRadius)
    })

    // case: closable-tap-emits-onclose —— 关闭符间距取 spacing.xs
    it('closable_close_gap_uses_spacing_xs', 0, () => {
      const a = LhTagTokens.resolve(LhTagType.Default, LhTagSize.Medium, false, false, light)
      expect(a.closeGap).assertEqual(LhTokens.Spacing.xs)
    })

    // 暗色专项：色板取自 LhDarkTokens（并列对象模型）
    it('dark_colors_come_from_dark_tokens', 0, () => {
      const a = LhTagTokens.resolve(LhTagType.Primary, LhTagSize.Medium, false, false, dark)
      expect(a.containerColor).assertEqual(LhDarkTokens.Color.Primary.default)
      expect(a.contentColor).assertEqual(LhDarkTokens.Color.onPrimary)
    })

    // 尺寸令牌暗色不覆盖
    it('dimensions_are_identical_in_dark_mode', 0, () => {
      const la = LhTagTokens.resolve(LhTagType.Default, LhTagSize.Large, false, false, light)
      const da = LhTagTokens.resolve(LhTagType.Default, LhTagSize.Large, false, false, dark)
      expect(la.height).assertEqual(da.height)
      expect(la.borderRadius).assertEqual(da.borderRadius)
    })
  })
}

