// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/cell.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/CellPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
import { CellBasicPreview, CellIconRequiredAndClickablePreview } from '../previews/CellPreviews'

const cellEntry: DocEntry =
    {
      id: "cell",
      title: "Cell 单元格",
      group: DocGroup.Basic,
      lede: [
      "列表行单元格。标题 + 说明 + 右侧值的经典三段式布局，支持图标、必填红星、分隔线与点击箭头。",
    ],
      contract: [
      "契约源：lh-ui-core/specs/cell.json ·",
      "黄金用例：lh-ui-core/cases/cell.json（6 条，已翻译为 hypium 测试）",
    ],
      sections: [
    {
      title: "基本用法",
      prose: [
        "title 为主文字，value 右对齐，label 为标题下方的次要说明。",
      ],
      code: [
        "LhCell({ title: '标题文字', value: '右侧值', label: '说明文字' })",
      ],
      tables: [],
    },
    {
      title: "图标 / 必填 / 可点击",
      prose: [
        "icon 在左侧绘制图标，required 在标题前绘制必填红星（取 color.danger.default），",
        "clickable 为 true 时右侧出现指示箭头并响应点击。",
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
                { cells: ["title", "标题（主文字）", "string", "''" ] },
                { cells: ["value", "右侧值（右对齐次文字）", "string", "''" ] },
                { cells: ["label", "标题下方的说明文字", "string", "''" ] },
                { cells: ["bordered", "是否绘制底部分隔线", "boolean", "true" ] },
                { cells: ["clickable", "是否可点击；为 true 时显示右侧箭头并响应点击", "boolean", "false" ] },
                { cells: ["required", "是否在标题前显示必填红星", "boolean", "false" ] },
                { cells: ["icon", "左侧图标名（本地图形体系渲染）", "string?", "undefined" ] },
                { cells: ["onClick", "点击回调；clickable 为 false 时不触发", "() => void", "空函数" ] },
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
                { cells: ["cell.paddingHorizontal / cell.paddingVertical", "单元格内边距（16 / 8vp）" ] },
                { cells: ["cell.fontSizeTitle / cell.fontSizeLabel / cell.fontSizeValue", "三段文字字号（14 / 13 / 14）" ] },
                { cells: ["cell.gap", "标题与说明的垂直间距" ] },
                { cells: ["color.text.primary / color.text.secondary", "标题色 / 说明与值色" ] },
                { cells: ["color.border.lighter", "底部分隔线色" ] },
                { cells: ["color.danger.default", "必填红星色" ] },
                { cells: ["icon.size.medium", "左侧图标与右侧箭头尺寸" ] },
                ],
              }
      ],
    },
    {
      title: "黄金用例对照",
      prose: [
        "cases/cell.json 的 6 条断言与 hypium 测试的对应关系（entry/src/test/Cell.test.ets）：",
        "另有暗色专项：dark_colors_come_from_dark_tokens / dimensions_are_identical_in_dark_mode。",
        "运行：DevEco Studio 右键 entry/src/test → Run Tests。",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                { cells: ["title-and-value-render", "标题与值消费字号令牌", "title_and_value_use_font_tokens" ] },
                { cells: ["label-renders-secondary-tone", "说明取次要文字色", "label_uses_secondary_tone" ] },
                { cells: ["required-uses-danger-token", "必填红星取危险色", "required_uses_danger_token" ] },
                { cells: ["bordered-emits-line-command", "分隔线消费描边令牌", "bordered_uses_border_lighter_token" ] },
                { cells: ["clickable-emits-onclick", "可点击时触发回调", "clickable_state_is_resolved" ] },
                { cells: ["not-clickable-no-onclick", "不可点击时不触发", "clickable_state_is_resolved（gate 断言）" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * Cell 单元格（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct CellDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: cellEntry }) {
      DocSectionView({ section: cellEntry.sections[0] }) {
        CellBasicPreview({ toast: this.toast })
      }
      DocSectionView({ section: cellEntry.sections[1] }) {
        CellIconRequiredAndClickablePreview({ toast: this.toast })
      }
      DocSectionView({ section: cellEntry.sections[2] }) {
        // 「API」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: cellEntry.sections[3] }) {
        // 「令牌对照」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: cellEntry.sections[4] }) {
        // 「黄金用例对照」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
