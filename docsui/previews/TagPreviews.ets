/**
 * Tag 文档页的真交互预览（对应 `docs/components/tag.md` 的 `##` 分节）。
 */
import { LhTag } from '../../components/tag/Index'
import { LhTagType, LhTagSize } from '../../components/tag/LhTagTokens'
import { LhToastController } from '../../components/toast/Index'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocPreviewFrame } from '../widgets/DocWidgets'

/** 类型：六种语义类型。 */
@Component
export struct TagTypesPreview {
  toast: LhToastController = new LhToastController()
  build() {
    DocPreviewFrame({ title: '六种类型：default / primary / success / warning / danger / info' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        Row({ space: lhVp(LhTokens.Spacing.sm) }) {
          LhTag({ text: '默认', type: LhTagType.Default })
          LhTag({ text: '主要', type: LhTagType.Primary })
          LhTag({ text: '成功', type: LhTagType.Success })
        }
        Row({ space: lhVp(LhTokens.Spacing.sm) }) {
          LhTag({ text: '警告', type: LhTagType.Warning })
          LhTag({ text: '危险', type: LhTagType.Danger })
          LhTag({ text: '信息', type: LhTagType.Info })
        }
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 描边与圆角：plain 描边态、round 胶囊态、二者叠加。 */
@Component
export struct TagPlainAndRoundPreview {
  toast: LhToastController = new LhToastController()
  build() {
    DocPreviewFrame({ title: 'plain = 描边；round = 胶囊圆角；可叠加' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        Row({ space: lhVp(LhTokens.Spacing.sm) }) {
          LhTag({ text: '实心', type: LhTagType.Primary })
          LhTag({ text: '描边', type: LhTagType.Primary, plain: true })
        }
        Row({ space: lhVp(LhTokens.Spacing.sm) }) {
          LhTag({ text: '圆角', type: LhTagType.Success, round: true })
          LhTag({ text: '描边圆角', type: LhTagType.Success, plain: true, round: true })
        }
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 尺寸与关闭：三档尺寸；closable 显示关闭符并触发 onClose。 */
@Component
export struct TagSizesAndClosablePreview {
  toast: LhToastController = new LhToastController()

  build() {
    DocPreviewFrame({ title: '三档尺寸；closable 的关闭符点击触发 onClose' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        Row({ space: lhVp(LhTokens.Spacing.sm) }) {
          LhTag({ text: 'small', type: LhTagType.Primary, size: LhTagSize.Small })
          LhTag({ text: 'medium', type: LhTagType.Primary })
          LhTag({ text: 'large', type: LhTagType.Primary, size: LhTagSize.Large })
        }
        Row({ space: lhVp(LhTokens.Spacing.sm) }) {
          LhTag({
            text: '可关闭',
            type: LhTagType.Warning,
            closable: true,
            onClose: () => this.toast.show('onClose：关闭标签'),
          })
          LhTag({ text: '描边可关闭', type: LhTagType.Info, plain: true, closable: true, onClose: () => this.toast.show('onClose') })
        }
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}
