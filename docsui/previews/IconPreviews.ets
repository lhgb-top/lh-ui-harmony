/**
 * Icon 文档页的真交互预览（对应 `docs/components/icon.md` 的 `##` 分节）。
 */
import { LhIcon } from '../../components/icon/Index'
import { LhIconSize, LhIconTone } from '../../components/icon/LhIconTokens'
import { LhToastController } from '../../components/toast/Index'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocPreviewFrame } from '../widgets/DocWidgets'

/** 尺寸：三档映射到 icon.size 令牌。 */
@Component
export struct IconSizesPreview {
  toast: LhToastController = new LhToastController()
  build() {
    DocPreviewFrame({ title: '三档尺寸：small / medium / large' }) {
      Row({ space: lhVp(LhTokens.Spacing.xl) }) {
        LhIcon({ name: 'star', size: LhIconSize.Small })
        LhIcon({ name: 'star', size: LhIconSize.Medium })
        LhIcon({ name: 'star', size: LhIconSize.Large })
      }
      .alignItems(VerticalAlign.Center)
    }
  }
}

/** 色调：八种 tone 映射到语义色板。 */
@Component
export struct IconTonePreview {
  toast: LhToastController = new LhToastController()
  build() {
    DocPreviewFrame({ title: '色调 tone：default / primary / success / warning / danger / info / regular / secondary' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        Row({ space: lhVp(LhTokens.Spacing.md) }) {
          LhIcon({ name: 'check', tone: LhIconTone.Default })
          LhIcon({ name: 'check', tone: LhIconTone.Primary })
          LhIcon({ name: 'check', tone: LhIconTone.Success })
          LhIcon({ name: 'check', tone: LhIconTone.Warning })
        }
        Row({ space: lhVp(LhTokens.Spacing.md) }) {
          LhIcon({ name: 'check', tone: LhIconTone.Danger })
          LhIcon({ name: 'check', tone: LhIconTone.Info })
          LhIcon({ name: 'check', tone: LhIconTone.Regular })
          LhIcon({ name: 'check', tone: LhIconTone.Secondary })
        }
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 图标名：当前登记的全部图标名，未登记名回退 ◆。 */
@Component
export struct IconIconNamesPreview {
  toast: LhToastController = new LhToastController()
  private names: string[] = [
    'search', 'refresh', 'check', 'close', 'warning', 'info', 'back',
    'more', 'star', 'edit', 'delete', 'plus', 'minus', 'arrow',
  ]

  build() {
    DocPreviewFrame({ title: '全部已登记图标名（点击查看 name 字符串）' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        Row({ space: lhVp(LhTokens.Spacing.md) }) {
          ForEach(this.names.slice(0, 7), (name: string, index: number) => {
            LhIcon({ name: name, onClick: () => this.toast.show(`icon name: ${name}`) })
          }, (name: string, index: number) => name)
        }
        Row({ space: lhVp(LhTokens.Spacing.md) }) {
          ForEach(this.names.slice(7), (name: string, index: number) => {
            LhIcon({ name: name, onClick: () => this.toast.show(`icon name: ${name}`) })
          }, (name: string, index: number) => name)
        }
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}
