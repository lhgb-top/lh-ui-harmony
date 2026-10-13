import { LhPickerTokens, LightLhColors, DarkLhColors, LhTokens, LhDarkTokens } from 'top.lhgb.ui.harmony'
import { describe, it, expect } from '@ohos/hypium'

/**
 * 黄金用例翻译：`lh-ui-core/cases/picker.json` 的 8 条断言。
 */
export default function pickerTest(): void {
  describe('picker', () => {
    const light = LightLhColors()
    const dark = DarkLhColors()

    // case: clamp-negative-value-to-zero
    it('clamp_negative_value_to_zero', 0, () => {
      expect(LhPickerTokens.clampIndex(-1, 2)).assertEqual(0)
    })

    // case: clamp-overflow-value-to-last
    it('clamp_overflow_value_to_last', 0, () => {
      expect(LhPickerTokens.clampIndex(99, 3)).assertEqual(2)
    })

    it('clamp_keeps_in_range_value', 0, () => {
      expect(LhPickerTokens.clampIndex(1, 3)).assertEqual(1)
    })

    // case: title-renders-text —— 工具栏与候选项尺寸取令牌
    it('dimensions_use_tokens', 0, () => {
      const a = LhPickerTokens.resolve(3, 0, light)
      expect(a.height).assertEqual(LhTokens.Picker.height)
      expect(a.itemHeight).assertEqual(LhTokens.Picker.itemHeight)
      expect(a.toolbarHeight).assertEqual(LhTokens.Picker.toolbarHeight)
      expect(a.itemFontSize).assertEqual(LhTokens.Picker.itemFontSize)
      expect(a.borderRadius).assertEqual(LhTokens.Picker.borderRadius)
    })

    // 滚轮区高度 = 面板高度 - 工具栏高度
    it('wheel_height_minus_toolbar', 0, () => {
      const a = LhPickerTokens.resolve(3, 0, light)
      expect(a.wheelHeight).assertEqual(LhTokens.Picker.height - LhTokens.Picker.toolbarHeight)
    })

    // case: confirm-emits-onconfirm-with-value —— 确认色取主色，取消色取次要文字色
    it('toolbar_colors_use_tokens', 0, () => {
      const a = LhPickerTokens.resolve(3, 0, light)
      expect(a.confirmColor).assertEqual(LhTokens.Color.Primary.default)
      expect(a.cancelColor).assertEqual(LhTokens.Color.Text.secondary)
      expect(a.titleColor).assertEqual(LhTokens.Color.Text.primary)
    })

    // 遮罩与层级
    it('overlay_and_zindex_use_tokens', 0, () => {
      const a = LhPickerTokens.resolve(3, 0, light)
      expect(a.overlayColor).assertEqual(LhTokens.Color.Background.overlay)
      expect(a.zIndexBackdrop).assertEqual(LhTokens.ZIndex.modalBackdrop)
      expect(a.zIndexModal).assertEqual(LhTokens.ZIndex.modal)
    })

    // value 钳制走 resolve
    it('resolve_clamps_selected_index', 0, () => {
      expect(LhPickerTokens.resolve(2, -1, light).selectedIndex).assertEqual(0)
      expect(LhPickerTokens.resolve(3, 99, light).selectedIndex).assertEqual(2)
    })

    // 暗色专项
    it('dark_colors_come_from_dark_tokens', 0, () => {
      const a = LhPickerTokens.resolve(3, 0, dark)
      expect(a.containerColor).assertEqual(LhDarkTokens.Color.Background.default)
      expect(a.overlayColor).assertEqual(LhDarkTokens.Color.Background.overlay)
    })

    it('dimensions_are_identical_in_dark_mode', 0, () => {
      const la = LhPickerTokens.resolve(3, 0, light)
      const da = LhPickerTokens.resolve(3, 0, dark)
      expect(la.height).assertEqual(da.height)
      expect(la.itemHeight).assertEqual(da.itemHeight)
    })
  })
}

