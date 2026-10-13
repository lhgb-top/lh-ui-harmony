import { LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'

/**
 * 开关尺寸。枚举值与 `lh-ui-core/specs/switch.json` 的 prop `size` 逐字对齐（R-n5）。
 *
 * 映射到 switch.width / switch.height 令牌。
 */
export enum LhSwitchSize {
  Small = 'small',
  Medium = 'medium',
  Large = 'large',
}

/**
 * 开关外观解析结果。由 LhSwitchTokens.resolve 纯函数产出，组件只负责把它画出来。
 */
export interface LhSwitchAppearance {
  width: number
  height: number
  /** 滑块与轨道之间的留白（switch.gap） */
  gap: number
  /** 滑块直径 = 高度 - 2 × gap */
  thumbSize: number
  /** 轨道圆角（胶囊，取高度一半） */
  borderRadius: number
  /** 轨道色：开启 primary，关闭 border.base，禁用 disabled.bg */
  trackColor: ResourceColor
  /** 滑块色：取 color.onPrimary；禁用时取 color.text.disabled */
  thumbColor: ResourceColor
  /** 加载环色（主色） */
  loadingColor: ResourceColor
  /** 滑块在轨道内的水平偏移（关闭贴左、开启贴右） */
  thumbOffset: number
  enabled: boolean
}

/**
 * 开关令牌绑定与外观解析（纯函数，无组件依赖）。
 *
 * 令牌映射严格对齐 `lh-ui-core/specs/switch.json` 的 behaviors：
 * - size 映射：small/medium/large 分别取 switch.width.<size> 与 switch.height.<size> 令牌
 * - 轨道为胶囊（圆角取高度一半）：开启取 color.primary.default，关闭取 color.border.base，禁用取 color.disabled.bg
 * - 滑块为圆形（直径 = 高度 - 2 × switch.gap），取 color.onPrimary；禁用时取 color.text.disabled
 * - loading 为 true 时滑块位置改画加载环（主色），且不响应点击
 */
export class LhSwitchTokens {
  /** 解析开关外观（黄金用例的断言入口） */
  static resolve(
    checked: boolean,
    disabled: boolean,
    loading: boolean,
    size: LhSwitchSize,
    colors: LhColors,
  ): LhSwitchAppearance {
    let width: number
    let height: number
    switch (size) {
      case LhSwitchSize.Small:
        width = LhTokens.Switch.Width.small
        height = LhTokens.Switch.Height.small
        break
      case LhSwitchSize.Medium:
        width = LhTokens.Switch.Width.medium
        height = LhTokens.Switch.Height.medium
        break
      case LhSwitchSize.Large:
        width = LhTokens.Switch.Width.large
        height = LhTokens.Switch.Height.large
        break
    }

    // 状态 gate：disabled 或 loading 为 true 时不可交互
    const enabled = !disabled && !loading

    let track: ResourceColor
    let thumb: ResourceColor
    if (disabled) {
      track = colors.disabledBg
      thumb = colors.textDisabled
    } else if (checked) {
      track = colors.primary
      thumb = colors.onPrimary
    } else {
      track = colors.borderBase
      thumb = colors.onPrimary
    }

    const thumbSize = height - 2 * LhTokens.Switch.gap

    return {
      width: width,
      height: height,
      gap: LhTokens.Switch.gap,
      thumbSize: thumbSize,
      // 胶囊轨道：圆角取高度一半
      borderRadius: height / 2,
      trackColor: track,
      thumbColor: thumb,
      loadingColor: colors.primary,
      // 滑块水平偏移：关闭贴左、开启贴右
      thumbOffset: checked ? width - thumbSize - LhTokens.Switch.gap : LhTokens.Switch.gap,
      enabled: enabled,
    }
  }
}
