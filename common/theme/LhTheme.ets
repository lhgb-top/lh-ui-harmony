import { LhTokens } from '../../tokens/LhTokens'
import { LhDarkTokens } from '../../tokens/LhDarkTokens'

/**
 * 主题色板：把 core 生成的 LhTokens / LhDarkTokens 平铺为一份不可变接口。
 *
 * 暗色令牌是**并列对象**模型（core codegen 的 harmony target 只在 LhDarkTokens 里
 * 放 Color 子类，尺寸/动效/圆角暗色不覆盖）。本接口只承载颜色，尺寸令牌由组件直接
 * 取 LhTokens（尺寸无暗色变体）。
 *
 * 工厂函数公开是为了让单测能直接构造色板做断言；应用侧应通过 LhTheme 消费。
 */
export interface LhColors {
  primary: ResourceColor
  primaryHover: ResourceColor
  primaryActive: ResourceColor
  primaryBg: ResourceColor
  primaryBorder: ResourceColor
  onPrimary: ResourceColor
  success: ResourceColor
  successHover: ResourceColor
  successActive: ResourceColor
  successBg: ResourceColor
  warning: ResourceColor
  warningHover: ResourceColor
  warningActive: ResourceColor
  warningBg: ResourceColor
  danger: ResourceColor
  dangerHover: ResourceColor
  dangerActive: ResourceColor
  dangerBg: ResourceColor
  info: ResourceColor
  infoHover: ResourceColor
  infoActive: ResourceColor
  infoBg: ResourceColor
  textPrimary: ResourceColor
  textRegular: ResourceColor
  textSecondary: ResourceColor
  textPlaceholder: ResourceColor
  textDisabled: ResourceColor
  backgroundDefault: ResourceColor
  backgroundPage: ResourceColor
  backgroundDisabled: ResourceColor
  backgroundOverlay: ResourceColor
  borderBase: ResourceColor
  borderLight: ResourceColor
  borderLighter: ResourceColor
  borderExtraLight: ResourceColor
  disabledBg: ResourceColor
  disabledText: ResourceColor
  disabledBorder: ResourceColor
  decoration: ResourceColor
  hoverBg: ResourceColor
  selected: ResourceColor
  focus: ResourceColor
  /** 中性黑（墨）：toast 胶囊底色（toast 契约 tokenRefs: color.ink） */
  ink: ResourceColor
}

/** 明色色板：逐字段取 LhTokens.Color */
export function LightLhColors(): LhColors {
  return {
    primary: LhTokens.Color.Primary.default,
    primaryHover: LhTokens.Color.Primary.hover,
    primaryActive: LhTokens.Color.Primary.active,
    primaryBg: LhTokens.Color.Primary.bg,
    primaryBorder: LhTokens.Color.Primary.border,
    onPrimary: LhTokens.Color.onPrimary,
    success: LhTokens.Color.Success.default,
    successHover: LhTokens.Color.Success.hover,
    successActive: LhTokens.Color.Success.active,
    successBg: LhTokens.Color.Success.bg,
    warning: LhTokens.Color.Warning.default,
    warningHover: LhTokens.Color.Warning.hover,
    warningActive: LhTokens.Color.Warning.active,
    warningBg: LhTokens.Color.Warning.bg,
    danger: LhTokens.Color.Danger.default,
    dangerHover: LhTokens.Color.Danger.hover,
    dangerActive: LhTokens.Color.Danger.active,
    dangerBg: LhTokens.Color.Danger.bg,
    info: LhTokens.Color.Info.default,
    infoHover: LhTokens.Color.Info.hover,
    infoActive: LhTokens.Color.Info.active,
    infoBg: LhTokens.Color.Info.bg,
    textPrimary: LhTokens.Color.Text.primary,
    textRegular: LhTokens.Color.Text.regular,
    textSecondary: LhTokens.Color.Text.secondary,
    textPlaceholder: LhTokens.Color.Text.placeholder,
    textDisabled: LhTokens.Color.Text.disabled,
    backgroundDefault: LhTokens.Color.Background.default,
    backgroundPage: LhTokens.Color.Background.page,
    backgroundDisabled: LhTokens.Color.Background.disabled,
    backgroundOverlay: LhTokens.Color.Background.overlay,
    borderBase: LhTokens.Color.Border.base,
    borderLight: LhTokens.Color.Border.light,
    borderLighter: LhTokens.Color.Border.lighter,
    borderExtraLight: LhTokens.Color.Border.extraLight,
    disabledBg: LhTokens.Color.Disabled.bg,
    disabledText: LhTokens.Color.Disabled.text,
    disabledBorder: LhTokens.Color.Disabled.border,
    decoration: LhTokens.Color.decoration,
    hoverBg: LhTokens.Color.hoverBg,
    selected: LhTokens.Color.selected,
    focus: LhTokens.Color.focus,
    ink: LhTokens.Color.ink,
  }
}

