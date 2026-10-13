import { LhCellTokens, LightLhColors, DarkLhColors, LhTokens, LhDarkTokens } from 'top.lhgb.ui.harmony'
import { describe, it, expect } from '@ohos/hypium'

/**
 * 黄金用例翻译：`lh-ui-core/cases/cell.json` 的 6 条断言。
 */
export default function cellTest(): void {
  describe('cell', () => {
    const light = LightLhColors()
    const dark = DarkLhColors()

    // case: title-and-value-render —— 标题与值都取标题/值字号令牌
    it('title_and_value_use_font_tokens', 0, () => {
      const a = LhCellTokens.resolve(true, false, light)
      expect(a.fontSizeTitle).assertEqual(LhTokens.Cell.fontSizeTitle)
      expect(a.fontSizeValue).assertEqual(LhTokens.Cell.fontSizeValue)
    })

    // case: label-renders-secondary-tone
    it('label_uses_secondary_tone', 0, () => {
      const a = LhCellTokens.resolve(true, false, light)
      expect(a.labelColor).assertEqual(LhTokens.Color.Text.secondary)
    })

    // case: required-uses-danger-token
    it('required_uses_danger_token', 0, () => {
      const a = LhCellTokens.resolve(true, false, light)
      expect(a.requiredColor).assertEqual(LhTokens.Color.Danger.default)
    })

    // case: bordered-emits-line-command
    it('bordered_uses_border_lighter_token', 0, () => {
      const bordered = LhCellTokens.resolve(true, false, light)
      expect(bordered.dividerColor).assertEqual(LhTokens.Color.Border.lighter)
      const unbordered = LhCellTokens.resolve(false, false, light)
      expect(unbordered.dividerColor).assertUndefined()
    })

    // case: clickable-emits-onclick / not-clickable-no-onclick —— 外观携带可点击态
    it('clickable_state_is_resolved', 0, () => {
      const clickable = LhCellTokens.resolve(true, true, light)
      expect(clickable.arrowColor).assertEqual(LhTokens.Color.Text.secondary)
      const plain = LhCellTokens.resolve(true, false, light)
      expect(plain.arrowColor).assertEqual(LhTokens.Color.Text.secondary)
    })

    // icon 非空时左侧图标尺寸取 icon.size.medium
    it('icon_size_uses_icon_token', 0, () => {
      const a = LhCellTokens.resolve(true, false, light)
      expect(a.iconSize).assertEqual(LhTokens.Icon.Size.medium)
    })

    // 暗色专项
    it('dark_colors_come_from_dark_tokens', 0, () => {
      const a = LhCellTokens.resolve(true, false, dark)
      expect(a.titleColor).assertEqual(LhDarkTokens.Color.Text.primary)
      expect(a.dividerColor).assertEqual(LhDarkTokens.Color.Border.lighter)
    })

    it('dimensions_are_identical_in_dark_mode', 0, () => {
      const la = LhCellTokens.resolve(true, false, light)
      const da = LhCellTokens.resolve(true, false, dark)
      expect(la.paddingHorizontal).assertEqual(da.paddingHorizontal)
      expect(la.fontSizeTitle).assertEqual(da.fontSizeTitle)
    })
  })
}

