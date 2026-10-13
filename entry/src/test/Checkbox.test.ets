import { LhCheckboxSize, LhCheckboxMark, LhCheckboxTokens, LightLhColors, DarkLhColors, LhTokens, LhDarkTokens } from 'top.lhgb.ui.harmony'
import { describe, it, expect } from '@ohos/hypium'

/**
 * 黄金用例翻译：`lh-ui-core/cases/checkbox.json` 的 6 条断言。
 */
export default function checkboxTest(): void {
  describe('checkbox', () => {
    const light = LightLhColors()
    const dark = DarkLhColors()

    // case: tap-toggles-and-emits-onchange
    it('tap_toggles_checked', 0, () => {
      expect(LhCheckboxTokens.nextChecked(false, false)).assertTrue()
    })

    // case: tap-checked-unchecks
    it('tap_checked_unchecks', 0, () => {
      expect(LhCheckboxTokens.nextChecked(true, false)).assertFalse()
    })

    // case: indeterminate-becomes-checked
    it('indeterminate_becomes_checked', 0, () => {
      expect(LhCheckboxTokens.nextChecked(false, true)).assertTrue()
    })

    // case: disabled-blocks-change
    it('disabled_is_not_interactive', 0, () => {
      const a = LhCheckboxTokens.resolve(false, false, true, LhCheckboxSize.Medium, light)
      expect(a.enabled).assertFalse()
      expect(a.containerColor).assertEqual(LhTokens.Color.Disabled.bg)
      expect(a.borderColor).assertEqual(LhTokens.Color.Disabled.border)
      expect(a.markColor).assertEqual(LhTokens.Color.Disabled.text)
    })

    // case: checked-uses-primary-tokens
    it('checked_uses_primary_tokens', 0, () => {
      const a = LhCheckboxTokens.resolve(true, false, false, LhCheckboxSize.Medium, light)
      expect(a.containerColor).assertEqual(LhTokens.Color.Primary.default)
      expect(a.markColor).assertEqual(LhTokens.Color.onPrimary)
      expect(a.mark).assertEqual(LhCheckboxMark.Check)
    })

    // case: unchecked-uses-border-token
    it('unchecked_uses_border_token', 0, () => {
      const a = LhCheckboxTokens.resolve(false, false, false, LhCheckboxSize.Medium, light)
      expect(a.borderColor).assertEqual(LhTokens.Color.Border.base)
      expect(a.mark).assertEqual(LhCheckboxMark.None)
    })

    // 不确定态画横杠
    it('indeterminate_uses_dash_mark', 0, () => {
      const a = LhCheckboxTokens.resolve(false, true, false, LhCheckboxSize.Medium, light)
      expect(a.mark).assertEqual(LhCheckboxMark.Dash)
      expect(a.containerColor).assertEqual(LhTokens.Color.Primary.default)
    })

    // size 映射
    it('small_size_uses_small_token', 0, () => {
      const a = LhCheckboxTokens.resolve(false, false, false, LhCheckboxSize.Small, light)
      expect(a.size).assertEqual(LhTokens.Checkbox.Size.small)
      expect(LhTokens.Checkbox.Size.small === LhTokens.Checkbox.Size.large).assertFalse()
    })

    // 暗色专项
    it('dark_colors_come_from_dark_tokens', 0, () => {
      const a = LhCheckboxTokens.resolve(true, false, false, LhCheckboxSize.Medium, dark)
      expect(a.containerColor).assertEqual(LhDarkTokens.Color.Primary.default)
      expect(a.markColor).assertEqual(LhDarkTokens.Color.onPrimary)
    })

    it('dimensions_are_identical_in_dark_mode', 0, () => {
      const la = LhCheckboxTokens.resolve(false, false, false, LhCheckboxSize.Large, light)
      const da = LhCheckboxTokens.resolve(false, false, false, LhCheckboxSize.Large, dark)
      expect(la.size).assertEqual(da.size)
      expect(la.borderRadius).assertEqual(da.borderRadius)
    })
  })
}

