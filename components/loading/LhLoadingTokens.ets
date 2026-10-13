import { LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'

/**
 * 加载指示器色调。枚举值与 `lh-ui-core/specs/loading.json` 的 prop `tone` 逐字对齐（R-n5）。
 *
 * 环色取对应语义色令牌。
 */
export enum LhLoadingTone {
  Primary = 'primary',
  Success = 'success',
  Warning = 'warning',
  Danger = 'danger',
  Info = 'info',
}

/**
 * 加载指示器尺寸。枚举值与 spec 的 prop `size` 逐字对齐。
 *
 * 映射到 loading.size.* 直径令牌。
 */
export enum LhLoadingSize {
  Small = 'small',
  Medium = 'medium',
  Large = 'large',
}

/**
 * 加载指示器外观解析结果。由 LhLoadingTokens.resolve 纯函数产出，组件只负责把它画出来。
 */
export interface LhLoadingAppearance {
  /** 指示器直径（vp） */
  size: number
  /** 加载环描边宽（loading.strokeWidth） */
  strokeWidth: number
  /** 环色（对应语义色） */
  color: ResourceColor
}

/**
 * 加载指示器令牌绑定与外观解析（纯函数，无组件依赖）。
 *
 * 令牌映射严格对齐 `lh-ui-core/specs/loading.json` 的 behaviors：
 * - size 映射：small/medium/large 分别取 loading.size.<size> 直径令牌
 * - 绘制指令为 draw_ring，半径为尺寸一半，描边宽 loading.strokeWidth
 * - tone 映射：取对应语义色令牌
 *
 * ArkUI 的 LoadingProgress 自带环形旋转动画，故「旋转由后端驱动」在此端直接由
 * 框架动画承担（嵌入式朴素调性：只发几何，动画由平台补齐）。
 */
export class LhLoadingTokens {
  /** 解析加载指示器外观（黄金用例的断言入口） */
  static resolve(
    size: LhLoadingSize,
    tone: LhLoadingTone,
    colors: LhColors,
  ): LhLoadingAppearance {
    let dimension: number
    switch (size) {
      case LhLoadingSize.Small:
        dimension = LhTokens.Loading.Size.small
        break
      case LhLoadingSize.Medium:
        dimension = LhTokens.Loading.Size.medium
        break
      case LhLoadingSize.Large:
        dimension = LhTokens.Loading.Size.large
        break
    }

    let color: ResourceColor
    switch (tone) {
      case LhLoadingTone.Primary:
        color = colors.primary
        break
      case LhLoadingTone.Success:
        color = colors.success
        break
      case LhLoadingTone.Warning:
        color = colors.warning
        break
      case LhLoadingTone.Danger:
        color = colors.danger
        break
      case LhLoadingTone.Info:
        color = colors.info
        break
    }

    return {
      size: dimension,
      strokeWidth: LhTokens.Loading.strokeWidth,
      color: color,
    }
  }
}
