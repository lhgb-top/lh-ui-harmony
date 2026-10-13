import { LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'

/**
 * 选择器外观解析结果。由 LhPickerTokens.resolve 纯函数产出，组件只负责把它画出来。
 */
export interface LhPickerAppearance {
  /** 面板高度（picker.height） */
  height: number
  /** 候选项高度（picker.itemHeight） */
  itemHeight: number
  /** 顶部工具栏高度（picker.toolbarHeight） */
  toolbarHeight: number
  /** 候选项字号（picker.itemFontSize） */
  itemFontSize: number
  /** 面板顶部圆角（picker.borderRadius） */
  borderRadius: number
  /** 面板底色（color.background.default） */
  containerColor: ResourceColor
  /** 遮罩色（color.background.overlay） */
  overlayColor: ResourceColor
  /** 标题色（color.text.primary） */
  titleColor: ResourceColor
  /** 取消按钮色（color.text.secondary） */
  cancelColor: ResourceColor
  /** 确认按钮色（color.primary.default） */
  confirmColor: ResourceColor
  /** 中央指示器线色（color.border.lighter） */
  indicatorColor: ResourceColor
  /** 滚轮区高度 = 面板高度 - 工具栏高度 */
  wheelHeight: number
  /** 层级：遮罩取 zIndex.modalBackdrop，面板取 zIndex.modal */
  zIndexBackdrop: number
  zIndexModal: number
  /** 钳制后的选中索引（负数取 0，越界取最后一项） */
  selectedIndex: number
}

/**
 * 选择器令牌绑定与外观解析（纯函数，无组件依赖）。
 *
 * 令牌映射严格对齐 `lh-ui-core/specs/picker.json` 的 behaviors：
 * - 面板高度 picker.height，从底部弹出，顶部圆角 picker.borderRadius，底色 color.background.default
 * - 工具栏高度 picker.toolbarHeight：左取消、中标题、右确认
 * - 候选项高度 picker.itemHeight、字号 picker.itemFontSize；中央指示器为两条水平线
 *   （color.border.lighter），间距 = picker.itemHeight
 * - 遮罩取 color.background.overlay，层级取 zIndex.modal / zIndex.modalBackdrop
 * - value 越界时钳制：负数取 0，大于候选项数 - 1 取最后一项
 */
export class LhPickerTokens {
  /** 解析选择器外观（黄金用例的断言入口） */
  static resolve(
    optionCount: number,
    value: number,
    colors: LhColors,
  ): LhPickerAppearance {
    return {
      height: LhTokens.Picker.height,
      itemHeight: LhTokens.Picker.itemHeight,
      toolbarHeight: LhTokens.Picker.toolbarHeight,
      itemFontSize: LhTokens.Picker.itemFontSize,
      borderRadius: LhTokens.Picker.borderRadius,
      containerColor: colors.backgroundDefault,
      overlayColor: colors.backgroundOverlay,
      titleColor: colors.textPrimary,
      cancelColor: colors.textSecondary,
      confirmColor: colors.primary,
      indicatorColor: colors.borderLighter,
      wheelHeight: LhTokens.Picker.height - LhTokens.Picker.toolbarHeight,
      zIndexBackdrop: LhTokens.ZIndex.modalBackdrop,
      zIndexModal: LhTokens.ZIndex.modal,
      // value 越界钳制：负数取 0，大于候选项数 - 1 取最后一项
      selectedIndex: LhPickerTokens.clampIndex(value, optionCount),
    }
  }

  /** 索引钳制：负数取 0，越界取最后一项；无候选项时为 0 */
  static clampIndex(value: number, optionCount: number): number {
    if (optionCount <= 0) {
      return 0
    }
    if (value < 0) {
      return 0
    }
    if (value > optionCount - 1) {
      return optionCount - 1
    }
    return value
  }
}
