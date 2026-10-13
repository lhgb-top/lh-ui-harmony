import {
  LhTextLevel, LhTextWeight, LhTextTone, LhTextAlign,
  LhTextTokens, LightLhColors, DarkLhColors, LhTokens, LhDarkTokens,
} from 'top.lhgb.ui.harmony'
import { describe, it, expect } from '@ohos/hypium'

/**
 * 黄金用例翻译：`lh-ui-core/cases/text.json` 的 5 条断言。
 *
 * cases.then.tokens（「某令牌是否被应用」）在此断言为「解析后的外观值 == 生成令牌的值」——
 * 只要 LhTextTokens.resolve 的返回取自令牌对象，映射即成立（与 Button/Icon 测试同构）。
 * notes 型用例（绘制指令流）无字段可断言，按 Icon 测试的先例翻译为可验证的端侧落点。
 */
export default function textTest(): void {
  describe('text', () => {
    const light = LightLhColors()
    const dark = DarkLhColors()

    // case: default-level-uses-base-tokens
    it('default_level_uses_base_tokens', 0, () => {
      const a = LhTextTokens.resolve(LhTextLevel.Base, LhTextWeight.Primary, LhTextTone.Primary, light)
      expect(a.fontSize).assertEqual(LhTokens.Typography.FontSize.base)
      expect(a.fontWeight).assertEqual(LhTokens.Typography.FontWeight.primary)
      expect(a.lineHeight).assertEqual(LhTokens.Typography.LineHeight.primary)
      expect(a.fontColor).assertEqual(LhTokens.Color.Text.primary)
    })

    // case: large-level-uses-large-token（同时验证 base 未被误用）
    it('large_level_uses_large_token', 0, () => {
      const a = LhTextTokens.resolve(LhTextLevel.Large, LhTextWeight.Primary, LhTextTone.Primary, light)
      expect(a.fontSize).assertEqual(LhTokens.Typography.FontSize.large)
      expect(a.fontSize === LhTokens.Typography.FontSize.base).assertFalse()
    })

    // case: bold-weight-uses-bold-token
    it('bold_weight_uses_bold_token', 0, () => {
      const a = LhTextTokens.resolve(LhTextLevel.Base, LhTextWeight.Bold, LhTextTone.Primary, light)
      expect(a.fontWeight).assertEqual(LhTokens.Typography.FontWeight.bold)
      expect(a.fontWeight === LhTokens.Typography.FontWeight.primary).assertFalse()
    })

    // case: secondary-tone-uses-text-secondary
    it('secondary_tone_uses_text_secondary', 0, () => {
      const a = LhTextTokens.resolve(LhTextLevel.Base, LhTextWeight.Primary, LhTextTone.Secondary, light)
      expect(a.fontColor).assertEqual(LhTokens.Color.Text.secondary)
      expect(a.fontColor === LhTokens.Color.Text.primary).assertFalse()
    })

    // case: render-emits-single-text-command —— 端侧落点：单 Text 节点的完整外观解析
    // ArkUI 侧一个 LhText 就是单个 Text 组件（无包裹容器）；resolve 一次性产出
    // 该节点所需的全部样式字段，等价于「指令流里只有一条 TEXT 指令」。
    it('resolve_produces_single_complete_text_style', 0, () => {
      const a = LhTextTokens.resolve(LhTextLevel.Base, LhTextWeight.Primary, LhTextTone.Primary, light)
      expect(a.fontSize).assertEqual(LhTokens.Typography.FontSize.base)
      expect(a.fontWeight).assertEqual(LhTokens.Typography.FontWeight.primary)
      expect(a.lineHeight).assertEqual(LhTokens.Typography.LineHeight.primary)
      expect(a.fontColor).assertEqual(LhTokens.Color.Text.primary)
      // 对齐由独立映射承载，三值均可解析（不命中 default 分支的 switch 是穷尽的）
      expect(LhTextTokens.alignFor(LhTextAlign.Start)).assertEqual(TextAlign.Start)
      expect(LhTextTokens.alignFor(LhTextAlign.Center)).assertEqual(TextAlign.Center)
      expect(LhTextTokens.alignFor(LhTextAlign.End)).assertEqual(TextAlign.End)
    })

    // 暗色专项：色板取自 LhDarkTokens（并列对象模型）
    it('dark_colors_come_from_dark_tokens', 0, () => {
      const a = LhTextTokens.resolve(LhTextLevel.Base, LhTextWeight.Primary, LhTextTone.Secondary, dark)
      expect(a.fontColor).assertEqual(LhDarkTokens.Color.Text.secondary)
    })

    // 排版令牌暗色不覆盖（尺寸类令牌暗色无变体）
    it('dimensions_are_identical_in_dark_mode', 0, () => {
      const la = LhTextTokens.resolve(LhTextLevel.Large, LhTextWeight.Bold, LhTextTone.Primary, light)
      const da = LhTextTokens.resolve(LhTextLevel.Large, LhTextWeight.Bold, LhTextTone.Primary, dark)
      expect(la.fontSize).assertEqual(da.fontSize)
      expect(la.fontWeight).assertEqual(da.fontWeight)
      expect(la.lineHeight).assertEqual(da.lineHeight)
    })
  })
}
