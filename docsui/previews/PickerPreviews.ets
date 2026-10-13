/**
 * Picker 文档页的真交互预览（对应 `docs/components/picker.md` 的 `##` 分节）。
 *
 * 滚轮停止且选中项变化时触发 onValueChange；确认时 onConfirm 携带选中索引。
 */
import { LhPicker } from '../../components/picker/Index'
import { LhButton } from '../../components/button/Index'
import { LhButtonType } from '../../components/button/LhButtonTokens'
import { LhToastController } from '../../components/toast/Index'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocPreviewFrame, DocProse } from '../widgets/DocWidgets'

@Component
export struct PickerBasicPreview {
  toast: LhToastController = new LhToastController()
  @State visible: boolean = false
  @State value: number = 0
  private options: string[] = ['选项一', '选项二', '选项三', '选项四', '选项五']

  build() {
    DocPreviewFrame({ title: '点击打开选择器；滚轮停止触发 onValueChange' }) {
      Stack() {
        Column({ space: lhVp(LhTokens.Spacing.sm) }) {
          LhButton({
            onClick: () => this.visible = true,
            type: LhButtonType.Primary,
            text: '打开选择器',
          })
          DocProse({ text: `当前选中：${this.options[this.value]}（索引 ${this.value}）`, secondary: true })
        }
        .alignItems(HorizontalAlign.Start)

        LhPicker({
          visible: this.visible,
          options: this.options,
          value: this.value,
          title: '请选择',
          onValueChange: (value: number) => {
            this.value = value
            this.toast.show(`onValueChange：${this.options[value]}`)
          },
          onConfirm: (value: number) => {
            this.visible = false
            this.toast.show(`onConfirm：${this.options[value]}`)
          },
          onClose: () => {
            this.visible = false
          },
        })
      }
    }
  }
}
