import { LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'

/**
 * 单元格外观解析结果。由 LhCellTokens.resolve 纯函数产出，组件只负责把它画出来。
 *
 * 高度由内容（标题行 + 可选说明行）与内边距决定，故解析结果不含高度。
 */
export interface LhCellAppearance {
  paddingHorizontal: number
  paddingVertical: number
  /** 标题与说明文字之间的垂直间距 */
  gap: number
  fontSizeTitle: number
  fontSizeLabel: number
  fontSizeValue: number
  /** 行高（typography.lineHeight.primary） */
  lineHeight: number
  /** 左侧图标尺寸（icon.size.medium） */
  iconSize: number
  titleColor: ResourceColor
  labelColor: ResourceColor
  valueColor: ResourceColor
  iconColor: ResourceColor
  /** 必填红星色（color.danger.default） */
  requiredColor: ResourceColor
  /** 右侧指示箭头色（color.text.secondary） */
  arrowColor: ResourceColor
  /** 底部分隔线色（color.border.lighter）；bordered 为 false 时为 undefined */
  dividerColor?: ResourceColor
  /** 标题与左侧图标的水平间距（spacing.sm） */
  iconGap: number
}

/**
 * 单元格令牌绑定与外观解析（纯函数，无组件依赖）。
 *
 * 令牌映射严格对齐 `lh-ui-core/specs/cell.json` 的 behaviors：
 * - 标题取 cell.fontSizeTitle 与 color.text.primary
 * - 说明取 cell.fontSizeLabel 与 color.text.secondary
 * - 值取 cell.fontSizeValue 与 color.text.secondary 并右对齐
 * - required 为 true 时标题前绘制红星（danger 色）
 * - icon 非空时在左侧绘制尺寸 icon.size.medium 的图标
 * - clickable 为 true 时右侧绘制指示箭头
 * - bordered 为 true 时底部绘制分隔线（color.border.lighter）
 */
export class LhCellTokens {
  /**
   * 解析单元格外观（黄金用例的断言入口）。
   *
   * 图标是否绘制由组件按 `icon !== undefined` 判断（令牌侧无开关），故入参只有
   * bordered / clickable 两个状态开关。
   */
  static resolve(
    bordered: boolean,
    clickable: boolean,
    colors: LhColors,
  ): LhCellAppearance {
    return {
      paddingHorizontal: LhTokens.Cell.paddingHorizontal,
      paddingVertical: LhTokens.Cell.paddingVertical,
      gap: LhTokens.Cell.gap,
      fontSizeTitle: LhTokens.Cell.fontSizeTitle,
      fontSizeLabel: LhTokens.Cell.fontSizeLabel,
      fontSizeValue: LhTokens.Cell.fontSizeValue,
      lineHeight: LhTokens.Typography.LineHeight.primary,
      iconSize: LhTokens.Icon.Size.medium,
      titleColor: colors.textPrimary,
      labelColor: colors.textSecondary,
      valueColor: colors.textSecondary,
      iconColor: colors.textRegular,
      requiredColor: colors.danger,
      arrowColor: colors.textSecondary,
      dividerColor: bordered ? colors.borderLighter : undefined,
      iconGap: LhTokens.Spacing.sm,
    }
  }
}
