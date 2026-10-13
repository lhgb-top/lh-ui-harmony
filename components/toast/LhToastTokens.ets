import { LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'

/**
 * 轻提示语义类型。枚举值与 `lh-ui-core/specs/toast.json` 的 prop `type` 逐字对齐（R-n5）。
 *
 * 非 default 时在文字前绘制对应语义色圆点。
 */
export enum LhToastType {
  Default = 'default',
  Success = 'success',
  Warning = 'warning',
  Danger = 'danger',
  Info = 'info',
}

/**
 * 轻提示定位。枚举值与 spec 的 prop `position` 逐字对齐。
 *
 * 在可用区域内定位；上下两端留 spacing.xl 边距。
 */
export enum LhToastPosition {
  Top = 'top',
  Center = 'center',
  Bottom = 'bottom',
}

/**
 * 轻提示外观解析结果。由 LhToastTokens.resolve 纯函数产出，组件只负责把它画出来。
 */
export interface LhToastAppearance {
  fontSize: number
  paddingHorizontal: number
  paddingVertical: number
  borderRadius: number
  /** 类型色点与文字的间距（toast.gap） */
  gap: number
  /** 胶囊底色（color.ink） */
  containerColor: ResourceColor
  /** 文字色（color.onPrimary） */
  contentColor: ResourceColor
  /** 类型色点色；type 为 default 时为 undefined（不绘制） */
  dotColor?: ResourceColor
  /** 色点直径（取字号） */
  dotSize: number
  /** 层级（zIndex.toast） */
  zIndex: number
  /** 上下两端留白（spacing.xl） */
  edgeMargin: number
  /** 最大宽度占比（封顶可用宽度的 80%） */
  maxWidthPercent: number
}

/**
 * 轻提示令牌绑定与外观解析（纯函数，无组件依赖）。
 *
 * 令牌映射严格对齐 `lh-ui-core/specs/toast.json` 的 behaviors：
 * - 胶囊底取 color.ink，文字取 color.onPrimary，圆角取 toast.borderRadius
 * - type 非 default 时在文字前绘制直径为字号的语义色圆点，间距取 toast.gap
 * - layout 宽度由文字测量得出并封顶可用宽度的 80%，按 position 定位
 * - 层级取 zIndex.toast，宿主须在其他内容之后最后绘制
 *
 * 计时模型（spec 的 tick/hide）在端侧由 setTimeout 承载：show 重置计时，
 * 到期自动隐藏并触发 onClose；hide 主动隐藏不触发。
 */
export class LhToastTokens {
  /** 解析轻提示外观（黄金用例的断言入口） */
  static resolve(type: LhToastType, colors: LhColors): LhToastAppearance {
    let dotColor: ResourceColor | undefined = undefined
    switch (type) {
      case LhToastType.Success:
        dotColor = colors.success
        break
      case LhToastType.Warning:
        dotColor = colors.warning
        break
      case LhToastType.Danger:
        dotColor = colors.danger
        break
      case LhToastType.Info:
        dotColor = colors.info
        break
      case LhToastType.Default:
        dotColor = undefined
        break
    }

    return {
      fontSize: LhTokens.Toast.fontSize,
      paddingHorizontal: LhTokens.Toast.paddingHorizontal,
      paddingVertical: LhTokens.Toast.paddingVertical,
      borderRadius: LhTokens.Toast.borderRadius,
      gap: LhTokens.Toast.gap,
      containerColor: colors.ink,
      contentColor: colors.onPrimary,
      dotColor: dotColor,
      // type 非 default 时色点直径取字号
      dotSize: LhTokens.Toast.fontSize,
      zIndex: LhTokens.ZIndex.toast,
      edgeMargin: LhTokens.Spacing.xl,
      maxWidthPercent: 80,
    }
  }
}
