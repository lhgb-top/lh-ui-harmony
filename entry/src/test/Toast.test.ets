import { LhToastType, LhToastTokens, LightLhColors, DarkLhColors, LhTokens, LhDarkTokens } from 'top.lhgb.ui.harmony'
import { describe, it, expect } from '@ohos/hypium'

/**
 * 黄金用例翻译：`lh-ui-core/cases/toast.json` 的 6 条断言。
 *
 * 计时模型（show/hide/tick）在端侧由 setTimeout 承载，交互 gate 在组件方法；
 * 此处断言 resolve 的外观契约（墨色胶囊、语义色点、层级）。
 */
export default function toastTest(): void {
  describe('toast', () => {
    const light = LightLhColors()
    const dark = DarkLhColors()

    // case: show-makes-visible —— 胶囊底取 color.ink，文字取 color.onPrimary
    it('capsule_uses_ink_and_on_primary_tokens', 0, () => {
      const a = LhToastTokens.resolve(LhToastType.Default, light)
      expect(a.containerColor).assertEqual(LhTokens.Color.ink)
      expect(a.contentColor).assertEqual(LhTokens.Color.onPrimary)
    })

    // case: success-type-uses-success-token
    it('success_type_uses_success_token', 0, () => {
      const a = LhToastTokens.resolve(LhToastType.Success, light)
      expect(a.dotColor).assertEqual(LhTokens.Color.Success.default)
    })

    it('type_variants_map_to_dot_colors', 0, () => {
      expect(LhToastTokens.resolve(LhToastType.Warning, light).dotColor).assertEqual(LhTokens.Color.Warning.default)
      expect(LhToastTokens.resolve(LhToastType.Danger, light).dotColor).assertEqual(LhTokens.Color.Danger.default)
      expect(LhToastTokens.resolve(LhToastType.Info, light).dotColor).assertEqual(LhTokens.Color.Info.default)
    })

    // case: hidden-emits-no-commands —— default 类型不绘制色点
    it('default_type_has_no_dot', 0, () => {
      expect(LhToastTokens.resolve(LhToastType.Default, light).dotColor).assertUndefined()
    })

    // 尺寸令牌
    it('dimensions_use_tokens', 0, () => {
      const a = LhToastTokens.resolve(LhToastType.Default, light)
      expect(a.fontSize).assertEqual(LhTokens.Toast.fontSize)
      expect(a.paddingHorizontal).assertEqual(LhTokens.Toast.paddingHorizontal)
      expect(a.paddingVertical).assertEqual(LhTokens.Toast.paddingVertical)
      expect(a.borderRadius).assertEqual(LhTokens.Toast.borderRadius)
      expect(a.gap).assertEqual(LhTokens.Toast.gap)
    })

    // 层级与定位留白
    it('zindex_and_edge_margin_use_tokens', 0, () => {
      const a = LhToastTokens.resolve(LhToastType.Default, light)
      expect(a.zIndex).assertEqual(LhTokens.ZIndex.toast)
      expect(a.edgeMargin).assertEqual(LhTokens.Spacing.xl)
    })

    // 色点直径取字号
    it('dot_size_equals_font_size', 0, () => {
      const a = LhToastTokens.resolve(LhToastType.Success, light)
      expect(a.dotSize).assertEqual(LhTokens.Toast.fontSize)
    })

    // 暗色专项
    it('dark_colors_come_from_dark_tokens', 0, () => {
      const a = LhToastTokens.resolve(LhToastType.Success, dark)
      expect(a.containerColor).assertEqual(LhDarkTokens.Color.ink)
      expect(a.contentColor).assertEqual(LhDarkTokens.Color.onPrimary)
      expect(a.dotColor).assertEqual(LhDarkTokens.Color.Success.default)
    })

    it('dimensions_are_identical_in_dark_mode', 0, () => {
      const la = LhToastTokens.resolve(LhToastType.Default, light)
      const da = LhToastTokens.resolve(LhToastType.Default, dark)
      expect(la.fontSize).assertEqual(da.fontSize)
      expect(la.borderRadius).assertEqual(da.borderRadius)
    })
  })
}

