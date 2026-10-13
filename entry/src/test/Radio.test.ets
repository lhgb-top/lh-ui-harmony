import { LhRadioSize, LhRadioTokens, LightLhColors, DarkLhColors, LhTokens, LhDarkTokens } from 'top.lhgb.ui.harmony'
import { describe, it, expect } from '@ohos/hypium'

/**
 * 黄金用例翻译：`lh-ui-core/cases/radio.json` 的 6 条断言。
 */
export default function radioTest(): void {
  describe('radio', () => {
    const light = LightLhColors()
    const dark = DarkLhColors()

    // case: tap-unchecked-emits-onchange —— 仅未选中时可点击
    it('unchecked_is_interactive', 0, () => {
      const a = LhRadioTokens.resolve(false, false, LhRadioSize.Medium, light)
      expect(a.enabled).assertTrue()
    })

    // case: tap-checked-keeps-checked —— 已选中时点击不触发（gate 在组件 onClick）
    it('checked_still_interactive_but_component_gates', 0, () => {
      const a = LhRadioTokens.resolve(true, false, LhRadioSize.Medium, light)
      expect(a.enabled).assertTrue()
      expect(a.showDot).assertTrue()
    })

    // case: disabled-blocks-change
    it('disabled_is_not_interactive', 0, () => {
      const a = LhRadioTokens.resolve(false, true, LhRadioSize.Medium, light)
      expect(a.enabled).assertFalse()
      expect(a.ringColor).assertEqual(LhTokens.Color.Disabled.border)
      expect(a.dotColor).assertEqual(LhTokens.Color.Disabled.text)
      expect(a.labelColor).assertEqual(LhTokens.Color.Text.disabled)
      expect(a.showDot).assertFalse()
    })

    // case: checked-uses-primary-tokens
    it('checked_uses_primary_tokens', 0, () => {
      const a = LhRadioTokens.resolve(true, false, LhRadioSize.Medium, light)
      expect(a.ringColor).assertEqual(LhTokens.Color.Primary.default)
      expect(a.dotColor).assertEqual(LhTokens.Color.Primary.default)
    })

    // case: unchecked-uses-border-token
    it('unchecked_uses_border_token', 0, () => {
      const a = LhRadioTokens.resolve(false, false, LhRadioSize.Medium, light)
      expect(a.ringColor).assertEqual(LhTokens.Color.Border.base)
      expect(a.showDot).assertFalse()
    })

    // case: small-size-uses-small-token
    it('small_size_uses_small_token', 0, () => {
      const a = LhRadioTokens.resolve(false, false, LhRadioSize.Small, light)
      expect(a.size).assertEqual(LhTokens.Radio.Size.small)
      expect(LhTokens.Radio.Size.small === LhTokens.Radio.Size.large).assertFalse()
    })

    // 圆点直径 = 尺寸 × dotScale
    it('dot_size_scales_with_size_token', 0, () => {
      const a = LhRadioTokens.resolve(true, false, LhRadioSize.Medium, light)
      expect(a.dotSize).assertEqual(LhTokens.Radio.Size.medium * LhTokens.Radio.dotScale)
    })

    // 暗色专项
    it('dark_colors_come_from_dark_tokens', 0, () => {
      const a = LhRadioTokens.resolve(true, false, LhRadioSize.Medium, dark)
      expect(a.ringColor).assertEqual(LhDarkTokens.Color.Primary.default)
      expect(a.dotColor).assertEqual(LhDarkTokens.Color.Primary.default)
    })

    it('dimensions_are_identical_in_dark_mode', 0, () => {
      const la = LhRadioTokens.resolve(false, false, LhRadioSize.Large, light)
      const da = LhRadioTokens.resolve(false, false, LhRadioSize.Large, dark)
      expect(la.size).assertEqual(da.size)
      expect(la.dotSize).assertEqual(da.dotSize)
    })
  })
}

