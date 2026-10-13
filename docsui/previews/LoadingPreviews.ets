/**
 * Loading 文档页的真交互预览（对应 `docs/components/loading.md` 的 `##` 分节）。
 */
import { LhLoading } from '../../components/loading/Index'
import { LhLoadingSize, LhLoadingTone } from '../../components/loading/LhLoadingTokens'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocPreviewFrame } from '../widgets/DocWidgets'

/** 尺寸：三档映射到 loading.size 令牌。 */
@Component
export struct LoadingSizesPreview {
  toast: LhToastController = new LhToastController()
  build() {
    DocPreviewFrame({ title: '三档尺寸：small / medium / large' }) {
      Row({ space: lhVp(LhTokens.Spacing.xl) }) {
        LhLoading({ size: LhLoadingSize.Small })
        LhLoading({ size: LhLoadingSize.Medium })
        LhLoading({ size: LhLoadingSize.Large })
      }
      .alignItems(VerticalAlign.Center)
    }
  }
}

/** 色调：五种语义色调（loading 无 default 色调，默认即 primary）。 */
@Component
export struct LoadingTonePreview {
  toast: LhToastController = new LhToastController()
  build() {
    DocPreviewFrame({ title: '色调 tone：primary / success / warning / danger / info' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        Row({ space: lhVp(LhTokens.Spacing.md) }) {
          LhLoading({ tone: LhLoadingTone.Primary })
          LhLoading({ tone: LhLoadingTone.Success })
          LhLoading({ tone: LhLoadingTone.Warning })
        }
        Row({ space: lhVp(LhTokens.Spacing.md) }) {
          LhLoading({ tone: LhLoadingTone.Danger })
          LhLoading({ tone: LhLoadingTone.Info })
        }
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}
