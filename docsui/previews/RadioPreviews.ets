/**
 * Radio 文档页的真交互预览（对应 `docs/components/radio.md` 的 `##` 分节）。
 *
 * 单选语义：宿主持有当前值，onChange 只在「未选中 → 选中」时触发。
 */
import { LhRadio } from '../../components/radio/Index'
import { LhRadioSize } from '../../components/radio/LhRadioTokens'
import { LhToastController } from '../../components/toast/Index'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocPreviewFrame } from '../widgets/DocWidgets'

/** 基本用法：宿主持有当前值，点击切换。 */
@Component
export struct RadioBasicPreview {
  toast: LhToastController = new LhToastController()
  @State value: string = 'a'

  build() {
    DocPreviewFrame({ title: '互斥单选（onChange 仅在选中时触发）' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhRadio({
          checked: this.value === 'a',
          label: '选项一',
          value: 'a',
          onChange: (checked: boolean) => {
            if (checked) {
              this.value = 'a'
              this.toast.show('选中：选项一')
            }
          },
        })
        LhRadio({
          checked: this.value === 'b',
          label: '选项二',
          value: 'b',
          onChange: (checked: boolean) => {
            if (checked) {
              this.value = 'b'
              this.toast.show('选中：选项二')
            }
          },
        })
        LhRadio({
          checked: this.value === 'c',
          label: '禁用项',
          value: 'c',
          disabled: true,
          onChange: (checked: boolean) => this.toast.show('不会触发'),
        })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 尺寸：三档映射到 radio.size 令牌。 */
@Component
export struct RadioSizesPreview {
  toast: LhToastController = new LhToastController()
  @State value: string = 'a'

  build() {
    DocPreviewFrame({ title: '三档尺寸：small / medium / large' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhRadio({
          checked: this.value === 'a',
          label: 'small',
          value: 'a',
          size: LhRadioSize.Small,
          onChange: (checked: boolean) => { if (checked) { this.value = 'a' } },
        })
        LhRadio({
          checked: this.value === 'b',
          label: 'medium（默认）',
          value: 'b',
          onChange: (checked: boolean) => { if (checked) { this.value = 'b' } },
        })
        LhRadio({
          checked: this.value === 'c',
          label: 'large',
          value: 'c',
          size: LhRadioSize.Large,
          onChange: (checked: boolean) => { if (checked) { this.value = 'c' } },
        })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}
