import { LhIconSize, LhIconTone, LhIconTokens, LightLhColors, DarkLhColors, LhTokens, LhDarkTokens } from 'top.lhgb.ui.harmony'
import { describe, it, expect } from '@ohos/hypium'

/**
 * 黄金用例翻译：`lh-ui-core/cases/icon.json` 的 5 条断言。
 *
 * cases.then.tokens（「某令牌是否被应用」）在此断言为「解析后的外观值 == 生成令牌的值」——
 * 只要 LhIconTokens.resolve 的返回取自令牌对象，映射即成立（与 Button.test.ets 同构）。
 */
export default function iconTest(): void {
  describe('icon', () => {
    const light = LightLhColors()
    const dark = DarkLhColors()

    // case: small-size-uses-small-token
    it('small_size_uses_small_token', 0, () => {
      const a = LhIconTokens.resolve(LhIconSize.Small, LhIconTone.Default, 'star', light)
      expect(a.size).assertEqual(LhTokens.Icon.Size.small)
      expect(LhTokens.Icon.Size.small === LhTokens.Icon.Size.large).assertFalse()
    })

    // case: default-tone-uses-text-primary
    it('default_tone_uses_text_primary', 0, () => {
      const a = LhIconTokens.resolve(LhIconSize.Medium, LhIconTone.Default, 'star', light)
      expect(a.color).assertEqual(LhTokens.Color.Text.primary)
    })

    // case: primary-tone-uses-primary-token
    it('primary_tone_uses_primary_token', 0, () => {
      const a = LhIconTokens.resolve(LhIconSize.Medium, LhIconTone.Primary, 'star', light)
      expect(a.color).assertEqual(LhTokens.Color.Primary.default)
    })

    // case: regular/secondary 取对应文字色
    it('regular_tone_uses_regular_token', 0, () => {
      const a = LhIconTokens.resolve(LhIconSize.Medium, LhIconTone.Regular, 'star', light)
      expect(a.color).assertEqual(LhTokens.Color.Text.regular)
    })

    it('secondary_tone_uses_secondary_token', 0, () => {
      const a = LhIconTokens.resolve(LhIconSize.Medium, LhIconTone.Secondary, 'star', light)
      expect(a.color).assertEqual(LhTokens.Color.Text.secondary)
    })

    // case: render-emits-icon-command —— 字形映射落地
    it('glyph_maps_registered_name', 0, () => {
      expect(LhIconTokens.glyphFor('search')).assertEqual('⌕')
      expect(LhIconTokens.glyphFor('check')).assertEqual('✓')
      expect(LhIconTokens.glyphFor('close')).assertEqual('✕')
    })

    it('glyph_falls_back_for_unknown_name', 0, () => {
      expect(LhIconTokens.glyphFor('not-a-registered-icon')).assertEqual('◆')
    })

    // 暗色专项：色板取自 LhDarkTokens（并列对象模型）
    it('dark_colors_come_from_dark_tokens', 0, () => {
      const a = LhIconTokens.resolve(LhIconSize.Medium, LhIconTone.Primary, 'star', dark)
      expect(a.color).assertEqual(LhDarkTokens.Color.Primary.default)
    })

    // 尺寸令牌暗色不覆盖
    it('dimensions_are_identical_in_dark_mode', 0, () => {
      const la = LhIconTokens.resolve(LhIconSize.Large, LhIconTone.Default, 'star', light)
      const da = LhIconTokens.resolve(LhIconSize.Large, LhIconTone.Default, 'star', dark)
      expect(la.size).assertEqual(da.size)
    })
  })
}

