// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/input.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/InputPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
import { InputBasicPreview, InputFocusAndSizesPreview, InputStatesAndClearablePreview } from '../previews/InputPreviews'

const inputEntry: DocEntry =
    {
      id: "input",
      title: "Input 输入框",
      group: DocGroup.Form,
      lede: [
      "单行文本输入。支持密码类型、三档尺寸、禁用 / 只读、清除按钮与字数上限。",
    ],
      contract: [
      "契约源：lh-ui-core/specs/input.json ·",
      "黄金用例：lh-ui-core/cases/input.json（8 条，已翻译为 hypium 测试）",
    ],
      sections: [
    {
      title: "基本用法",
      prose: [
        "value 受控，placeholder 取 color.text.placeholder 令牌。",
      ],
      code: [
        "LhInput({",
        "  value: this.text,",
        "  placeholder: '请输入内容',",
        "  clearable: true,",
        "  onValueChange: (value: string) => { this.text = value },",
        "})",
      ],
      tables: [],
    },
    {
      title: "聚焦与尺寸",
      prose: [
        "聚焦时描边切换为 color.focus 并叠加 input.focusRingWidth 宽度的聚焦环；",
        "三档尺寸映射到 input.height / paddingHorizontal / fontSize 令牌。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "状态与清除",
      prose: [
        "disabled 禁用输入且呈现禁用样式；clearable 在有值时显示清除按钮，",
        "点击触发 onValueChange('')；maxlength 超出时截断新输入。",
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
                { cells: ["type", "输入类型；密码类型映射到 ArkUI InputType.Password", "LhInputType", "Text" ] },
                { cells: ["size", "输入框尺寸，映射到尺寸令牌", "LhInputSize", "Medium" ] },
                { cells: ["disabled", "是否禁用；禁用时不响应输入、不触发 onValueChange", "boolean", "false" ] },
                { cells: ["readonly", "是否只读；只读时可聚焦但不接受输入", "boolean", "false" ] },
                { cells: ["clearable", "是否显示清除按钮（有值时）", "boolean", "false" ] },
                { cells: ["maxlength", "最大字符数；超出截断；为 undefined 时不限制", "number?", "undefined" ] },
                { cells: ["onValueChange", "文本变化时触发；disabled / readonly 时不触发", "(value: string) => void", "空函数" ] },
                { cells: ["onFocus", "获得焦点时触发", "() => void", "空函数" ] },
                { cells: ["onBlur", "失去焦点时触发", "() => void", "空函数" ] },
                ],
              },
              {
                title: "LhInputType",
                headers: ["值", "端侧落点"],
                rows: [
                { cells: ["Text", "ArkUI InputType.Normal" ] },
                { cells: ["Password", "ArkUI InputType.Password（掩码显示）" ] },
                ],
              },
              {
                title: "LhInputSize",
                headers: ["值", "height", "paddingHorizontal", "fontSize"],
                rows: [
                { cells: ["Small", "input.height.small（32vp）", "input.paddingHorizontal.small（12vp）", "input.fontSize.small（13）" ] },
                { cells: ["Medium", "input.height.medium（40vp）", "input.paddingHorizontal.medium（16vp）", "input.fontSize.medium（14）" ] },
                { cells: ["Large", "input.height.large（48vp）", "input.paddingHorizontal.large（20vp）", "input.fontSize.large（16）" ] },
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
                { cells: ["input.height.{small,medium,large}", "三档高度" ] },
                { cells: ["input.paddingHorizontal.{small,medium,large}", "三档横向内边距" ] },
                { cells: ["input.fontSize.{small,medium,large}", "三档字号" ] },
                { cells: ["input.borderRadius / input.borderWidth", "圆角与描边宽度" ] },
                { cells: ["input.focusRingWidth", "聚焦环宽度" ] },
                { cells: ["input.clearIconSize", "清除按钮尺寸（16vp）" ] },
                { cells: ["color.text.primary / color.text.placeholder", "输入文字 / 占位文字色" ] },
                { cells: ["color.background.default / color.background.disabled", "底色 / 禁用底色" ] },
                { cells: ["color.border.base / color.focus", "描边色 / 聚焦色" ] },
                { cells: ["color.disabled.text", "禁用文字色" ] },
                ],
              }
      ],
    },
    {
      title: "黄金用例对照",
      prose: [
        "cases/input.json 的 8 条断言与 hypium 测试的对应关系（entry/src/test/Input.test.ets）：",
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
                { cells: ["clearable-emits-empty-value", "清除触发空值回调", "clear_icon_uses_token（清除图标消费令牌）" ] },
                { cells: ["disabled-blocks-input", "禁用态不响应输入", "disabled_is_not_interactive" ] },
                { cells: ["readonly-blocks-input", "只读态不响应输入", "readonly_still_enabled_in_appearance" ] },
                { cells: ["placeholder-uses-placeholder-token", "占位文字取占位令牌", "placeholder_uses_placeholder_token" ] },
                { cells: ["focus-uses-focus-token", "聚焦态取 focus 令牌", "focus_uses_focus_token" ] },
                { cells: ["small-size-uses-small-tokens", "小号消费 small 尺寸令牌", "small_size_uses_small_tokens" ] },
                { cells: ["maxlength-truncates-input", "超出上限截断", "maxlength_truncates_input" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * Input 输入框（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct InputDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: inputEntry }) {
      DocSectionView({ section: inputEntry.sections[0] }) {
        InputBasicPreview({ toast: this.toast })
      }
      DocSectionView({ section: inputEntry.sections[1] }) {
        InputFocusAndSizesPreview({ toast: this.toast })
      }
      DocSectionView({ section: inputEntry.sections[2] }) {
        InputStatesAndClearablePreview({ toast: this.toast })
      }
      DocSectionView({ section: inputEntry.sections[3] }) {
        // 「API」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: inputEntry.sections[4] }) {
        // 「令牌对照」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: inputEntry.sections[5] }) {
        // 「黄金用例对照」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
