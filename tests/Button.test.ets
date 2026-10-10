import { LhButtonType, LhButtonSize, LhButtonTokens } from '../../../components/button/LhButtonTokens'
import { LightLhColors, DarkLhColors } from '../../../common/theme/LhTheme'
import { LhTokens } from '../../../tokens/LhTokens'
import { LhDarkTokens } from '../../../tokens/LhDarkTokens'
import { describe, it, expect } from '@ohos/hypium'

/**
 * 黄金用例翻译：`lh-ui-core/cases/button.json` 的 8 条断言。
 *
 * cases.then.tokens（「某令牌是否被应用」）在此断言为「解析后的外观值 == 生成令牌的值」——
 * 只要 LhButtonTokens.resolve 的返回取自令牌对象，映射即成立。这样黄金用例可以在
 * DevEco 的 ohpm test 里跑（交互 gate 走 appearance.enabled 纯断言）。
 */
export default function buttonTest(): void {
  describe('button', () => {
    const light = LightLhColors()
    const dark = DarkLhColors()

    // case: click-emits-onclick —— gate 放行
    it('enabled_button_is_interactive', 0, () => {
      const a = LhButtonTokens.resolve(LhButtonType.Default, LhButtonSize.Medium, false, false, false, light)
      expect(a.enabled).assertTrue()
    })

    // case: disabled-blocks-click
    it('disabled_is_not_interactive', 0, () => {
      const a = LhButtonTokens.resolve(LhButtonType.Default, LhButtonSize.Medium, true, false, false, light)
      expect(a.enabled).assertFalse()
    })

    // case: loading-blocks-click
    it('loading_is_not_interactive', 0, () => {
      const a = LhButtonTokens.resolve(LhButtonType.Default, LhButtonSize.Medium, false, true, false, light)
      expect(a.enabled).assertFalse()
    })

    // case: disabled-precedes-loading
    it('disabled_precedes_loading', 0, () => {
      const a = LhButtonTokens.resolve(LhButtonType.Default, LhButtonSize.Medium, true, true, false, light)
      expect(a.enabled).assertFalse()
      expect(a.containerColor).assertEqual(LhTokens.Color.Disabled.bg)
      expect(a.contentColor).assertEqual(LhTokens.Color.Disabled.text)
      expect(a.borderColor).assertEqual(LhTokens.Color.Disabled.border)
    })

    // case: default-type-renders-text
    it('default_type_uses_neutral_tokens', 0, () => {
      const a = LhButtonTokens.resolve(LhButtonType.Default, LhButtonSize.Medium, false, false, false, light)
      expect(a.containerColor).assertEqual(LhTokens.Color.Background.default)
      expect(a.contentColor).assertEqual(LhTokens.Color.Text.primary)
      expect(a.borderColor).assertEqual(LhTokens.Color.Border.base)
    })

    // case: primary-type-uses-primary-tokens
    it('primary_type_uses_primary_tokens', 0, () => {
      const a = LhButtonTokens.resolve(LhButtonType.Primary, LhButtonSize.Medium, false, false, false, light)
      expect(a.containerColor).assertEqual(LhTokens.Color.Primary.default)
      expect(a.contentColor).assertEqual(LhTokens.Color.onPrimary)
    })

    // case: small-size-uses-small-tokens
    it('small_size_uses_small_tokens', 0, () => {
      const a = LhButtonTokens.resolve(LhButtonType.Default, LhButtonSize.Small, false, false, false, light)
      expect(a.height).assertEqual(LhTokens.Button.Height.small)
      expect(a.fontSize).assertEqual(LhTokens.Button.FontSize.small)
      expect(LhTokens.Button.Height.small === LhTokens.Button.Height.large).assertFalse()
    })

    // case: bgpattern-uses-decoration-token
    it('bgpattern_uses_decoration_token', 0, () => {
      const withPattern = LhButtonTokens.resolve(LhButtonType.Default, LhButtonSize.Medium, false, false, true, light)
      expect(withPattern.patternColor).assertEqual(LhTokens.Color.decoration)
      const withoutPattern = LhButtonTokens.resolve(LhButtonType.Default, LhButtonSize.Medium, false, false, false, light)
      expect(withoutPattern.patternColor).assertUndefined()
    })

    // 暗色专项：色板取自 LhDarkTokens（并列对象模型）
    it('dark_colors_come_from_dark_tokens', 0, () => {
      const a = LhButtonTokens.resolve(LhButtonType.Primary, LhButtonSize.Medium, false, false, false, dark)
      expect(a.containerColor).assertEqual(LhDarkTokens.Color.Primary.default)
      expect(a.contentColor).assertEqual(LhDarkTokens.Color.onPrimary)
    })

    // 尺寸令牌暗色不覆盖
    it('dimensions_are_identical_in_dark_mode', 0, () => {
      const la = LhButtonTokens.resolve(LhButtonType.Default, LhButtonSize.Large, false, false, false, light)
      const da = LhButtonTokens.resolve(LhButtonType.Default, LhButtonSize.Large, false, false, false, dark)
      expect(la.height).assertEqual(da.height)
      expect(la.fontSize).assertEqual(da.fontSize)
    })
  })
}
