import { LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'

/**
 * 导航栏外观解析结果。由 LhNavbarTokens.resolve 纯函数产出，组件只负责把它画出来。
 */
export interface LhNavbarAppearance {
  /** 高度（navbar.height） */
  height: number
  /** 左右内边距（navbar.paddingHorizontal） */
  paddingHorizontal: number
  /** 标题字号（navbar.titleFontSize） */
  titleFontSize: number
  /** 左右图标尺寸（navbar.iconSize） */
  iconSize: number
  /** 底部分隔线宽（navbar.borderWidth）；bordered 为 false 时为 0 */
  borderWidth: number
  /** 底色（color.background.default） */
  containerColor: ResourceColor
  /** 标题与两侧文字色（color.text.primary） */
  titleColor: ResourceColor
  /** 底部分隔线色（color.border.lighter）；bordered 为 false 时为 undefined */
  dividerColor?: ResourceColor
  /** 层级（zIndex.sticky） */
  zIndex: number
}

/**
 * 导航栏令牌绑定与外观解析（纯函数，无组件依赖）。
 *
 * 令牌映射严格对齐 `lh-ui-core/specs/navbar.json` 的 behaviors：
 * - 高度 navbar.height，左右内边距 navbar.paddingHorizontal，底色 color.background.default
 * - 标题取 navbar.titleFontSize + color.text.primary，水平居中于可用宽度
 * - 左侧文字取 color.text.primary，图标尺寸 navbar.iconSize；右侧同之
 * - bordered 为 true 时底部绘制分隔线（color.border.lighter，宽 navbar.borderWidth）
 * - 层级取 zIndex.sticky，宿主将其作为页面顶部固定栏
 */
export class LhNavbarTokens {
  /** 解析导航栏外观（黄金用例的断言入口） */
  static resolve(bordered: boolean, colors: LhColors): LhNavbarAppearance {
    return {
      height: LhTokens.Navbar.height,
      paddingHorizontal: LhTokens.Navbar.paddingHorizontal,
      titleFontSize: LhTokens.Navbar.titleFontSize,
      iconSize: LhTokens.Navbar.iconSize,
      borderWidth: bordered ? LhTokens.Navbar.borderWidth : 0,
      containerColor: colors.backgroundDefault,
      titleColor: colors.textPrimary,
      dividerColor: bordered ? colors.borderLighter : undefined,
      zIndex: LhTokens.ZIndex.sticky,
    }
  }
}
