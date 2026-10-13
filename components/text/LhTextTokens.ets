import { LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'

/**
 * 字号级别。枚举值与 `lh-ui-core/specs/text.json` 的 prop `level` 逐字对齐（R-n5）。
 *
 * 映射到 typography.fontSize.<level> 令牌。
 */
export enum LhTextLevel {
  ExtraLarge = 'extraLarge',
  Large = 'large',
  Medium = 'medium',
  Base = 'base',
  Small = 'small',
  ExtraSmall = 'extraSmall',
}

/**
 * 字重。枚举值与 spec 的 prop `weight` 逐字对齐。
 *
 * 映射到 typography.fontWeight.<weight> 令牌。
 */
export enum LhTextWeight {
  Primary = 'primary',
  Bold = 'bold',
}

/**
 * 文字色调。枚举值与 spec 的 prop `tone` 逐字对齐。
 *
 * primary/regular/secondary/placeholder/disabled 取 color.text.<tone>；
 * selected 取 color.selected。
 */
export enum LhTextTone {
  Primary = 'primary',
  Regular = 'regular',
  Secondary = 'secondary',
  Placeholder = 'placeholder',
  Disabled = 'disabled',
  Selected = 'selected',
}

/**
 * 水平对齐方式。枚举值与 spec 的 prop `align` 逐字对齐。
 *
 * 对齐不是设计令牌（是行盒内的几何定位），映射到 ArkUI 的 TextAlign。
 */
export enum LhTextAlign {
  Start = 'start',
  Center = 'center',
  End = 'end',
}

/**
 * 文本外观解析结果。由 LhTextTokens.resolve 纯函数产出，组件只负责把它画出来。
 *
 * 字号/字重/行高/文字色全部取自令牌或色板，无字面量（红线 1）。
 */
export interface LhTextAppearance {
  /** 字号（vp） */
  fontSize: number
  /** 字重（ArkUI 的 fontWeight 取数值） */
  fontWeight: number
  /** 行高（typography.lineHeight.primary，行盒高度 = fontSize × lineHeight） */
  lineHeight: number
  /** 文字颜色 */
  fontColor: ResourceColor
}

/**
 * 文本令牌绑定与外观解析（纯函数，无组件依赖）。
 *
 * 令牌映射严格对齐 `lh-ui-core/specs/text.json` 的 behaviors：
 * - level 映射：extraLarge…extraSmall 分别取 typography.fontSize.<level>
 * - weight 映射：primary/bold 分别取 typography.fontWeight.<weight>
 * - tone 映射：取 color.text.<tone>；selected 取 color.selected
 * - 行高取 typography.lineHeight.primary，layout 高度 = 字号 × 行高
 */
export class LhTextTokens {
  /** 解析文本外观（黄金用例的断言入口） */
  static resolve(
    level: LhTextLevel,
    weight: LhTextWeight,
    tone: LhTextTone,
    colors: LhColors,
  ): LhTextAppearance {
    let fontSize: number
    switch (level) {
      case LhTextLevel.ExtraLarge:
        fontSize = LhTokens.Typography.FontSize.extraLarge
        break
      case LhTextLevel.Large:
        fontSize = LhTokens.Typography.FontSize.large
        break
      case LhTextLevel.Medium:
        fontSize = LhTokens.Typography.FontSize.medium
        break
      case LhTextLevel.Base:
        fontSize = LhTokens.Typography.FontSize.base
        break
      case LhTextLevel.Small:
        fontSize = LhTokens.Typography.FontSize.small
        break
      case LhTextLevel.ExtraSmall:
        fontSize = LhTokens.Typography.FontSize.extraSmall
        break
    }

    let fontWeight: number
    switch (weight) {
      case LhTextWeight.Primary:
        fontWeight = LhTokens.Typography.FontWeight.primary
        break
      case LhTextWeight.Bold:
        fontWeight = LhTokens.Typography.FontWeight.bold
        break
    }

    let fontColor: ResourceColor
    switch (tone) {
      case LhTextTone.Primary:
        fontColor = colors.textPrimary
        break
      case LhTextTone.Regular:
        fontColor = colors.textRegular
        break
      case LhTextTone.Secondary:
        fontColor = colors.textSecondary
        break
      case LhTextTone.Placeholder:
        fontColor = colors.textPlaceholder
        break
      case LhTextTone.Disabled:
        fontColor = colors.textDisabled
        break
      case LhTextTone.Selected:
        fontColor = colors.selected
        break
    }

    return {
      fontSize: fontSize,
      fontWeight: fontWeight,
      lineHeight: LhTokens.Typography.LineHeight.primary,
      fontColor: fontColor,
    }
  }

  /**
   * 对齐枚举 → ArkUI 的 TextAlign（spec：align 决定文字在行盒宽度内的水平定位）。
   *
   * 对齐不是设计令牌，映射到框架枚举不违反红线 1（红线约束的是色值/间距/圆角/字号）。
   */
  static alignFor(align: LhTextAlign): TextAlign {
    switch (align) {
      case LhTextAlign.Start:
        return TextAlign.Start
      case LhTextAlign.Center:
        return TextAlign.Center
      case LhTextAlign.End:
        return TextAlign.End
    }
  }
}
