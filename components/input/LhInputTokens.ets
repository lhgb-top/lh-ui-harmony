import { LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'

/**
 * 输入框类型。枚举值与 `lh-ui-core/specs/input.json` 的 prop `type` 逐字对齐（R-n5）。
 *
 * password 时以圆点掩码显示（ArkUI 的 InputType.Password）。
 */
export enum LhInputType {
  Text = 'text',
  Password = 'password',
}

/**
 * 输入框尺寸。枚举值与 spec 的 prop `size` 逐字对齐。
 *
 * 映射到 input.height / paddingHorizontal / fontSize 令牌。
 */
export enum LhInputSize {
  Small = 'small',
  Medium = 'medium',
  Large = 'large',
}

/**
 * 输入框外观解析结果。由 LhInputTokens.resolve 纯函数产出，组件只负责把它画出来。
 */
export interface LhInputAppearance {
  height: number
  paddingHorizontal: number
  fontSize: number
  borderRadius: number
  /** 描边宽度；聚焦时取 focusRingWidth，否则取 borderWidth */
  borderWidth: number
  /** 描边色；聚焦时取 color.focus，否则取 color.border.base */
  borderColor: ResourceColor
  containerColor: ResourceColor
  textColor: ResourceColor
  placeholderColor: ResourceColor
  /** 清除按钮图标尺寸（input.clearIconSize） */
  clearIconSize: number
  /** 是否可交互（disabled 与 readonly 都不触发 onValueChange，但只 disabled 呈现禁用样式） */
  enabled: boolean
}

/**
 * 输入框令牌绑定与外观解析（纯函数，无组件依赖）。
 *
 * 令牌映射严格对齐 `lh-ui-core/specs/input.json` 的 behaviors：
 * - size 映射：small/medium/large 分别取 input.height.<size> 等尺寸令牌
 * - disabled 为 true 时取 disabled.* 令牌，不响应输入与清除
 * - 聚焦时描边色取 color.focus、宽度 input.focusRingWidth；失焦回 color.border.base + input.borderWidth
 */
export class LhInputTokens {
  /** 解析输入框外观（黄金用例的断言入口） */
  static resolve(
    size: LhInputSize,
    disabled: boolean,
    focused: boolean,
    colors: LhColors,
  ): LhInputAppearance {
    let height: number
    let paddingHorizontal: number
    let fontSize: number
    switch (size) {
      case LhInputSize.Small:
        height = LhTokens.Input.Height.small
        paddingHorizontal = LhTokens.Input.PaddingHorizontal.small
        fontSize = LhTokens.Input.FontSize.small
        break
      case LhInputSize.Medium:
        height = LhTokens.Input.Height.medium
        paddingHorizontal = LhTokens.Input.PaddingHorizontal.medium
        fontSize = LhTokens.Input.FontSize.medium
        break
      case LhInputSize.Large:
        height = LhTokens.Input.Height.large
        paddingHorizontal = LhTokens.Input.PaddingHorizontal.large
        fontSize = LhTokens.Input.FontSize.large
        break
    }

    const enabled = !disabled

    let container: ResourceColor
    let text: ResourceColor
    if (disabled) {
      container = colors.disabledBg
      text = colors.disabledText
    } else {
      container = colors.backgroundDefault
      text = colors.textPrimary
    }

    // 聚焦环：色取 color.focus、宽度 input.focusRingWidth；失焦回基础描边
    const borderWidth = focused ? LhTokens.Input.focusRingWidth : LhTokens.Input.borderWidth
    const borderColor = focused ? colors.focus : colors.borderBase

    return {
      height: height,
      paddingHorizontal: paddingHorizontal,
      fontSize: fontSize,
      borderRadius: LhTokens.Input.borderRadius,
      borderWidth: borderWidth,
      borderColor: borderColor,
      containerColor: container,
      textColor: text,
      placeholderColor: colors.textPlaceholder,
      clearIconSize: LhTokens.Input.clearIconSize,
      enabled: enabled,
    }
  }

  /** maxlength 截断：超出时截断新输入（黄金用例 maxlength-truncates-input） */
  static truncate(value: string, maxlength?: number): string {
    if (maxlength === undefined || maxlength < 0) {
      return value
    }
    if (value.length > maxlength) {
      return value.substring(0, maxlength)
    }
    return value
  }
}
