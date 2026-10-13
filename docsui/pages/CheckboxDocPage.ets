// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/checkbox.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/CheckboxPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
import { CheckboxBasicPreview, CheckboxIndeterminateAndDisabledPreview } from '../previews/CheckboxPreviews'

const checkboxEntry: DocEntry =
    {
      id: "checkbox",
      title: "Checkbox 复选框",
      group: DocGroup.Form,
      lede: [
      "三态选中控件。支持选中 / 未选中 / 半选（不确定）三态，可禁用。",
    ],
      contract: [
      "契约源：lh-ui-core/specs/checkbox.json ·",
      "黄金用例：lh-ui-core/cases/checkbox.json（6 条，已翻译为 hypium 测试）",
    ],
      sections: [
    {
      title: "基本用法",
      prose: [
        "checked 受控，点击切换并触发 onChange 携带新选中态。",
      ],
      code: [
        "LhCheckbox({",
        "  checked: this.agreed,",
        "  label: '同意服务条款',",
        "  onChange: (checked: boolean) => { this.agreed = checked },",
        "})",
      ],
      tables: [],
    },
    {
      title: "半选与禁用",
      prose: [
        "indeterminate 为 true 时呈现次要色横杠；点击半选态变为选中",
        "（黄金用例 indeterminate-becomes-checked）。disabled 阻止切换。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "API",
      prose: [
        "选中态：底色 color.primary.default、勾 color.onPrimary、描边主色；",
        "未选中态：透明底、描边 color.border.base；半选态：次要色横杠；禁用态取 color.disabled.*。",
      ],
      code: [],
      tables: [
              {
                title: "Props",
                headers: ["属性", "说明", "类型", "默认值"],
                rows: [
                { cells: ["checked", "是否选中", "boolean", "false" ] },
                { cells: ["indeterminate", "是否半选（不确定）；点击后变为选中", "boolean", "false" ] },
                { cells: ["disabled", "是否禁用；禁用时不触发 onChange", "boolean", "false" ] },
                { cells: ["label", "文字标签", "string", "''" ] },
                { cells: ["size", "复选框尺寸，映射到 checkbox.size 令牌", "LhCheckboxSize", "Medium" ] },
                { cells: ["onChange", "点击切换时触发，携带新选中态", "(checked: boolean) => void", "空函数" ] },
                ],
              },
              {
                title: "LhCheckboxSize",
                headers: ["值", "size"],
                rows: [
                { cells: ["Small", "checkbox.size.small（16vp）" ] },
                { cells: ["Medium", "checkbox.size.medium（20vp）" ] },
                { cells: ["Large", "checkbox.size.large（24vp）" ] },
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
                { cells: ["checkbox.size.{small,medium,large}", "三档尺寸" ] },
                { cells: ["checkbox.borderRadius / checkbox.borderWidth", "圆角与描边宽度（2 / 2vp）" ] },
                { cells: ["checkbox.checkWidth", "勾形描边宽度" ] },
                { cells: ["checkbox.gap", "复选框与文字间距（8vp）" ] },
                { cells: ["color.primary.default / color.onPrimary", "选中底 / 勾色" ] },
                { cells: ["color.border.base", "未选中描边色" ] },
                { cells: ["color.text.secondary", "半选横杠色" ] },
                { cells: ["color.disabled.{bg,text,border}", "禁用态三色" ] },
                { cells: ["typography.fontSize.base", "标签字号" ] },
                ],
              }
      ],
    },
    {
      title: "黄金用例对照",
      prose: [
        "cases/checkbox.json 的 6 条断言与 hypium 测试的对应关系（entry/src/test/Checkbox.test.ets）：",
        "另有暗色专项：dark_colors_come_from_dark_tokens / dimensions_are_identical_in_dark_mode。",
        "运行：DevEco Studio 右键 entry/src/test → Run Tests。",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                { cells: ["tap-toggles-and-emits-onchange", "点击切换并触发 onChange", "tap_toggles_checked" ] },
                { cells: ["tap-checked-unchecks", "选中态点击变为未选中", "tap_checked_unchecks" ] },
                { cells: ["disabled-blocks-change", "禁用态不触发 onChange", "disabled_is_not_interactive" ] },
                { cells: ["checked-uses-primary-tokens", "选中态消费主色令牌", "checked_uses_primary_tokens" ] },
                { cells: ["unchecked-uses-border-token", "未选中态消费描边令牌", "unchecked_uses_border_token" ] },
                { cells: ["indeterminate-becomes-checked", "半选态点击变为选中", "indeterminate_becomes_checked / indeterminate_uses_dash_mark" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * Checkbox 复选框（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct CheckboxDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: checkboxEntry }) {
      DocSectionView({ section: checkboxEntry.sections[0] }) {
        CheckboxBasicPreview({ toast: this.toast })
      }
      DocSectionView({ section: checkboxEntry.sections[1] }) {
        CheckboxIndeterminateAndDisabledPreview({ toast: this.toast })
      }
      DocSectionView({ section: checkboxEntry.sections[2] }) {
        // 「API」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: checkboxEntry.sections[3] }) {
        // 「令牌对照」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: checkboxEntry.sections[4] }) {
        // 「黄金用例对照」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
