// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/tag.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/TagPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
import { TagTypesPreview, TagPlainAndRoundPreview, TagSizesAndClosablePreview } from '../previews/TagPreviews'

const tagEntry: DocEntry =
    {
      id: "tag",
      title: "Tag 标签",
      group: DocGroup.Basic,
      lede: [
      "用于标记和选择的标签。支持六种语义类型、三档尺寸、描边态、圆角态与可关闭态。",
    ],
      contract: [
      "契约源：lh-ui-core/specs/tag.json ·",
      "黄金用例：lh-ui-core/cases/tag.json（6 条，已翻译为 hypium 测试）",
    ],
      sections: [
    {
      title: "类型",
      prose: [
        "六种类型决定底色、文字色与描边色。",
      ],
      code: [
        "LhTag({ text: '主要', type: LhTagType.Primary })",
      ],
      tables: [],
    },
    {
      title: "描边与圆角",
      prose: [
        "plain 为 true 时切换为语义浅底 + 语义文字 + 语义描边；round 为 true 时",
        "圆角取高度的一半（与端侧 radius 分数换算一致）。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "尺寸与关闭",
      prose: [
        "三档尺寸映射到 tag.height / paddingHorizontal / fontSize 令牌；closable",
        "为 true 时在右侧绘制关闭符，点击触发 onClose。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "API",
      prose: [
        "默认类型描边取 color.border.base；语义类型实心态描边透明。",
      ],
      code: [],
      tables: [
              {
                title: "Props",
                headers: ["属性", "说明", "类型", "默认值"],
                rows: [
                { cells: ["text", "标签文字内容（spec 的 default 插槽）", "string", "''" ] },
                { cells: ["type", "语义类型，决定底色 / 文字色 / 描边色", "LhTagType", "Default" ] },
                { cells: ["size", "标签尺寸，映射到尺寸令牌", "LhTagSize", "Medium" ] },
                { cells: ["plain", "是否描边态（语义浅底 + 语义文字 + 语义描边）", "boolean", "false" ] },
                { cells: ["round", "是否圆角态（圆角 = 高度一半）", "boolean", "false" ] },
                { cells: ["closable", "是否显示关闭符；点击触发 onClose", "boolean", "false" ] },
                { cells: ["onClose", "点击关闭符时触发", "() => void", "空函数" ] },
                ],
              },
              {
                title: "LhTagType",
                headers: ["值", "实心底", "实心文字", "plain 底 / 文字 / 描边"],
                rows: [
                { cells: ["Default", "color.background.default", "color.text.primary", "—（默认即中性）" ] },
                { cells: ["Primary", "color.primary.default", "color.onPrimary", "color.primary.bg / .default / .default" ] },
                { cells: ["Success", "color.success.default", "color.onPrimary", "color.success.bg / .default / .default" ] },
                { cells: ["Warning", "color.warning.default", "color.onPrimary", "color.warning.bg / .default / .default" ] },
                { cells: ["Danger", "color.danger.default", "color.onPrimary", "color.danger.bg / .default / .default" ] },
                { cells: ["Info", "color.info.default", "color.onPrimary", "color.info.bg / .default / .default" ] },
                ],
              },
              {
                title: "LhTagSize",
                headers: ["值", "height", "paddingHorizontal", "fontSize"],
                rows: [
                { cells: ["Small", "tag.height.small（20vp）", "tag.paddingHorizontal.small（8vp）", "tag.fontSize.small（12）" ] },
                { cells: ["Medium", "tag.height.medium（24vp）", "tag.paddingHorizontal.medium（12vp）", "tag.fontSize.medium（13）" ] },
                { cells: ["Large", "tag.height.large（28vp）", "tag.paddingHorizontal.large（16vp）", "tag.fontSize.large（14）" ] },
                ],
              }
      ],
    },
    {
      title: "令牌对照",
      prose: [],
      code: [],
      tables: [
              {
                title: "",
                headers: ["令牌", "用途"],
                rows: [
                { cells: ["tag.height.{small,medium,large}", "三档高度（round 态圆角取其一半）" ] },
                { cells: ["tag.paddingHorizontal.{small,medium,large}", "三档横向内边距" ] },
                { cells: ["tag.fontSize.{small,medium,large}", "三档字号" ] },
                { cells: ["tag.borderRadius / tag.borderWidth", "基础圆角与描边宽度" ] },
                { cells: ["color.background.default / color.text.primary / color.border.base", "默认类型三色" ] },
                { cells: ["color.<sem>.default / color.onPrimary", "语义类型实心底 / 文字" ] },
                { cells: ["color.<sem>.bg", "plain 态浅底" ] },
                { cells: ["spacing.xs", "关闭符与文字间距" ] },
                ],
              }
      ],
    },
    {
      title: "黄金用例对照",
      prose: [
        "cases/tag.json 的 6 条断言与 hypium 测试的对应关系（entry/src/test/Tag.test.ets）：",
        "另有暗色专项：dark_colors_come_from_dark_tokens / dimensions_are_identical_in_dark_mode。",
        "运行：DevEco Studio 右键 entry/src/test → Run Tests。",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                { cells: ["default-type-renders-text", "默认类型中性底/文字", "default_type_uses_neutral_tokens" ] },
                { cells: ["primary-type-uses-primary-tokens", "主色类型消费主色令牌", "primary_type_uses_primary_tokens" ] },
                { cells: ["plain-uses-bg-tokens", "描边态消费语义浅底令牌", "plain_uses_bg_tokens" ] },
                { cells: ["small-size-uses-small-tokens", "小号消费 small 尺寸令牌", "small_size_uses_small_tokens" ] },
                { cells: ["round-makes-radius-half-height", "圆角态取高度一半", "round_makes_radius_half_height" ] },
                { cells: ["closable-tap-emits-onclose", "点击关闭符触发 onClose", "closable_close_gap_uses_spacing_xs（间距令牌侧证）" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * Tag 标签（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct TagDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: tagEntry }) {
      DocSectionView({ section: tagEntry.sections[0] }) {
        TagTypesPreview({ toast: this.toast })
      }
      DocSectionView({ section: tagEntry.sections[1] }) {
        TagPlainAndRoundPreview({ toast: this.toast })
      }
      DocSectionView({ section: tagEntry.sections[2] }) {
        TagSizesAndClosablePreview({ toast: this.toast })
      }
      DocSectionView({ section: tagEntry.sections[3] }) {
        // 「API」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: tagEntry.sections[4] }) {
        // 「令牌对照」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: tagEntry.sections[5] }) {
        // 「黄金用例对照」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
