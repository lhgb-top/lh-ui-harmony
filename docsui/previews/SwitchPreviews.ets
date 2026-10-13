/**
 * Switch 文档页的真交互预览（对应 `docs/components/switch.md` 的 `##` 分节）。
 */
import { LhSwitch } from '../../components/switch/Index'
import { LhSwitchSize } from '../../components/switch/LhSwitchTokens'
import { LhToastController } from '../../components/toast/Index'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocPreviewFrame } from '../widgets/DocWidgets'

/** 基本用法：checked 受控，onChange 上报新状态。 */
@Component
export struct SwitchBasicPreview {
  toast: LhToastController = new LhToastController()
  @State checked: boolean = false

  build() {
    DocPreviewFrame({ title: '点击切换开关态（disabled / loading 时不触发 onChange）' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhSwitch({
          checked: this.checked,
          onChange: (checked: boolean) => {
            this.checked = checked
            this.toast.show(`onChange：${checked ? '开' : '关'}`)
          },
        })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 尺寸：三档映射到 switch.height 令牌。 */
@Component
export struct SwitchSizesPreview {
  toast: LhToastController = new LhToastController()
  @State a: boolean = true
  @State b: boolean = true
  @State c: boolean = true

  build() {
    DocPreviewFrame({ title: '三档尺寸：small / medium / large' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhSwitch({ checked: this.a, size: LhSwitchSize.Small, onChange: (checked: boolean) => { this.a = checked } })
        LhSwitch({ checked: this.b, onChange: (checked: boolean) => { this.b = checked } })
        LhSwitch({ checked: this.c, size: LhSwitchSize.Large, onChange: (checked: boolean) => { this.c = checked } })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 状态：禁用（开 / 关）与加载中。 */
@Component
export struct SwitchStatesPreview {
  toast: LhToastController = new LhToastController()
  build() {
    DocPreviewFrame({ title: 'disabled 与 loading 均不触发 onChange' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhSwitch({ checked: true, disabled: true })
        LhSwitch({ checked: false, disabled: true })
        LhSwitch({ checked: true, loading: true })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}
