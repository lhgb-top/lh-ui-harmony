import { LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'

/**
 * 单选框尺寸。枚举值与 `lh-ui-core/specs/radio.json` 的 prop `size` 逐字对齐（R-n5）。
 *
 * 映射到 radio.size.* 圆环尺寸令牌。
 */
export enum LhRadioSize {
  Small = 'small',
  Medium = 'medium',
  Large = 'large',
}

/**
 * 单选框外观解析结果。由 LhRadioTokens.resolve 纯函数产出，组件只负责把它画出来。
 */
export interface LhRadioAppearance {
  /** 圆环尺寸（vp） */
  size: number
  /** 外环描边宽度（radio.ringWidth） */
  ringWidth: number
  /** 内圆点直径 = 尺寸 × radio.dotScale */
  dotSize: number
  /** 外环描边色：未选中 border.base，选中 primary */
  ringColor: ResourceColor
  /** 内圆点色：选中为 primary，未选中无圆点 */
  dotColor: ResourceColor
  /** 文字标签色（disabled 时取 color.text.disabled） */
  labelColor: ResourceColor
  /** 圆环与文字间距（radio.gap） */
  gap: number
  /** 是否绘制内圆点 */
  showDot: boolean
  enabled: boolean
}

/**
 * 单选框令牌绑定与外观解析（纯函数，无组件依赖）。
 *
 * 令牌映射严格对齐 `lh-ui-core/specs/radio.json` 的 behaviors：
 * - size 映射：small/medium/large 分别取 radio.size.<size> 圆环尺寸令牌
 * - 外环描边：未选中取 color.border.base，选中取 color.primary.default，描边宽 radio.ringWidth
 * - 选中时内部画实心圆点，直径 = 尺寸 × radio.dotScale，取 color.primary.default
 * - disabled：外环取 color.disabled.border，圆点取 color.disabled.text，文字取 color.text.disabled
 * - 点击命中整个行：仅当未选中且未禁用时变为选中并触发 onChange(checked=true)
 */
export class LhRadioTokens {
  /** 解析单选框外观（黄金用例的断言入口） */
  static resolve(
    checked: boolean,
    disabled: boolean,
    size: LhRadioSize,
    colors: LhColors,
  ): LhRadioAppearance {
    let dimension: number
    switch (size) {
      case LhRadioSize.Small:
        dimension = LhTokens.Radio.Size.small
        break
      case LhRadioSize.Medium:
        dimension = LhTokens.Radio.Size.medium
        break
      case LhRadioSize.Large:
        dimension = LhTokens.Radio.Size.large
        break
    }

    const enabled = !disabled

    let ring: ResourceColor
    let dot: ResourceColor
    let label: ResourceColor
    if (disabled) {
      ring = colors.disabledBorder
      dot = colors.disabledText
      label = colors.textDisabled
    } else if (checked) {
      ring = colors.primary
      dot = colors.primary
      label = colors.textPrimary
    } else {
      ring = colors.borderBase
      dot = colors.primary
      label = colors.textPrimary
    }

    return {
      size: dimension,
      ringWidth: LhTokens.Radio.ringWidth,
      // 内圆点直径 = 尺寸 × radio.dotScale（dotScale 是分数）
      dotSize: dimension * LhTokens.Radio.dotScale,
      ringColor: ring,
      dotColor: dot,
      labelColor: label,
      gap: LhTokens.Radio.gap,
      showDot: checked && !disabled,
      enabled: enabled,
    }
  }
}
