/**
 * Checkbox 文档页的真交互预览（对应 `docs/components/checkbox.md` 的 `##` 分节）。
 */
import { LhCheckbox } from '../../components/checkbox/Index'
import { LhCheckboxSize } from '../../components/checkbox/LhCheckboxTokens'
import { LhToastController } from '../../components/toast/Index'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocPreviewFrame } from '../widgets/DocWidgets'

/** 基本用法：受控语义，checked 由宿主持有，onChange 上报新状态。 */
@Component
export struct CheckboxBasicPreview {
  toast: LhToastController = new LhToastController()
  @State checked: boolean = true

  build() {
    DocPreviewFrame({ title: '点击切换选中态（checked 受控、onChange 上报）' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhCheckbox({
          checked: this.checked,
          label: '同意《用户协议》',
          onChange: (checked: boolean) => {
            this.checked = checked
            this.toast.show(`onChange：${checked ? '已选中' : '已取消'}`)
          },
        })
        LhCheckbox({ checked: false, label: '默认未选中' })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 半选与禁用：indeterminate 优先于 checked 渲染为横杠；disabled 不触发 onChange。 */
@Component
export struct CheckboxIndeterminateAndDisabledPreview {
  toast: LhToastController = new LhToastController()
  @State indeterminate: boolean = true

  build() {
    DocPreviewFrame({ title: 'indeterminate 半选态；disabled 禁用不响应点击' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhCheckbox({
          checked: false,
          indeterminate: this.indeterminate,
          label: '半选态（点击变为已选中）',
          size: LhCheckboxSize.Large,
          onChange: (checked: boolean) => {
            this.indeterminate = false
            this.toast.show(`onChange：${checked ? '已选中' : '已取消'}`)
          },
        })
        LhCheckbox({ checked: true, disabled: true, label: '禁用（选中态）' })
        LhCheckbox({ checked: false, disabled: true, label: '禁用（未选中）' })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}
