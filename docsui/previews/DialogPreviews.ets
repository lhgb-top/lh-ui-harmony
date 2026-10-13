/**
 * Dialog 文档页的真交互预览（对应 `docs/components/dialog.md` 的 `##` 分节）。
 *
 * 声明式可见性：visible 由预览自身的 @State 持有，确认/取消后 onClose 回写 false。
 * 浮层挂在预览框自身的 Stack 内（以预览框为边界），作为 Stack 的最后子节点。
 */
import { LhDialog } from '../../components/dialog/Index'
import { LhDialogType } from '../../components/dialog/LhDialogTokens'
import { LhButton } from '../../components/button/Index'
import { LhButtonType } from '../../components/button/LhButtonTokens'
import { LhToastController } from '../../components/toast/Index'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocPreviewFrame, DocProse } from '../widgets/DocWidgets'

/** 基本用法：确认 / 取消 / 遮罩点击三条关闭路径。 */
@Component
export struct DialogBasicPreview {
  toast: LhToastController = new LhToastController()
  @State visible: boolean = false

  build() {
    DocPreviewFrame({ title: '点击按钮打开对话框（closable 允许点遮罩关闭）' }) {
      Stack() {
        Column({ space: lhVp(LhTokens.Spacing.sm) }) {
          LhButton({
            onClick: () => this.visible = true,
            type: LhButtonType.Primary,
            text: '打开对话框',
          })
          DocProse({ text: '确认触发 onConfirm 并关闭；取消与遮罩点击只触发 onClose。', secondary: true })
        }
        .alignItems(HorizontalAlign.Start)

        LhDialog({
          visible: this.visible,
          title: '删除确认',
          content: '删除后不可恢复，确定要删除这条记录吗？',
          type: LhDialogType.Warning,
          closable: true,
          onConfirm: () => {
            this.visible = false
            this.toast.show('onConfirm：已删除')
          },
          onClose: () => {
            this.visible = false
          },
        })
      }
    }
  }
}

/** 类型：六种语义类型改变确认按钮的底色。 */
@Component
export struct DialogTypesPreview {
  toast: LhToastController = new LhToastController()
  @State visible: boolean = false
  @State type: LhDialogType = LhDialogType.Default

  private open(type: LhDialogType): void {
    this.type = type
    this.visible = true
  }

  build() {
    DocPreviewFrame({ title: '六种类型切换确认按钮底色（点击打开对应类型）' }) {
      Stack() {
        Column({ space: lhVp(LhTokens.Spacing.sm) }) {
          Row({ space: lhVp(LhTokens.Spacing.sm) }) {
            LhButton({ onClick: () => this.open(LhDialogType.Default), text: '默认' })
            LhButton({ onClick: () => this.open(LhDialogType.Primary), type: LhButtonType.Primary, text: '主要' })
          }
          Row({ space: lhVp(LhTokens.Spacing.sm) }) {
            LhButton({ onClick: () => this.open(LhDialogType.Success), type: LhButtonType.Success, text: '成功' })
            LhButton({ onClick: () => this.open(LhDialogType.Warning), type: LhButtonType.Warning, text: '警告' })
          }
          Row({ space: lhVp(LhTokens.Spacing.sm) }) {
            LhButton({ onClick: () => this.open(LhDialogType.Danger), type: LhButtonType.Danger, text: '危险' })
            LhButton({ onClick: () => this.open(LhDialogType.Info), type: LhButtonType.Info, text: '信息' })
          }
        }
        .alignItems(HorizontalAlign.Start)

        LhDialog({
          visible: this.visible,
          title: '类型演示',
          content: '当前类型决定确认按钮的语义底色。',
          type: this.type,
          confirmText: '确认',
          cancelText: '取消',
          onConfirm: () => {
            this.visible = false
            this.toast.show(`onConfirm：${this.type} 类型`)
          },
          onClose: () => {
            this.visible = false
          },
        })
      }
    }
  }
}
