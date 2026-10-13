import { LhNavbarTokens, LightLhColors, DarkLhColors, LhTokens, LhDarkTokens } from 'top.lhgb.ui.harmony'
import { describe, it, expect } from '@ohos/hypium'

/**
 * 黄金用例翻译：`lh-ui-core/cases/navbar.json` 的 6 条断言。
 *
 * 左右点击 gate（无内容时不响应）在组件 build() 的条件渲染，
 * 此处断言 resolve 的外观契约。
 */
export default function navbarTest(): void {
  describe('navbar', () => {
    const light = LightLhColors()
    const dark = DarkLhColors()

    // case: height-uses-navbar-height-token
    it('height_uses_navbar_height_token', 0, () => {
      const a = LhNavbarTokens.resolve(true, light)
      expect(a.height).assertEqual(LhTokens.Navbar.height)
    })

    it('dimensions_use_tokens', 0, () => {
      const a = LhNavbarTokens.resolve(true, light)
      expect(a.paddingHorizontal).assertEqual(LhTokens.Navbar.paddingHorizontal)
      expect(a.titleFontSize).assertEqual(LhTokens.Navbar.titleFontSize)
      expect(a.iconSize).assertEqual(LhTokens.Navbar.iconSize)
    })

    // case: title-renders-text —— 标题色取主要文字色
    it('title_color_uses_text_primary_token', 0, () => {
      const a = LhNavbarTokens.resolve(true, light)
      expect(a.titleColor).assertEqual(LhTokens.Color.Text.primary)
      expect(a.containerColor).assertEqual(LhTokens.Color.Background.default)
    })

    // case: bordered-uses-border-token
    it('bordered_uses_border_token', 0, () => {
      const bordered = LhNavbarTokens.resolve(true, light)
      expect(bordered.dividerColor).assertEqual(LhTokens.Color.Border.lighter)
      expect(bordered.borderWidth).assertEqual(LhTokens.Navbar.borderWidth)
      const unbordered = LhNavbarTokens.resolve(false, light)
      expect(unbordered.dividerColor).assertUndefined()
      expect(unbordered.borderWidth).assertEqual(0)
    })

    // 层级取 zIndex.sticky
    it('zindex_uses_sticky_token', 0, () => {
      const a = LhNavbarTokens.resolve(true, light)
      expect(a.zIndex).assertEqual(LhTokens.ZIndex.sticky)
    })

    // 暗色专项
    it('dark_colors_come_from_dark_tokens', 0, () => {
      const a = LhNavbarTokens.resolve(true, dark)
      expect(a.containerColor).assertEqual(LhDarkTokens.Color.Background.default)
      expect(a.titleColor).assertEqual(LhDarkTokens.Color.Text.primary)
      expect(a.dividerColor).assertEqual(LhDarkTokens.Color.Border.lighter)
    })

    it('dimensions_are_identical_in_dark_mode', 0, () => {
      const la = LhNavbarTokens.resolve(true, light)
      const da = LhNavbarTokens.resolve(true, dark)
      expect(la.height).assertEqual(da.height)
      expect(la.titleFontSize).assertEqual(da.titleFontSize)
    })
  })
}

