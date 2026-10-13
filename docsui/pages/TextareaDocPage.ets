// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/textarea.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/TextareaPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
import { TextareaBasicPreview, TextareaCountPreview } from '../previews/TextareaPreviews'

const textareaEntry: DocEntry =
    {
      id: "textarea",
      title: "Textarea 多行输入",
      group: DocGroup.Form,
      lede: [
      "多行文本输入。高度随行数与内容增长，支持字数统计与字数上限。",
    ],
      contract: [
      "契约源：lh-ui-core/specs/textarea.json ·",
      "黄金用例：lh-ui-core/cases/textarea.json（6 条，已翻译为 hypium 测试）",
    ],
      sections: [
    {
      title: "基本用法",
      prose: [
        "rows 决定初始可见行数，最小高度取 textarea.minHeight 令牌。",
      ],
      code: [
        "LhTextarea({",
        "  value: this.remark,",
        "  placeholder: '请输入备注内容',",
        "  rows: 3,",
        "  onValueChange: (value: string) => { this.remark = value },",
        "})",
      ],
      tables: [],
    },
    {
      title: "字数统计",
      prose: [
        "showCount 为 true 时在右下角显示字数统计：设置 maxlength 显示 当前/上限，",
        "不设置时只显示当前长度。",
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
                { cells: ["value", "当前文本值（受控）", "string", "''" ] },
                { cells: ["placeholder", "占位提示文字", "string", "''" ] },
                { cells: ["rows", "初始可见行数；高度随行数与内容增长", "number", "3" ] },
                { cells: ["disabled", "是否禁用；禁用时不响应输入、不触发 onValueChange", "boolean", "false" ] },
                { cells: ["readonly", "是否只读；只读时可聚焦但不接受输入", "boolean", "false" ] },
                { cells: ["showCount", "是否在右下角显示字数统计", "boolean", "false" ] },
                { cells: ["maxlength", "最大字符数；超出截断；showCount 时作为分母", "number?", "undefined" ] },
                { cells: ["onValueChange", "文本变化时触发；disabled / readonly 时不触发", "(value: string) => void", "空函数" ] },
                { cells: ["onFocus", "获得焦点时触发", "() => void", "空函数" ] },
                { cells: ["onBlur", "失去焦点时触发", "() => void", "空函数" ] },
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
                { cells: ["textarea.minHeight", "无内容时的最小高度（72vp，约三行）" ] },
                { cells: ["textarea.paddingHorizontal / textarea.paddingVertical", "内边距（12 / 12vp）" ] },
                { cells: ["textarea.fontSize", "输入字号（14）" ] },
                { cells: ["textarea.countFontSize", "字数统计字号（12）" ] },
                { cells: ["textarea.borderRadius / textarea.borderWidth", "圆角与描边宽度" ] },
                { cells: ["textarea.focusRingWidth", "聚焦环宽度" ] },
                { cells: ["typography.lineHeight.primary", "行高（1.8）" ] },
                { cells: ["color.text.primary / color.text.placeholder", "输入文字 / 占位文字色" ] },
                { cells: ["color.background.default / color.background.disabled", "底色 / 禁用底色" ] },
                { cells: ["color.border.base / color.focus", "描边色 / 聚焦色" ] },
                ],
              }
      ],
    },
    {
      title: "黄金用例对照",
      prose: [
        "cases/textarea.json 的 6 条断言与 hypium 测试的对应关系（entry/src/test/Textarea.test.ets）：",
        "另有暗色专项：dark_colors_come_from_dark_tokens / dimensions_are_identical_in_dark_mode。",
        "运行：DevEco Studio 右键 entry/src/test → Run Tests。",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                { cells: ["input-emits-onvaluechange", "输入触发 onValueChange", "disabled_is_not_interactive（gate 反向断言）" ] },
                { cells: ["disabled-blocks-input", "禁用态不响应输入", "disabled_is_not_interactive" ] },
                { cells: ["showcount-renders-count", "字数统计渲染 当前/上限", "showcount_renders_count_with_maxlength" ] },
                { cells: ["showcount-without-maxlength-renders-length-only", "无上限时只显示长度", "showcount_renders_length_only_without_maxlength" ] },
                { cells: ["focus-uses-focus-token", "聚焦态取 focus 令牌", "focus_uses_focus_token" ] },
                { cells: ["maxlength-truncates-input", "超出上限截断", "maxlength_truncates_input" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * Textarea 多行输入（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct TextareaDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: textareaEntry }) {
      DocSectionView({ section: textareaEntry.sections[0] }) {
        TextareaBasicPreview({ toast: this.toast })
      }
      DocSectionView({ section: textareaEntry.sections[1] }) {
        TextareaCountPreview({ toast: this.toast })
      }
      DocSectionView({ section: textareaEntry.sections[2] }) {
        // 「API」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: textareaEntry.sections[3] }) {
        // 「令牌对照」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: textareaEntry.sections[4] }) {
        // 「黄金用例对照」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
