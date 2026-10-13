import { LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'
import { LhButtonType } from '../button/LhButtonTokens'

/**
 * 对话框语义类型。枚举值与 `lh-ui-core/specs/dialog.json` 的 prop `type` 逐字对齐（R-n5）。
 *
 * 决定确认按钮的类型（颜色）。
 */
export enum LhDialogType {
  Default = 'default',
  Primary = 'primary',
  Success = 'success',
  Warning = 'warning',
  Danger = 'danger',
  Info = 'info',
}

/**
 * 对话框外观解析结果。由 LhDialogTokens.resolve 纯函数产出，组件只负责把它画出来。
 */
export interface LhDialogAppearance {
  /** 内容卡宽度（dialog.width） */
  width: number
  borderRadius: number
  paddingHorizontal: number
  paddingVertical: number
  titleFontSize: number
  contentFontSize: number
  /** 标题与内容的间距（dialog.gap） */
  gap: number
  /** 遮罩色（color.background.overlay） */
  overlayColor: ResourceColor
  /** 内容卡底色（color.background.default） */
  containerColor: ResourceColor
  titleColor: ResourceColor
  contentColor: ResourceColor
  /** 确认按钮类型（按 type 映射语义色） */
  confirmButtonType: LhButtonType
  /** 层级：遮罩取 zIndex.modalBackdrop，内容卡取 zIndex.modal */
  zIndexBackdrop: number
  zIndexModal: number
}

/**
 * 对话框令牌绑定与外观解析（纯函数，无组件依赖）。
 *
 * 令牌映射严格对齐 `lh-ui-core/specs/dialog.json` 的 behaviors：
 * - 内容卡宽度 dialog.width、圆角 dialog.borderRadius、内边距 dialog.padding*，
 *   底色 color.background.default，投影 shadow.base
 * - 遮罩取 color.background.overlay
 * - 标题取 dialog.titleFontSize + color.text.primary，内容取 dialog.contentFontSize + color.text.regular
 * - 确认按钮按 type 映射语义色；取消按钮固定 default 类型
 * - 层级取 zIndex.modal（遮罩 zIndex.modalBackdrop）
 */
export class LhDialogTokens {
  /** 解析对话框外观（黄金用例的断言入口） */
  static resolve(type: LhDialogType, colors: LhColors): LhDialogAppearance {
    // dialog.type → 确认按钮的 button.type（语义色映射）
    let confirmType: LhButtonType
    switch (type) {
      case LhDialogType.Default:
        confirmType = LhButtonType.Default
        break
      case LhDialogType.Primary:
        confirmType = LhButtonType.Primary
        break
      case LhDialogType.Success:
        confirmType = LhButtonType.Success
        break
      case LhDialogType.Warning:
        confirmType = LhButtonType.Warning
        break
      case LhDialogType.Danger:
        confirmType = LhButtonType.Danger
        break
      case LhDialogType.Info:
        confirmType = LhButtonType.Info
        break
    }

    return {
      width: LhTokens.Dialog.width,
      borderRadius: LhTokens.Dialog.borderRadius,
      paddingHorizontal: LhTokens.Dialog.paddingHorizontal,
      paddingVertical: LhTokens.Dialog.paddingVertical,
      titleFontSize: LhTokens.Dialog.titleFontSize,
      contentFontSize: LhTokens.Dialog.contentFontSize,
      gap: LhTokens.Dialog.gap,
      overlayColor: colors.backgroundOverlay,
      containerColor: colors.backgroundDefault,
      titleColor: colors.textPrimary,
      contentColor: colors.textRegular,
      confirmButtonType: confirmType,
      zIndexBackdrop: LhTokens.ZIndex.modalBackdrop,
      zIndexModal: LhTokens.ZIndex.modal,
    }
  }
}
