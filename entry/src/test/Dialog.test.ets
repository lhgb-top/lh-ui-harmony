import { LhDialogType, LhDialogTokens, LhButtonType, LightLhColors, DarkLhColors, LhTokens, LhDarkTokens } from 'top.lhgb.ui.harmony'
import { describe, it, expect } from '@ohos/hypium'

/**
 * 黄金用例翻译：`lh-ui-core/cases/dialog.json` 的 8 条断言。
 *
 * 可见性 gate（visible 为 false 时不渲染）在组件 build() 的 if 分支，
 * 此处断言 resolve 的外观契约（确认/取消按钮类型映射、层级、遮罩）。
 */
export default function dialogTest(): void {
  describe('dialog', () => {
    const light = LightLhColors()
    const dark = DarkLhColors()

    // case: confirm-emits-onconfirm / cancel-emits-oncancel —— 按钮区存在性由文字决定，
    // 确认按钮按 type 映射语义色
    it('confirm_button_type_maps_from_dialog_type', 0, () => {
      const a = LhDialogTokens.resolve(LhDialogType.Default, light)
      expect(a.confirmButtonType).assertEqual(LhButtonType.Default)
    })

    // case: danger-type-uses-danger-token
    it('danger_type_uses_danger_token', 0, () => {
      const a = LhDialogTokens.resolve(LhDialogType.Danger, light)
      expect(a.confirmButtonType).assertEqual(LhButtonType.Danger)
    })

    it('type_variants_map_to_button_types', 0, () => {
      expect(LhDialogTokens.resolve(LhDialogType.Primary, light).confirmButtonType).assertEqual(LhButtonType.Primary)
      expect(LhDialogTokens.resolve(LhDialogType.Success, light).confirmButtonType).assertEqual(LhButtonType.Success)
      expect(LhDialogTokens.resolve(LhDialogType.Warning, light).confirmButtonType).assertEqual(LhButtonType.Warning)
      expect(LhDialogTokens.resolve(LhDialogType.Info, light).confirmButtonType).assertEqual(LhButtonType.Info)
    })

    // case: title-renders-text —— 标题/内容字号取令牌
    it('title_and_content_use_font_tokens', 0, () => {
      const a = LhDialogTokens.resolve(LhDialogType.Default, light)
      expect(a.titleFontSize).assertEqual(LhTokens.Dialog.titleFontSize)
      expect(a.contentFontSize).assertEqual(LhTokens.Dialog.contentFontSize)
      expect(a.gap).assertEqual(LhTokens.Dialog.gap)
    })

    // case: closable-overlay-emits-onclose / not-closable-blocks-overlay-close
    // 遮罩与层级取令牌（closable 的 gate 在组件 onClick）
    it('overlay_and_zindex_use_tokens', 0, () => {
      const a = LhDialogTokens.resolve(LhDialogType.Default, light)
      expect(a.overlayColor).assertEqual(LhTokens.Color.Background.overlay)
      expect(a.zIndexBackdrop).assertEqual(LhTokens.ZIndex.modalBackdrop)
      expect(a.zIndexModal).assertEqual(LhTokens.ZIndex.modal)
    })

    it('card_dimensions_use_tokens', 0, () => {
      const a = LhDialogTokens.resolve(LhDialogType.Default, light)
      expect(a.width).assertEqual(LhTokens.Dialog.width)
      expect(a.borderRadius).assertEqual(LhTokens.Dialog.borderRadius)
      expect(a.paddingHorizontal).assertEqual(LhTokens.Dialog.paddingHorizontal)
      expect(a.paddingVertical).assertEqual(LhTokens.Dialog.paddingVertical)
    })

    it('colors_use_neutral_tokens', 0, () => {
      const a = LhDialogTokens.resolve(LhDialogType.Default, light)
      expect(a.containerColor).assertEqual(LhTokens.Color.Background.default)
      expect(a.titleColor).assertEqual(LhTokens.Color.Text.primary)
      expect(a.contentColor).assertEqual(LhTokens.Color.Text.regular)
    })

    // 暗色专项
    it('dark_colors_come_from_dark_tokens', 0, () => {
      const a = LhDialogTokens.resolve(LhDialogType.Default, dark)
      expect(a.containerColor).assertEqual(LhDarkTokens.Color.Background.default)
      expect(a.overlayColor).assertEqual(LhDarkTokens.Color.Background.overlay)
      expect(a.titleColor).assertEqual(LhDarkTokens.Color.Text.primary)
    })

    it('dimensions_are_identical_in_dark_mode', 0, () => {
      const la = LhDialogTokens.resolve(LhDialogType.Default, light)
      const da = LhDialogTokens.resolve(LhDialogType.Default, dark)
      expect(la.width).assertEqual(da.width)
      expect(la.titleFontSize).assertEqual(da.titleFontSize)
    })
  })
}

