/**
 * Textarea 文档页的真交互预览（对应 `docs/components/textarea.md` 的 `##` 分节）。
 */
import { LhTextarea } from '../../components/textarea/Index'
import { LhToastController } from '../../components/toast/Index'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocPreviewFrame, DocProse } from '../widgets/DocWidgets'

/** 基本用法：受控多行输入。 */
@Component
export struct TextareaBasicPreview {
  toast: LhToastController = new LhToastController()
  @State value: string = ''

  build() {
    DocPreviewFrame({ title: 'value 受控；rows 控制初始行高' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhTextarea({
          value: this.value,
          placeholder: '请输入多行内容',
          rows: 3,
          onValueChange: (value: string) => {
            this.value = value
          },
          onFocus: () => this.toast.show('onFocus：聚焦'),
          onBlur: () => this.toast.show('onBlur：失焦'),
        })
        DocProse({ text: `当前值（${this.value.length} 字）：${this.value === '' ? '（空）' : this.value}`, secondary: true })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 字数统计：showCount 显示计数器，maxlength 限制输入。 */
@Component
export struct TextareaCountPreview {
  toast: LhToastController = new LhToastController()
  @State value: string = ''

  build() {
    DocPreviewFrame({ title: 'showCount = 计数器；maxlength = 20 字上限' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhTextarea({
          value: this.value,
          placeholder: '最多 20 字',
          rows: 2,
          showCount: true,
          maxlength: 20,
          onValueChange: (value: string) => { this.value = value },
        })
        LhTextarea({ value: '禁用态', disabled: true, showCount: true })
        LhTextarea({ value: '只读态', readonly: true, showCount: true })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}
