import { LhTextareaTokens, LightLhColors, DarkLhColors, LhTokens, LhDarkTokens } from 'top.lhgb.ui.harmony'
import { describe, it, expect } from '@ohos/hypium'

/**
 * 黄金用例翻译：`lh-ui-core/cases/textarea.json` 的 6 条断言。
 */
export default function textareaTest(): void {
  describe('textarea', () => {
    const light = LightLhColors()
    const dark = DarkLhColors()

    // case: disabled-blocks-input
    it('disabled_is_not_interactive', 0, () => {
      const a = LhTextareaTokens.resolve(3, true, false, light)
      expect(a.enabled).assertFalse()
      expect(a.containerColor).assertEqual(LhTokens.Color.Disabled.bg)
      expect(a.textColor).assertEqual(LhTokens.Color.Disabled.text)
    })

    // case: focus-uses-focus-token
    it('focus_uses_focus_token', 0, () => {
      const blurred = LhTextareaTokens.resolve(3, false, false, light)
      expect(blurred.borderColor).assertEqual(LhTokens.Color.Border.base)
      const focused = LhTextareaTokens.resolve(3, false, true, light)
      expect(focused.borderColor).assertEqual(LhTokens.Color.focus)
      expect(focused.borderWidth).assertEqual(LhTokens.Textarea.focusRingWidth)
    })

    // case: showcount-renders-count —— 「当前/最大」
    it('showcount_renders_count_with_maxlength', 0, () => {
      expect(LhTextareaTokens.countText('青花', 10)).assertEqual('2/10')
    })

    // case: showcount-without-maxlength-renders-length-only
    it('showcount_renders_length_only_without_maxlength', 0, () => {
      expect(LhTextareaTokens.countText('青花瓷', undefined)).assertEqual('3')
    })

    // case: maxlength-truncates-input
    it('maxlength_truncates_input', 0, () => {
      expect(LhTextareaTokens.truncate('青花瓷瓶', 3)).assertEqual('青花瓷')
      expect(LhTextareaTokens.truncate('青花瓷', undefined)).assertEqual('青花瓷')
    })

    // 高度由 rows 决定初始可见行数，最小高度取 minHeight 令牌
    it('height_for_rows_respects_min_height', 0, () => {
      const a = LhTextareaTokens.resolve(3, false, false, light)
      const h = LhTextareaTokens.heightForRows(3, a)
      expect(h >= LhTokens.Textarea.minHeight).assertTrue()
    })

    it('count_font_size_uses_token', 0, () => {
      const a = LhTextareaTokens.resolve(3, false, false, light)
      expect(a.countFontSize).assertEqual(LhTokens.Textarea.countFontSize)
      expect(a.countColor).assertEqual(LhTokens.Color.Text.secondary)
    })

    // 暗色专项
    it('dark_colors_come_from_dark_tokens', 0, () => {
      const a = LhTextareaTokens.resolve(3, false, true, dark)
      expect(a.borderColor).assertEqual(LhDarkTokens.Color.focus)
      expect(a.containerColor).assertEqual(LhDarkTokens.Color.Background.default)
    })

    it('dimensions_are_identical_in_dark_mode', 0, () => {
      const la = LhTextareaTokens.resolve(3, false, false, light)
      const da = LhTextareaTokens.resolve(3, false, false, dark)
      expect(la.fontSize).assertEqual(da.fontSize)
      expect(la.minHeight).assertEqual(da.minHeight)
    })
  })
}

