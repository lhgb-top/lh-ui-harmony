import { LhSwitchSize, LhSwitchTokens, LightLhColors, DarkLhColors, LhTokens, LhDarkTokens } from 'top.lhgb.ui.harmony'
import { describe, it, expect } from '@ohos/hypium'

/**
 * 黄金用例翻译：`lh-ui-core/cases/switch.json` 的 6 条断言。
 */
export default function switchTest(): void {
  describe('switch', () => {
    const light = LightLhColors()
    const dark = DarkLhColors()

    // case: tap-toggles-and-emits-onchange（翻转由组件 onClick 承载）
    it('enabled_is_interactive', 0, () => {
      const a = LhSwitchTokens.resolve(false, false, false, LhSwitchSize.Medium, light)
      expect(a.enabled).assertTrue()
    })

    // case: disabled-blocks-change
    it('disabled_is_not_interactive', 0, () => {
      const a = LhSwitchTokens.resolve(false, true, false, LhSwitchSize.Medium, light)
      expect(a.enabled).assertFalse()
      expect(a.trackColor).assertEqual(LhTokens.Color.Disabled.bg)
      expect(a.thumbColor).assertEqual(LhTokens.Color.Text.disabled)
    })

    // case: loading-blocks-change
    it('loading_is_not_interactive', 0, () => {
      const a = LhSwitchTokens.resolve(false, false, true, LhSwitchSize.Medium, light)
      expect(a.enabled).assertFalse()
      expect(a.loadingColor).assertEqual(LhTokens.Color.Primary.default)
    })

    // case: checked-uses-primary-token
    it('checked_uses_primary_token', 0, () => {
      const a = LhSwitchTokens.resolve(true, false, false, LhSwitchSize.Medium, light)
      expect(a.trackColor).assertEqual(LhTokens.Color.Primary.default)
      expect(a.thumbColor).assertEqual(LhTokens.Color.onPrimary)
    })

    // case: unchecked-uses-border-token
    it('unchecked_uses_border_token', 0, () => {
      const a = LhSwitchTokens.resolve(false, false, false, LhSwitchSize.Medium, light)
      expect(a.trackColor).assertEqual(LhTokens.Color.Border.base)
    })

    // size 映射到 width / height 令牌；滑块直径 = 高度 - 2 × gap；轨道圆角取高度一半
    it('size_maps_to_dimension_tokens', 0, () => {
      const a = LhSwitchTokens.resolve(false, false, false, LhSwitchSize.Medium, light)
      expect(a.width).assertEqual(LhTokens.Switch.Width.medium)
      expect(a.height).assertEqual(LhTokens.Switch.Height.medium)
      expect(a.thumbSize).assertEqual(LhTokens.Switch.Height.medium - 2 * LhTokens.Switch.gap)
      expect(a.borderRadius).assertEqual(LhTokens.Switch.Height.medium / 2)
    })

    // 滑块偏移：关闭贴左、开启贴右
    it('thumb_offset_follows_checked', 0, () => {
      const off = LhSwitchTokens.resolve(false, false, false, LhSwitchSize.Medium, light)
      expect(off.thumbOffset).assertEqual(LhTokens.Switch.gap)
      const on = LhSwitchTokens.resolve(true, false, false, LhSwitchSize.Medium, light)
      expect(on.thumbOffset).assertEqual(on.width - on.thumbSize - LhTokens.Switch.gap)
    })

    // 暗色专项
    it('dark_colors_come_from_dark_tokens', 0, () => {
      const a = LhSwitchTokens.resolve(true, false, false, LhSwitchSize.Medium, dark)
      expect(a.trackColor).assertEqual(LhDarkTokens.Color.Primary.default)
      expect(a.thumbColor).assertEqual(LhDarkTokens.Color.onPrimary)
    })

    it('dimensions_are_identical_in_dark_mode', 0, () => {
      const la = LhSwitchTokens.resolve(false, false, false, LhSwitchSize.Large, light)
      const da = LhSwitchTokens.resolve(false, false, false, LhSwitchSize.Large, dark)
      expect(la.width).assertEqual(da.width)
      expect(la.height).assertEqual(da.height)
    })
  })
}

