import { LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'

/**
 * 多行输入框外观解析结果。由 LhTextareaTokens.resolve 纯函数产出，组件只负责把它画出来。
 *
 * 高度由 rows 决定初始可见行数、内容超出时自动增高，故解析结果只给最小高度约束。
 */
export interface LhTextareaAppearance {
  paddingVertical: number
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
  /** 字数统计字号（textarea.countFontSize） */
  countFontSize: number
  /** 字数统计色（color.text.secondary） */
  countColor: ResourceColor
  /** 最小高度（textarea.minHeight） */
  minHeight: number
  /** 行高（typography.lineHeight.primary），用于按 rows 推算初始高度 */
  lineHeight: number
  enabled: boolean
}

/**
 * 多行输入框令牌绑定与外观解析（纯函数，无组件依赖）。
 *
 * 令牌映射严格对齐 `lh-ui-core/specs/textarea.json` 的 behaviors：
 * - 高度由 rows 决定初始可见行数，内容超出时自动增高（最小高度 textarea.minHeight）
 * - 聚焦时描边色取 color.focus、宽度 textarea.focusRingWidth；失焦回 color.border.base + borderWidth
 * - showCount 为 true 时右下角绘制字数统计，格式「当前/最大」，取 countFontSize 与 color.text.secondary
 * - disabled 为 true 时取 disabled.* 令牌
 */
export class LhTextareaTokens {
  /** 解析多行输入框外观（黄金用例的断言入口） */
  static resolve(
    rows: number,
    disabled: boolean,
    focused: boolean,
    colors: LhColors,
  ): LhTextareaAppearance {
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

    const borderWidth = focused ? LhTokens.Textarea.focusRingWidth : LhTokens.Textarea.borderWidth
    const borderColor = focused ? colors.focus : colors.borderBase

    return {
      paddingVertical: LhTokens.Textarea.paddingVertical,
      paddingHorizontal: LhTokens.Textarea.paddingHorizontal,
      fontSize: LhTokens.Textarea.fontSize,
      borderRadius: LhTokens.Textarea.borderRadius,
      borderWidth: borderWidth,
      borderColor: borderColor,
      containerColor: container,
      textColor: text,
      placeholderColor: colors.textPlaceholder,
      countFontSize: LhTokens.Textarea.countFontSize,
      countColor: colors.textSecondary,
      minHeight: LhTokens.Textarea.minHeight,
      lineHeight: LhTokens.Typography.LineHeight.primary,
      enabled: enabled,
    }
  }

  /** 按 rows 与行高推算初始可见高度；不小于 minHeight 令牌 */
  static heightForRows(rows: number, appearance: LhTextareaAppearance): number {
    const natural = appearance.fontSize * appearance.lineHeight * rows + appearance.paddingVertical * 2
    return natural > appearance.minHeight ? natural : appearance.minHeight
  }

  /** 字数统计文本：声明 maxlength 时为「当前/最大」，否则只显示当前长度 */
  static countText(value: string, maxlength?: number): string {
    if (maxlength === undefined || maxlength < 0) {
      return `${value.length}`
    }
    return `${value.length}/${maxlength}`
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
