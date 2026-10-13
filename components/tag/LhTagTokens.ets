import { LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'

/**
 * 标签语义类型。枚举值与 `lh-ui-core/specs/tag.json` 的 prop `type` 逐字对齐（R-n5）。
 *
 * 决定底色、文字色与描边色；plain 形态下取对应语义浅底 + 语义字 + 语义描边。
 */
export enum LhTagType {
  Default = 'default',
  Primary = 'primary',
  Success = 'success',
  Warning = 'warning',
  Danger = 'danger',
  Info = 'info',
}

/**
 * 标签尺寸。枚举值与 spec 的 prop `size` 逐字对齐。
 *
 * 映射到 tag.height / paddingHorizontal / fontSize 令牌。
 */
export enum LhTagSize {
  Small = 'small',
  Medium = 'medium',
  Large = 'large',
}

/**
 * 标签外观解析结果。由 LhTagTokens.resolve 纯函数产出，组件只负责把它画出来。
 */
export interface LhTagAppearance {
  height: number
  paddingHorizontal: number
  fontSize: number
  /** 圆角；round 为 true 时取高度一半（胶囊），否则取 tag.borderRadius */
  borderRadius: number
  borderWidth: number
  containerColor: ResourceColor
  contentColor: ResourceColor
  borderColor: ResourceColor
  /** 关闭符与文字的间距（spacing.xs）；closable 为 false 时无意义 */
  closeGap: number
}

/**
 * 标签令牌绑定与外观解析（纯函数，无组件依赖）。
 *
 * 令牌映射严格对齐 `lh-ui-core/specs/tag.json` 的 behaviors：
 * - size 映射：small/medium/large 分别取 tag.height.<size> 等尺寸令牌
 * - plain 为 false 时：default 取 backgroundDefault 底 + textPrimary 字 + borderBase 描边；
 *   其余类型取语义色实心底 + onPrimary 字、无描边
 * - plain 为 true 时：default 同上；其余类型取语义 bg 浅底 + 语义 default 字 + 语义 default 描边
 * - round 为 true 时圆角取高度一半，否则取 tag.borderRadius
 * - 关闭符与文字间距取 spacing.xs
 */
export class LhTagTokens {
  /** 解析标签外观（黄金用例的断言入口） */
  static resolve(
    type: LhTagType,
    size: LhTagSize,
    plain: boolean,
    round: boolean,
    colors: LhColors,
  ): LhTagAppearance {
    let height: number
    let paddingHorizontal: number
    let fontSize: number
    switch (size) {
      case LhTagSize.Small:
        height = LhTokens.Tag.Height.small
        paddingHorizontal = LhTokens.Tag.PaddingHorizontal.small
        fontSize = LhTokens.Tag.FontSize.small
        break
      case LhTagSize.Medium:
        height = LhTokens.Tag.Height.medium
        paddingHorizontal = LhTokens.Tag.PaddingHorizontal.medium
        fontSize = LhTokens.Tag.FontSize.medium
        break
      case LhTagSize.Large:
        height = LhTokens.Tag.Height.large
        paddingHorizontal = LhTokens.Tag.PaddingHorizontal.large
        fontSize = LhTokens.Tag.FontSize.large
        break
    }

    // type → 底色 / 文字色 / 描边色
    let container: ResourceColor
    let content: ResourceColor
    let border: ResourceColor
    if (type === LhTagType.Default) {
      // default 类型两种形态一致：中性底 + 主文字 + 基础描边
      container = colors.backgroundDefault
      content = colors.textPrimary
      border = colors.borderBase
    } else if (plain) {
      // 浅底形态：语义 bg 浅底 + 语义 default 字 + 语义 default 描边
      switch (type) {
        case LhTagType.Primary:
          container = colors.primaryBg
          content = colors.primary
          border = colors.primary
          break
        case LhTagType.Success:
          container = colors.successBg
          content = colors.success
          border = colors.success
          break
        case LhTagType.Warning:
          container = colors.warningBg
          content = colors.warning
          border = colors.warning
          break
        case LhTagType.Danger:
          container = colors.dangerBg
          content = colors.danger
          border = colors.danger
          break
        case LhTagType.Info:
          container = colors.infoBg
          content = colors.info
          border = colors.info
          break
        default:
          container = colors.backgroundDefault
          content = colors.textPrimary
          border = colors.borderBase
          break
      }
    } else {
      // 实心底形态：语义色实心底 + onPrimary 字、无描边
      switch (type) {
        case LhTagType.Primary:
          container = colors.primary
          content = colors.onPrimary
          border = Color.Transparent
          break
        case LhTagType.Success:
          container = colors.success
          content = colors.onPrimary
          border = Color.Transparent
          break
        case LhTagType.Warning:
          container = colors.warning
          content = colors.onPrimary
          border = Color.Transparent
          break
        case LhTagType.Danger:
          container = colors.danger
          content = colors.onPrimary
          border = Color.Transparent
          break
        case LhTagType.Info:
          container = colors.info
          content = colors.onPrimary
          border = Color.Transparent
          break
        default:
          container = colors.backgroundDefault
          content = colors.textPrimary
          border = colors.borderBase
          break
      }
    }

    return {
      height: height,
      paddingHorizontal: paddingHorizontal,
      fontSize: fontSize,
      // round 为 true 时圆角取高度一半（胶囊），否则取标签圆角令牌
      borderRadius: round ? height / 2 : LhTokens.Tag.borderRadius,
      borderWidth: LhTokens.Tag.borderWidth,
      containerColor: container,
      contentColor: content,
      borderColor: border,
      closeGap: LhTokens.Spacing.xs,
    }
  }
}
