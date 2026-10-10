import { LhColors, LightLhColors, DarkLhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'

/**
 * 按钮类型。枚举值与 `lh-ui-core/specs/button.json` 的 prop `type` 逐字对齐（R-n5）。
 *
 * 决定底色与文字色：primary 取主色底 + onPrimary 文字；其余类型取对应语义色。
 */
export enum LhButtonType {
  Default = 'default',
  Primary = 'primary',
  Success = 'success',
  Warning = 'warning',
  Danger = 'danger',
  Info = 'info',
}

/**
 * 按钮尺寸。枚举值与 spec 的 prop `size` 逐字对齐。
 *
 * 映射到 button.height / paddingHorizontal / fontSize / iconSize 令牌。
 */
export enum LhButtonSize {
  Small = 'small',
  Medium = 'medium',
  Large = 'large',
}

/**
 * 按钮外观解析结果：尺寸 + 颜色 + 状态。由 LhButtonTokens.resolve 纯函数产出，
 * 组件只负责把它画出来。分离解析与渲染，是为了让黄金用例（cases/button.json）
 * 能在 hypium 单测里断言「type/size/disabled → 令牌」的映射。
 */
export interface LhButtonAppearance {
  height: number
  paddingHorizontal: number
  fontSize: number
  iconSize: number
  containerColor: ResourceColor
  contentColor: ResourceColor
  borderColor: ResourceColor
  borderWidth: number
  borderRadius: number
  /** 花纹底纹色；bgPattern=false 时为 undefined（不绘制底纹） */
  patternColor?: ResourceColor
  /** 是否可交互（disabled 与 loading 任一为 true 即不可交互，disabled 优先） */
  enabled: boolean
}

/**
 * 按钮令牌绑定与外观解析（纯函数，无组件依赖）。
 *
 * 令牌映射严格对齐 `lh-ui-core/specs/button.json` 的 behaviors：
 * - disabled 为 true 时：呈现禁用样式（disabled.* 令牌），不触发 onClick
 * - loading 为 true 时：显示加载指示器，不触发 onClick
 * - disabled 与 loading 同时为 true 时按 disabled 优先处理
 * - size 映射：small/medium/large 分别取 button.height.<size> 等尺寸令牌
 * - type 映射：primary 取主色底 + onPrimary 文字；其余类型取对应语义色
 * - bgPattern 为 true 时以 color.decoration 绘制底纹，不影响文字对比度
 */
export class LhButtonTokens {
  /** 解析按钮外观（黄金用例的断言入口） */
  static resolve(
    type: LhButtonType,
    size: LhButtonSize,
    disabled: boolean,
    loading: boolean,
    bgPattern: boolean,
    colors: LhColors,
  ): LhButtonAppearance {
    // 状态 gate：disabled 优先于 loading（黄金用例 disabled-precedes-loading）
    const enabled = !disabled && !loading

    // type → 底色 / 文字色 / 描边色（禁用态覆盖）
    let container: ResourceColor
    let content: ResourceColor
    let border: ResourceColor
    if (!enabled) {
      container = colors.disabledBg
      content = colors.disabledText
      border = colors.disabledBorder
    } else {
      switch (type) {
        case LhButtonType.Default:
          container = colors.backgroundDefault
          content = colors.textPrimary
          border = colors.borderBase
          break
        case LhButtonType.Primary:
          container = colors.primary
          content = colors.onPrimary
          border = Color.Transparent
          break
        case LhButtonType.Success:
          container = colors.success
          content = colors.onPrimary
          border = Color.Transparent
          break
        case LhButtonType.Warning:
          container = colors.warning
          content = colors.onPrimary
          border = Color.Transparent
          break
        case LhButtonType.Danger:
          container = colors.danger
          content = colors.onPrimary
          border = Color.Transparent
          break
        case LhButtonType.Info:
          container = colors.info
          content = colors.onPrimary
          border = Color.Transparent
          break
      }
    }

    // size → 尺寸令牌（vp 数值）
    let height: number
    let paddingHorizontal: number
    let fontSize: number
    let iconSize: number
    switch (size) {
      case LhButtonSize.Small:
        height = LhTokens.Button.Height.small
        paddingHorizontal = LhTokens.Button.PaddingHorizontal.small
        fontSize = LhTokens.Button.FontSize.small
        iconSize = LhTokens.Button.IconSize.small
        break
      case LhButtonSize.Medium:
        height = LhTokens.Button.Height.medium
        paddingHorizontal = LhTokens.Button.PaddingHorizontal.medium
        fontSize = LhTokens.Button.FontSize.medium
        iconSize = LhTokens.Button.IconSize.medium
        break
      case LhButtonSize.Large:
        height = LhTokens.Button.Height.large
        paddingHorizontal = LhTokens.Button.PaddingHorizontal.large
        fontSize = LhTokens.Button.FontSize.large
        iconSize = LhTokens.Button.IconSize.large
        break
    }

    return {
      height: height,
      paddingHorizontal: paddingHorizontal,
      fontSize: fontSize,
      iconSize: iconSize,
      containerColor: container,
      contentColor: content,
      borderColor: border,
      borderWidth: LhTokens.Button.borderWidth,
      borderRadius: LhTokens.Button.borderRadius,
      patternColor: bgPattern ? colors.decoration : undefined,
      enabled: enabled,
    }
  }

  /** 图标名 → HarmonyOS SymbolGlyph 名的本地映射（spec：icon 是图标名，各端按本地图标体系渲染）。
   * 未登记的图标名返回 undefined（不绘制），不崩溃。 */
  static iconFor(name?: string): string | undefined {
    if (name === undefined) {
      return undefined
    }
    const symbols: Record<string, string> = {
      'search': 'ohos_search',
      'refresh': 'ohos_refresh',
      'check': 'ohos_done',
      'close': 'ohos_cancel',
    }
    return symbols[name]
  }
}

/** 便捷取色板（组件 @Consume 拿不到时的兜底） */
export function resolveLhColors(isDark: boolean): LhColors {
  return isDark ? DarkLhColors() : LightLhColors()
}
