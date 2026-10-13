import { LhInputType, LhInputSize, LhInputTokens, LightLhColors, DarkLhColors, LhTokens, LhDarkTokens } from 'top.lhgb.ui.harmony'
import { describe, it, expect } from '@ohos/hypium'

/**
 * 黄金用例翻译：`lh-ui-core/cases/input.json` 的 8 条断言。
 *
 * 交互 gate（输入/清除/聚焦）走 resolve 的状态参数与 truncate 纯函数断言，
 * 与 Button.test.ets 的 appearance.enabled 模式同构。
 */
export default function inputTest(): void {
  describe('input', () => {
    const light = LightLhColors()
    const dark = DarkLhColors()

    // case: disabled-blocks-input
    it('disabled_is_not_interactive', 0, () => {
      const a = LhInputTokens.resolve(LhInputSize.Medium, true, false, light)
      expect(a.enabled).assertFalse()
      expect(a.containerColor).assertEqual(LhTokens.Color.Disabled.bg)
      expect(a.textColor).assertEqual(LhTokens.Color.Disabled.text)
    })

    // case: readonly-blocks-input（只读可聚焦但不接受输入，外观不呈现禁用样式）
    it('readonly_still_enabled_in_appearance', 0, () => {
      const a = LhInputTokens.resolve(LhInputSize.Medium, false, false, light)
      expect(a.enabled).assertTrue()
    })

    // case: placeholder-uses-placeholder-token
    it('placeholder_uses_placeholder_token', 0, () => {
      const a = LhInputTokens.resolve(LhInputSize.Medium, false, false, light)
      expect(a.placeholderColor).assertEqual(LhTokens.Color.Text.placeholder)
    })

    // case: focus-uses-focus-token
    it('focus_uses_focus_token', 0, () => {
      const blurred = LhInputTokens.resolve(LhInputSize.Medium, false, false, light)
      expect(blurred.borderColor).assertEqual(LhTokens.Color.Border.base)
      expect(blurred.borderWidth).assertEqual(LhTokens.Input.borderWidth)
      const focused = LhInputTokens.resolve(LhInputSize.Medium, false, true, light)
      expect(focused.borderColor).assertEqual(LhTokens.Color.focus)
      expect(focused.borderWidth).assertEqual(LhTokens.Input.focusRingWidth)
    })

    // case: small-size-uses-small-tokens
    it('small_size_uses_small_tokens', 0, () => {
      const a = LhInputTokens.resolve(LhInputSize.Small, false, false, light)
      expect(a.height).assertEqual(LhTokens.Input.Height.small)
      expect(LhTokens.Input.Height.small === LhTokens.Input.Height.large).assertFalse()
    })

    // case: maxlength-truncates-input
    it('maxlength_truncates_input', 0, () => {
      expect(LhInputTokens.truncate('青花瓷瓶', 3)).assertEqual('青花瓷')
      expect(LhInputTokens.truncate('青花瓷', 3)).assertEqual('青花瓷')
      expect(LhInputTokens.truncate('青花瓷', undefined)).assertEqual('青花瓷')
    })

    // case: clearable-emits-empty-value —— 清除按钮尺寸取 clearIconSize 令牌
    it('clear_icon_uses_token', 0, () => {
      const a = LhInputTokens.resolve(LhInputSize.Medium, false, false, light)
      expect(a.clearIconSize).assertEqual(LhTokens.Input.clearIconSize)
    })

    // 密码类型不影响外观，仅影响掩码渲染（InputType.Password）
    it('password_type_resolves_neutral_appearance', 0, () => {
      const a = LhInputTokens.resolve(LhInputSize.Medium, false, false, light)
      expect(a.containerColor).assertEqual(LhTokens.Color.Background.default)
      expect(a.textColor).assertEqual(LhTokens.Color.Text.primary)
    })

    // 暗色专项
    it('dark_colors_come_from_dark_tokens', 0, () => {
      const a = LhInputTokens.resolve(LhInputSize.Medium, false, true, dark)
      expect(a.borderColor).assertEqual(LhDarkTokens.Color.focus)
      expect(a.placeholderColor).assertEqual(LhDarkTokens.Color.Text.placeholder)
    })

    it('dimensions_are_identical_in_dark_mode', 0, () => {
      const la = LhInputTokens.resolve(LhInputSize.Large, false, false, light)
      const da = LhInputTokens.resolve(LhInputSize.Large, false, false, dark)
      expect(la.height).assertEqual(da.height)
      expect(la.paddingHorizontal).assertEqual(da.paddingHorizontal)
    })
  })
}

