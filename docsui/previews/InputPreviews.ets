/**
 * Input 文档页的真交互预览（对应 `docs/components/input.md` 的 `##` 分节）。
 *
 * 受控语义：value 由预览的 @State 持有，输入时 onValueChange 上报新值。
 */
import { LhInput } from '../../components/input/Index'
import { LhInputType, LhInputSize } from '../../components/input/LhInputTokens'
import { LhToastController } from '../../components/toast/Index'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocPreviewFrame, DocProse } from '../widgets/DocWidgets'

/** 基本用法：受控输入 + placeholder。 */
@Component
export struct InputBasicPreview {
  toast: LhToastController = new LhToastController()
  @State value: string = ''

  build() {
    DocPreviewFrame({ title: 'value 受控；输入时触发 onValueChange' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhInput({
          value: this.value,
          placeholder: '请输入内容',
          onValueChange: (value: string) => {
            this.value = value
            this.toast.show(`onValueChange：${value}`)
          },
        })
        DocProse({ text: `当前值：${this.value === '' ? '（空）' : this.value}`, secondary: true })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 聚焦与尺寸：聚焦环切换；三档尺寸。 */
@Component
export struct InputFocusAndSizesPreview {
  toast: LhToastController = new LhToastController()

  build() {
    DocPreviewFrame({ title: '聚焦 / 失焦触发回调；三档尺寸 small / medium / large' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhInput({
          placeholder: '聚焦与失焦有提示',
          onFocus: () => this.toast.show('onFocus：聚焦'),
          onBlur: () => this.toast.show('onBlur：失焦'),
        })
        LhInput({ placeholder: 'small', size: LhInputSize.Small })
        LhInput({ placeholder: 'medium（默认）' })
        LhInput({ placeholder: 'large', size: LhInputSize.Large })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 状态与清除：禁用 / 只读 / 密码框 / 可清除。 */
@Component
export struct InputStatesAndClearablePreview {
  toast: LhToastController = new LhToastController()
  @State value: string = '预填内容'

  build() {
    DocPreviewFrame({ title: 'disabled / readonly 不触发 onValueChange；password 与 clearable' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhInput({
          value: this.value,
          clearable: true,
          placeholder: '可清除（输入后点 ×）',
          onValueChange: (value: string) => {
            this.value = value
          },
        })
        LhInput({ value: '不可输入', disabled: true })
        LhInput({ value: '只读内容', readonly: true })
        LhInput({
          placeholder: '密码框',
          type: LhInputType.Password,
          onValueChange: (value: string) => this.toast.show(`onValueChange：${value}`),
        })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}
