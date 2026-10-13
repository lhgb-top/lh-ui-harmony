// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/icon.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/IconPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
import { IconSizesPreview, IconTonePreview, IconIconNamesPreview } from '../previews/IconPreviews'

const iconEntry: DocEntry =
    {
      id: "icon",
      title: "Icon 图标",
      group: DocGroup.Basic,
      lede: [
      "图标组件。按本地图形体系把图标名解析为字形渲染，支持尺寸与语义色调。",
      "::: tip 端侧落点说明",
      "鸿蒙端当前用 unicode 字形占位（LhIconTokens.glyphFor），生产环境应替换为",
      "SymbolGlyph / 矢量资产；这与 button 的 Text('◆') 占位策略一致。已登记图标名见下方「图标名」一节。",
      ":::",
    ],
      contract: [
      "契约源：lh-ui-core/specs/icon.json ·",
      "黄金用例：lh-ui-core/cases/icon.json（5 条，已翻译为 hypium 测试）",
    ],
      sections: [
    {
      title: "尺寸",
      prose: [
        "三档尺寸映射到 icon.size 令牌。",
      ],
      code: [
        "LhIcon({ name: 'search', size: LhIconSize.Large })",
      ],
      tables: [],
    },
    {
      title: "色调",
      prose: [
        "tone 决定字形颜色，与语义色令牌一一对应；默认色调取 color.text.primary。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "图标名",
      prose: [
        "glyphFor 当前登记的图标名与字形：search ⌕、refresh ↻、check ✓、close ✕、",
        "warning ⚠、info ℹ、back ←、more ⋯、star ★、edit ✎、delete ⌫、",
        "plus ＋、minus －、arrow →。未登记名回退 ◆。",
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
                { cells: ["name", "图标名（本地图形体系解析，未登记名回退 ◆）", "string", "''" ] },
                { cells: ["size", "图标尺寸，映射到 icon.size 令牌", "LhIconSize", "Medium" ] },
                { cells: ["tone", "语义色调，决定字形颜色", "LhIconTone", "Default" ] },
                { cells: ["onClick", "点击回调", "() => void", "空函数" ] },
                ],
              },
              {
                title: "LhIconSize",
                headers: ["值", "size"],
                rows: [
                { cells: ["Small", "icon.size.small（16vp）" ] },
                { cells: ["Medium", "icon.size.medium（20vp）" ] },
                { cells: ["Large", "icon.size.large（24vp）" ] },
                ],
              },
              {
                title: "LhIconTone",
                headers: ["值", "字形色"],
                rows: [
                { cells: ["Default", "color.text.primary" ] },
                { cells: ["Primary", "color.primary.default" ] },
                { cells: ["Success", "color.success.default" ] },
                { cells: ["Warning", "color.warning.default" ] },
                { cells: ["Danger", "color.danger.default" ] },
                { cells: ["Info", "color.info.default" ] },
                { cells: ["Regular", "color.text.regular" ] },
                { cells: ["Secondary", "color.text.secondary" ] },
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
                { cells: ["icon.size.{small,medium,large}", "三档尺寸" ] },
                { cells: ["color.text.primary", "默认色调" ] },
                { cells: ["color.text.regular / color.text.secondary", "常规 / 次要色调" ] },
                { cells: ["color.{primary,success,warning,danger,info}.default", "语义色调" ] },
                ],
              }
      ],
    },
    {
      title: "黄金用例对照",
      prose: [
        "cases/icon.json 的 5 条断言与 hypium 测试的对应关系（entry/src/test/Icon.test.ets）：",
        "另有暗色专项：dark_colors_come_from_dark_tokens / dimensions_are_identical_in_dark_mode。",
        "运行：DevEco Studio 右键 entry/src/test → Run Tests。",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                { cells: ["click-emits-onclick", "点击触发回调（端侧为 onClick 属性）", "glyph_maps_registered_name（端侧按声明式回调对齐）" ] },
                { cells: ["default-tone-uses-text-primary", "默认色调取主文字色", "default_tone_uses_text_primary" ] },
                { cells: ["primary-tone-uses-primary-token", "主色调取主色令牌", "primary_tone_uses_primary_token" ] },
                { cells: ["small-size-uses-small-token", "小号取 small 尺寸令牌", "small_size_uses_small_token" ] },
                { cells: ["render-emits-icon-command", "渲染发射图标命令", "端侧无对应命令（声明式渲染，字形映射见 glyph_maps_registered_name / glyph_falls_back_for_unknown_name）" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * Icon 图标（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct IconDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: iconEntry }) {
      DocSectionView({ section: iconEntry.sections[0] }) {
        IconSizesPreview({ toast: this.toast })
      }
      DocSectionView({ section: iconEntry.sections[1] }) {
        IconTonePreview({ toast: this.toast })
      }
      DocSectionView({ section: iconEntry.sections[2] }) {
        IconIconNamesPreview({ toast: this.toast })
      }
      DocSectionView({ section: iconEntry.sections[3] }) {
        // 「API」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: iconEntry.sections[4] }) {
        // 「令牌对照」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: iconEntry.sections[5] }) {
        // 「黄金用例对照」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
