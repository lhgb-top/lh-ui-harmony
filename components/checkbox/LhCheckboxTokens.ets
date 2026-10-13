import { LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'

/**
 * 复选框尺寸。枚举值与 `lh-ui-core/specs/checkbox.json` 的 prop `size` 逐字对齐（R-n5）。
 *
 * 映射到 checkbox.size.* 方框尺寸令牌。
 */
export enum LhCheckboxSize {
  Small = 'small',
  Medium = 'medium',
  Large = 'large',
}

/**
 * 复选框指示符形态：未选中无指示符，选中为勾形，不确定为横杠。
 */
export enum LhCheckboxMark {
  None = 'none',
  Check = 'check',
  Dash = 'dash',
}

/**
 * 复选框外观解析结果。由 LhCheckboxTokens.resolve 纯函数产出，组件只负责把它画出来。
 */
export interface LhCheckboxAppearance {
  /** 方框尺寸（vp） */
  size: number
  borderRadius: number
  borderWidth: number
  /** 勾形/横杠描边宽度（checkbox.checkWidth） */
  checkWidth: number
  /** 方框底色：选中/不确定为 primary，未选中透明（露出底色） */
  containerColor: ResourceColor
  /** 指示符颜色：选中/不确定为 onPrimary，未选中无意义 */
  markColor: ResourceColor
  /** 方框描边色：未选中为 border.base，选中/不确定为 primary（被实心底覆盖） */
  borderColor: ResourceColor
  /** 文字标签色（disabled 时取 color.text.disabled） */
  labelColor: ResourceColor
  /** 方框与文字间距（checkbox.gap） */
  gap: number
  /** 指示符形态 */
  mark: LhCheckboxMark
  enabled: boolean
}

/**
 * 复选框令牌绑定与外观解析（纯函数，无组件依赖）。
 *
 * 令牌映射严格对齐 `lh-ui-core/specs/checkbox.json` 的 behaviors：
 * - size 映射：small/medium/large 分别取 checkbox.size.<size> 方框尺寸令牌
 * - 未选中：只描边（color.border.base），无填充
 * - 选中/不确定：实心 primary 底 + onPrimary 指示符；选中画勾形，不确定画横杠
 * - disabled：底/边/指示符/文字全部取 disabled.* 令牌，且不响应点击
 * - 点击命中整个行（方框 + 标签区域）：indeterminate 变为选中，否则翻转选中态
 */
export class LhCheckboxTokens {
  /** 解析复选框外观（黄金用例的断言入口） */
  static resolve(
    checked: boolean,
    indeterminate: boolean,
    disabled: boolean,
    size: LhCheckboxSize,
    colors: LhColors,
  ): LhCheckboxAppearance {
    let dimension: number
    switch (size) {
      case LhCheckboxSize.Small:
        dimension = LhTokens.Checkbox.Size.small
        break
      case LhCheckboxSize.Medium:
        dimension = LhTokens.Checkbox.Size.medium
        break
      case LhCheckboxSize.Large:
        dimension = LhTokens.Checkbox.Size.large
        break
    }

    const active = checked || indeterminate
    const enabled = !disabled

    // 指示符形态：选中画勾，不确定画横杠，未选中无指示符
    const mark = indeterminate ? LhCheckboxMark.Dash : (checked ? LhCheckboxMark.Check : LhCheckboxMark.None)

    let container: ResourceColor
    let markColor: ResourceColor
    let border: ResourceColor
    let label: ResourceColor
    if (disabled) {
      // disabled：底/边/指示符/文字全部取 disabled.* 令牌
      container = colors.disabledBg
      markColor = colors.disabledText
      border = colors.disabledBorder
      label = colors.textDisabled
    } else if (active) {
      container = colors.primary
      markColor = colors.onPrimary
      border = colors.primary
      label = colors.textPrimary
    } else {
      // 未选中：只描边，无填充
      container = Color.Transparent
      markColor = colors.onPrimary
      border = colors.borderBase
      label = colors.textPrimary
    }

    return {
      size: dimension,
      borderRadius: LhTokens.Checkbox.borderRadius,
      borderWidth: LhTokens.Checkbox.borderWidth,
      checkWidth: LhTokens.Checkbox.checkWidth,
      containerColor: container,
      markColor: markColor,
      borderColor: border,
      labelColor: label,
      gap: LhTokens.Checkbox.gap,
      mark: mark,
      enabled: enabled,
    }
  }

  /**
   * 点击后的新选中态（状态机，黄金用例的断言入口）：
   * indeterminate 变为选中，否则翻转选中态。
   */
  static nextChecked(checked: boolean, indeterminate: boolean): boolean {
    if (indeterminate) {
      return true
    }
    return !checked
  }
}
