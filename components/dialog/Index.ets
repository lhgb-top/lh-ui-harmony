import { LhDialogType, LhDialogTokens, LhDialogAppearance } from './LhDialogTokens'
import { LH_COLORS_KEY, LightLhColors, LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'
import { LhButton } from '../button/Index'
import { lhVp } from '../../common/LhVp'

/**
 * 对话框组件：模态浮层（ArkUI 手写）。
 *
 * props 与 `lh-ui-core/specs/dialog.json` 逐字对齐；行为遵循 `cases/dialog.json`
 * 的 8 条黄金用例（已翻译为 hypium 测试，见 entry/src/test/Dialog.test.ets）。
 *
 * 声明式可见性：visible 为 false 时不渲染任何内容；确认/取消后触发 onClose，
 * 宿主据此置 visible 为 false（与 react 的 open/onClose 同构）。组件须作为页面
 * Stack 的最后子节点挂载，层级取 zIndex.modal（遮罩 zIndex.modalBackdrop）。
 */
@Component
export struct LhDialog {
  /** 是否显示；为 false 时不渲染任何内容 */
  @Prop visible: boolean = false
  /** 标题 */
  @Prop title: string = ''
  /** 正文内容 */
  @Prop content: string = ''
  /** 语义类型，决定确认按钮的类型（颜色） */
  @Prop @Watch('recompute') type: LhDialogType = LhDialogType.Default
  /** 确认按钮文字；为空时不显示确认按钮 */
  @Prop confirmText: string = '确认'
  /** 取消按钮文字；为空时不显示取消按钮 */
  @Prop cancelText: string = '取消'
  /** 点击遮罩区域是否触发 onClose */
  @Prop closable: boolean = false

  /** 点击确认按钮时触发（回调属性不加 @Prop） */
  onConfirm: () => void = () => {}
  /** 点击取消按钮时触发 */
  onCancel: () => void = () => {}
  /** 确认/取消后或（closable 时）点击遮罩触发，宿主据此置 visible 为 false */
  onClose: () => void = () => {}

  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''

  private appearance: LhDialogAppearance = LhDialogTokens.resolve(LhDialogType.Default, LightLhColors())

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    let colors = LightLhColors()
    if (this.colorsJson !== '') {
      colors = JSON.parse(this.colorsJson) as LhColors
    }
    this.appearance = LhDialogTokens.resolve(this.type, colors)
  }

  build() {
    if (this.visible) {
      Stack() {
        // 遮罩：closable 为 true 时点击触发 onClose，否则吞掉遮罩点击
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(this.appearance.overlayColor)
          .zIndex(this.appearance.zIndexBackdrop)
          .onClick(() => {
            if (this.closable) {
              this.onClose()
            }
          })

        // 内容卡
        Column() {
          if (this.title !== '') {
            Text(this.title)
              .fontSize(lhVp(this.appearance.titleFontSize))
              .fontColor(this.appearance.titleColor)
              .fontWeight(FontWeight.Bold)
              .width('100%')
          }

          if (this.content !== '') {
            Text(this.content)
              .fontSize(lhVp(this.appearance.contentFontSize))
              .fontColor(this.appearance.contentColor)
              .width('100%')
              .margin({ top: lhVp(this.appearance.gap) })
          }

          // 底部按钮区
          if (this.confirmText !== '' || this.cancelText !== '') {
            Row({ space: lhVp(this.appearance.gap) }) {
              if (this.cancelText !== '') {
                // 取消按钮固定 default 类型
                LhButton({
                  onClick: () => {
                    this.onCancel()
                    this.onClose()
                  },
                  type: LhButtonType.Default,
                  text: this.cancelText,
                })
              }
              if (this.confirmText !== '') {
                // 确认按钮按 type 映射语义色
                LhButton({
                  onClick: () => {
                    this.onConfirm()
                    this.onClose()
                  },
                  type: this.appearance.confirmButtonType,
                  text: this.confirmText,
                })
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .margin({ top: lhVp(this.appearance.gap) })
          }
        }
        .width(lhVp(this.appearance.width))
        .padding({
          left: lhVp(this.appearance.paddingHorizontal),
          right: lhVp(this.appearance.paddingHorizontal),
          top: lhVp(this.appearance.paddingVertical),
          bottom: lhVp(this.appearance.paddingVertical),
        })
        .backgroundColor(this.appearance.containerColor)
        .borderRadius(lhVp(this.appearance.borderRadius))
        .zIndex(this.appearance.zIndexModal)
        .shadow({
          radius: LhTokens.Shadow.base.radius,
          color: LhTokens.Shadow.base.color,
          offsetX: LhTokens.Shadow.base.offsetX,
          offsetY: LhTokens.Shadow.base.offsetY,
        })
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Center)
    }
  }
}
