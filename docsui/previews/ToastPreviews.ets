/**
 * Toast 文档页的真交互预览（对应 `docs/components/toast.md` 的 `##` 分节）。
 *
 * 指令式组件：本预览自持三个 LhToastController（照 entry demo 的用法），
 * 分别驱动上 / 中 / 下三个位置的 toast；类型与定位的组合即本节全部内容。
 */
import { LhToast } from '../../components/toast/Index'
import { LhToastType, LhToastPosition, LhToastController } from '../../components/toast/Index'
import { LhButton } from '../../components/button/Index'
import { LhButtonType } from '../../components/button/LhButtonTokens'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocPreviewFrame } from '../widgets/DocWidgets'

@Component
export struct ToastTypesAndPositionPreview {
  toast: LhToastController = new LhToastController()
  private toastTop: LhToastController = new LhToastController()
  private toastCenter: LhToastController = new LhToastController()
  private toastBottom: LhToastController = new LhToastController()

  build() {
    DocPreviewFrame({ title: '类型决定语义色圆点；position 决定定位（计时到期自动隐藏）' }) {
      Stack() {
        Column({ space: lhVp(LhTokens.Spacing.sm) }) {
          Row({ space: lhVp(LhTokens.Spacing.sm) }) {
            LhButton({
              onClick: () => this.toastTop.show('顶部 · 成功'),
              type: LhButtonType.Primary,
              text: '顶部成功',
            })
            LhButton({ onClick: () => this.toastCenter.show('中部 · 默认'), text: '中部默认' })
          }
          Row({ space: lhVp(LhTokens.Spacing.sm) }) {
            LhButton({
              onClick: () => this.toastBottom.show('底部 · 危险'),
              type: LhButtonType.Danger,
              text: '底部危险',
            })
            LhButton({
              onClick: () => this.toastCenter.show('中部 · 警告'),
              type: LhButtonType.Warning,
              text: '中部警告',
            })
          }
        }
        .alignItems(HorizontalAlign.Start)

        LhToast({ type: LhToastType.Success, position: LhToastPosition.Top, controller: this.toastTop })
        LhToast({ type: LhToastType.Default, position: LhToastPosition.Center, controller: this.toastCenter })
        LhToast({ type: LhToastType.Danger, position: LhToastPosition.Bottom, controller: this.toastBottom })
      }
    }
  }
}
