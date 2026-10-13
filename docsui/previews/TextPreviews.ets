/**
 * Text 文档页的真交互预览（对应 `docs/components/text.md` 的 `##` 分节）。
 */
import { LhText } from '../../components/text/Index'
import {
  LhTextLevel, LhTextWeight, LhTextTone, LhTextAlign,
} from '../../components/text/LhTextTokens'
import { LhToastController } from '../../components/toast/Index'
import { LhButton } from '../../components/button/Index'
import { LhButtonType } from '../../components/button/LhButtonTokens'
import { LhTheme } from '../../common/theme/LhThemeApply'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocPreviewFrame, DocProse } from '../widgets/DocWidgets'

/** 字号级别：六档映射到 typography.fontSize 令牌。 */
@Component
export struct TextLevelsPreview {
  toast: LhToastController = new LhToastController()
  build() {
    DocPreviewFrame({ title: '六档字号：extraLarge → extraSmall' }) {
      Column({ space: lhVp(LhTokens.Spacing.xs) }) {
        LhText({ content: 'extraLarge 大标题', level: LhTextLevel.ExtraLarge })
        LhText({ content: 'large 标题', level: LhTextLevel.Large })
        LhText({ content: 'medium 小标题', level: LhTextLevel.Medium })
        LhText({ content: 'base 正文（默认）' })
        LhText({ content: 'small 辅助文字', level: LhTextLevel.Small })
        LhText({ content: 'extraSmall 标签文字', level: LhTextLevel.ExtraSmall })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 字重：primary（常规）与 bold。 */
@Component
export struct TextWeightPreview {
  toast: LhToastController = new LhToastController()
  build() {
    DocPreviewFrame({ title: '字重 weight：primary 常规 / bold 加粗' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhText({ content: 'primary：常规字重', weight: LhTextWeight.Primary })
        LhText({ content: 'bold：加粗字重', weight: LhTextWeight.Bold })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 色调：六种语义 + 状态色调。 */
@Component
export struct TextTonePreview {
  toast: LhToastController = new LhToastController()
  build() {
    DocPreviewFrame({ title: '色调 tone：primary / regular / secondary / placeholder / disabled / selected' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhText({ content: 'primary：主要文字', tone: LhTextTone.Primary })
        LhText({ content: 'regular：常规文字', tone: LhTextTone.Regular })
        LhText({ content: 'secondary：次要说明', tone: LhTextTone.Secondary })
        LhText({ content: 'placeholder：占位提示', tone: LhTextTone.Placeholder })
        LhText({ content: 'disabled：禁用文字', tone: LhTextTone.Disabled })
        LhText({ content: 'selected：选中文字', tone: LhTextTone.Selected })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 对齐与行高：start / center / end。 */
@Component
export struct TextAlignAndLineHeightPreview {
  toast: LhToastController = new LhToastController()
  build() {
    DocPreviewFrame({ title: '对齐 align：start / center / end' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhText({ content: 'start 左对齐（默认）', align: LhTextAlign.Start })
        LhText({ content: 'center 居中对齐', align: LhTextAlign.Center })
        LhText({ content: 'end 右对齐', align: LhTextAlign.End })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 明暗主题：切换全局主题，文字色调令牌同步热重绘。 */
@Component
export struct TextThemePreview {
  toast: LhToastController = new LhToastController()
  build() {
    DocPreviewFrame({ title: '点击切换全局明暗主题，文字色热重绘' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhButton({
          onClick: () => LhTheme.apply(!LhTheme.isDark),
          type: LhButtonType.Primary,
          text: '切换全局明暗主题',
        })
        DocProse({
          text: 'primary / regular / secondary 等色调在明暗色板中成对预计算（theming 文档有完整对照）。',
          secondary: true,
        })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}