/** 暗色色板：逐字段取 LhDarkTokens.Color（并列对象，仅颜色覆盖） */
export function DarkLhColors(): LhColors {
  return {
    primary: LhDarkTokens.Color.Primary.default,
    primaryHover: LhDarkTokens.Color.Primary.hover,
    primaryActive: LhDarkTokens.Color.Primary.active,
    primaryBg: LhDarkTokens.Color.Primary.bg,
    primaryBorder: LhDarkTokens.Color.Primary.border,
    onPrimary: LhDarkTokens.Color.onPrimary,
    success: LhDarkTokens.Color.Success.default,
    successHover: LhDarkTokens.Color.Success.hover,
    successActive: LhDarkTokens.Color.Success.active,
    successBg: LhDarkTokens.Color.Success.bg,
    warning: LhDarkTokens.Color.Warning.default,
    warningHover: LhDarkTokens.Color.Warning.hover,
    warningActive: LhDarkTokens.Color.Warning.active,
    warningBg: LhDarkTokens.Color.Warning.bg,
    danger: LhDarkTokens.Color.Danger.default,
    dangerHover: LhDarkTokens.Color.Danger.hover,
    dangerActive: LhDarkTokens.Color.Danger.active,
    dangerBg: LhDarkTokens.Color.Danger.bg,
    info: LhDarkTokens.Color.Info.default,
    infoHover: LhDarkTokens.Color.Info.hover,
    infoActive: LhDarkTokens.Color.Info.active,
    infoBg: LhDarkTokens.Color.Info.bg,
    textPrimary: LhDarkTokens.Color.Text.primary,
    textRegular: LhDarkTokens.Color.Text.regular,
    textSecondary: LhDarkTokens.Color.Text.secondary,
    textPlaceholder: LhDarkTokens.Color.Text.placeholder,
    textDisabled: LhDarkTokens.Color.Text.disabled,
    backgroundDefault: LhDarkTokens.Color.Background.default,
    backgroundPage: LhDarkTokens.Color.Background.page,
    backgroundDisabled: LhDarkTokens.Color.Background.disabled,
    backgroundOverlay: LhDarkTokens.Color.Background.overlay,
    borderBase: LhDarkTokens.Color.Border.base,
    borderLight: LhDarkTokens.Color.Border.light,
    borderLighter: LhDarkTokens.Color.Border.lighter,
    borderExtraLight: LhDarkTokens.Color.Border.extraLight,
    disabledBg: LhDarkTokens.Color.Disabled.bg,
    disabledText: LhDarkTokens.Color.Disabled.text,
    disabledBorder: LhDarkTokens.Color.Disabled.border,
    decoration: LhDarkTokens.Color.decoration,
    hoverBg: LhDarkTokens.Color.hoverBg,
    selected: LhDarkTokens.Color.selected,
    focus: LhDarkTokens.Color.focus,
    ink: LhDarkTokens.Color.ink,
  }
}

/** AppStorage 主题键：LhTheme 组件据此注入色板，@Consume 消费 */
export const LH_COLORS_KEY = 'lh_colors'
export const LH_IS_DARK_KEY = 'lh_is_dark'
