import { LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'

/**
 * 图标尺寸。枚举值与 `lh-ui-core/specs/icon.json` 的 prop `size` 逐字对齐（R-n5）。
 *
 * 映射到 icon.size.* 尺寸令牌。
 */
export enum LhIconSize {
  Small = 'small',
  Medium = 'medium',
  Large = 'large',
}

/**
 * 图标色调。枚举值与 spec 的 prop `tone` 逐字对齐。
 *
 * - default 取主要文字色
 * - primary/success/warning/danger/info 取对应语义色
 * - regular/secondary 取对应文字色
 */
export enum LhIconTone {
  Default = 'default',
  Primary = 'primary',
  Success = 'success',
  Warning = 'warning',
  Danger = 'danger',
  Info = 'info',
  Regular = 'regular',
  Secondary = 'secondary',
}

/**
 * 图标外观解析结果。由 LhIconTokens.resolve 纯函数产出，组件只负责把它画出来。
 *
 * glyph 是「绘制指令为 draw_icon」的端侧落点：鸿蒙端把图标名映射为 unicode 字形、
 * 用 Text 渲染（与 button 的 Text('◆') 占位策略一致）。生产环境应换 SymbolGlyph /
 * 矢量资产，此处保持务实占位。
 */
export interface LhIconAppearance {
  /** 图标盒尺寸（vp） */
  size: number
  /** 字形颜色 */
  color: ResourceColor
  /** 实际渲染的 unicode 字形；未登记名回退 ◆ */
  glyph: string
}

/**
 * 图标令牌绑定与外观解析（纯函数，无组件依赖）。
 *
 * 令牌映射严格对齐 `lh-ui-core/specs/icon.json` 的 behaviors：
 * - size 映射：small/medium/large 分别取 icon.size.<size> 尺寸令牌
 * - tone 映射：default 取 color.text.primary；语义色取对应 default；regular/secondary 取对应文字色
 * - 图标名经 glyphFor 映射为本地字形，未登记名回退 ◆
 */
export class LhIconTokens {
  /** 解析图标外观（黄金用例的断言入口） */
  static resolve(
    size: LhIconSize,
    tone: LhIconTone,
    name: string,
    colors: LhColors,
  ): LhIconAppearance {
    let dimension: number
    switch (size) {
      case LhIconSize.Small:
        dimension = LhTokens.Icon.Size.small
        break
      case LhIconSize.Medium:
        dimension = LhTokens.Icon.Size.medium
        break
      case LhIconSize.Large:
        dimension = LhTokens.Icon.Size.large
        break
    }

    let color: ResourceColor
    switch (tone) {
      case LhIconTone.Default:
        color = colors.textPrimary
        break
      case LhIconTone.Primary:
        color = colors.primary
        break
      case LhIconTone.Success:
        color = colors.success
        break
      case LhIconTone.Warning:
        color = colors.warning
        break
      case LhIconTone.Danger:
        color = colors.danger
        break
      case LhIconTone.Info:
        color = colors.info
        break
      case LhIconTone.Regular:
        color = colors.textRegular
        break
      case LhIconTone.Secondary:
        color = colors.textSecondary
        break
    }

    return {
      size: dimension,
      color: color,
      glyph: LhIconTokens.glyphFor(name),
    }
  }

  /**
   * 图标名 → unicode 字形（端侧落点）。
   *
   * spec 描述「各端按本地图标体系解析并渲染」：鸿蒙端把常用图标名映射为 unicode
   * 字形、以 Text 渲染（颜色走 tone 令牌）。未登记的图标名回退 ◆，不崩溃。
   * 生产环境应换 SymbolGlyph / 矢量资产。
   */
  static glyphFor(name: string): string {
    const glyphs: Record<string, string> = {
      'search': '⌕',
      'refresh': '↻',
      'check': '✓',
      'close': '✕',
      'warning': '⚠',
      'info': 'ℹ',
      'back': '←',
      'more': '⋯',
      'star': '★',
      'edit': '✎',
      'delete': '⌫',
      'plus': '＋',
      'minus': '－',
      'arrow': '→',
    }
    const glyph = glyphs[name]
    if (glyph === undefined) {
      return '◆'
    }
    return glyph
  }
}
