// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/text.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/TextPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
import { TextLevelsPreview, TextWeightPreview, TextTonePreview, TextAlignAndLineHeightPreview, TextThemePreview } from '../previews/TextPreviews'

const textEntry: DocEntry =
    {
      id: "text",
      title: "Text 文本",
      group: DocGroup.Basic,
      lede: [
      "文本展示原语：消费全局排版令牌，支持字号级别、字重、色调与对齐。",
    ],
      contract: [
      "契约源：lh-ui-core/specs/text.json ·",
      "黄金用例：lh-ui-core/cases/text.json（5 条，已翻译为 hypium 测试）",
    ],
      sections: [
    {
      title: "字号级别",
      prose: [
        "level 映射到 typography.fontSize.<level> 令牌，默认 base。",
      ],
      code: [
        "LhText({ content: '标题文字', level: LhTextLevel.Large })",
      ],
      tables: [],
    },
    {
      title: "字重",
      prose: [
        "weight 映射到 typography.fontWeight.<weight> 令牌（primary 400 / bold 600）。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "色调",
      prose: [
        "tone 映射到 color.text.<tone> 令牌；selected 取 color.selected。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "对齐与行高",
      prose: [
        "align 决定文字在行盒宽度内的水平定位（不是设计令牌，映射到框架枚举）；行高恒取",
        "typography.lineHeight.primary，layout 高度 = 字号 × 行高。",
      ],
      code: [
        "LhText({ content: '右对齐', align: LhTextAlign.End })",
      ],
      tables: [],
    },
    {
      title: "明暗主题",
      prose: [
        "切换站点右上角主题，模拟器手机框内的文字颜色即变；真机通过 LhTheme.apply(true) 切换。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "API",
      prose: [],
      code: [],
      tables: [
              {
                title: "Props",
                headers: ["属性", "说明", "类型", "默认值"],
                rows: [
                { cells: ["content", "文本内容（spec 的 default 插槽）", "string", "''" ] },
                { cells: ["level", "字号级别，映射到 typography.fontSize.<level>", "LhTextLevel", "Base" ] },
                { cells: ["weight", "字重，映射到 typography.fontWeight.<weight>", "LhTextWeight", "Primary" ] },
                { cells: ["tone", "文字色调，映射到 color.text.<tone> 或 color.selected", "LhTextTone", "Primary" ] },
                { cells: ["align", "水平对齐方式（在行盒宽度内生效）", "LhTextAlign", "Start" ] },
                ],
              },
              {
                title: "LhTextLevel",
                headers: ["值", "fontSize"],
                rows: [
                { cells: ["ExtraLarge", "typography.fontSize.extraLarge（20）" ] },
                { cells: ["Large", "typography.fontSize.large（18）" ] },
                { cells: ["Medium", "typography.fontSize.medium（16）" ] },
                { cells: ["Base", "typography.fontSize.base（14）" ] },
                { cells: ["Small", "typography.fontSize.small（13）" ] },
                { cells: ["ExtraSmall", "typography.fontSize.extraSmall（12）" ] },
                ],
              },
              {
                title: "LhTextWeight",
                headers: ["值", "fontWeight"],
                rows: [
                { cells: ["Primary", "typography.fontWeight.primary（400）" ] },
                { cells: ["Bold", "typography.fontWeight.bold（600）" ] },
                ],
              },
              {
                title: "LhTextTone",
                headers: ["值", "文字色"],
                rows: [
                { cells: ["Primary", "color.text.primary" ] },
                { cells: ["Regular", "color.text.regular" ] },
                { cells: ["Secondary", "color.text.secondary" ] },
                { cells: ["Placeholder", "color.text.placeholder" ] },
                { cells: ["Disabled", "color.text.disabled" ] },
                { cells: ["Selected", "color.selected" ] },
                ],
              },
              {
                title: "LhTextAlign",
                headers: ["值", "端侧映射"],
                rows: [
                { cells: ["Start", "TextAlign.Start" ] },
                { cells: ["Center", "TextAlign.Center" ] },
                { cells: ["End", "TextAlign.End" ] },
                ],
              }
      ],
    },
    {
      title: "令牌对照",
      prose: [
        "文本消费的令牌（与 specs/text.json 的 tokenRefs 逐条对齐，全部是全局令牌——",
        "text 没有组件级令牌）：",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["令牌", "用途"],
                rows: [
                { cells: ["typography.fontSize.{extraLarge,large,medium,base,small,extraSmall}", "六档字号" ] },
                { cells: ["typography.fontWeight.{primary,bold}", "两档字重" ] },
                { cells: ["typography.lineHeight.primary", "行高（layout 高度 = 字号 × 行高）" ] },
                { cells: ["color.text.{primary,regular,secondary,placeholder,disabled}", "五档文字色调" ] },
                { cells: ["color.selected", "选中态文字色" ] },
                ],
              }
      ],
    },
    {
      title: "黄金用例对照",
      prose: [
        "cases/text.json 的 5 条断言与 hypium 测试的对应关系（entry/src/test/Text.test.ets）：",
        "另有暗色专项：dark_colors_come_from_dark_tokens / dimensions_are_identical_in_dark_mode。",
        "运行：DevEco Studio 右键 entry/src/test → Run Tests。",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                { cells: ["default-level-uses-base-tokens", "默认级消费 base 套排版令牌", "default_level_uses_base_tokens" ] },
                { cells: ["large-level-uses-large-token", "large 字号令牌生效，base 未误用", "large_level_uses_large_token" ] },
                { cells: ["bold-weight-uses-bold-token", "bold 字重令牌生效，primary 未误用", "bold_weight_uses_bold_token" ] },
                { cells: ["secondary-tone-uses-text-secondary", "secondary 文字色令牌生效", "secondary_tone_uses_text_secondary" ] },
                { cells: ["render-emits-single-text-command", "指令流仅一条 TEXT 指令", "resolve_produces_single_complete_text_style" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * Text 文本（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct TextDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: textEntry }) {
      DocSectionView({ section: textEntry.sections[0] }) {
        TextLevelsPreview({ toast: this.toast })
      }
      DocSectionView({ section: textEntry.sections[1] }) {
        TextWeightPreview({ toast: this.toast })
      }
      DocSectionView({ section: textEntry.sections[2] }) {
        TextTonePreview({ toast: this.toast })
      }
      DocSectionView({ section: textEntry.sections[3] }) {
        TextAlignAndLineHeightPreview({ toast: this.toast })
      }
      DocSectionView({ section: textEntry.sections[4] }) {
        TextThemePreview({ toast: this.toast })
      }
      DocSectionView({ section: textEntry.sections[5] }) {
        // 「API」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: textEntry.sections[6] }) {
        // 「令牌对照」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: textEntry.sections[7] }) {
        // 「黄金用例对照」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
