// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/picker.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/PickerPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
import { PickerBasicPreview } from '../previews/PickerPreviews'

const pickerEntry: DocEntry =
    {
      id: "picker",
      title: "Picker 选择器",
      group: DocGroup.Form,
      lede: [
      "底部弹层单列滚轮选择器。候选项为字符串数组，选中值为索引。",
      "::: tip 声明式可见性",
      "visible 为 false 时不渲染任何内容；确认 / 取消后触发 onClose，宿主据此置回 false。",
      "组件须作为页面 Stack 的最后子节点挂载。value 为选中项索引（0 基），",
      "越界时钳制到候选项范围内（黄金用例 clamp-*）。",
      ":::",
    ],
      contract: [
      "契约源：lh-ui-core/specs/picker.json ·",
      "黄金用例：lh-ui-core/cases/picker.json（8 条，已翻译为 hypium 测试）",
    ],
      sections: [
    {
      title: "基本用法",
      prose: [
        "滚轮选中项随拖动实时更新（onValueChange），确认时携带当前索引触发 onConfirm。",
      ],
      code: [
        "LhPicker({",
        "  visible: this.pickerVisible,",
        "  options: ['选项一', '选项二', '选项三'],",
        "  value: this.pickedIndex,",
        "  title: '请选择',",
        "  onValueChange: (value: number) => { this.pickedIndex = value },",
        "  onConfirm: (value: number) => { this.pickedIndex = value },",
        "  onCancel: () => {},",
        "  onClose: () => { this.pickerVisible = false },",
        "})",
      ],
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
                { cells: ["visible", "是否显示；为 false 时不渲染任何内容", "boolean", "false" ] },
                { cells: ["options", "候选项文本数组（单列）", "string[]", "[]" ] },
                { cells: ["value", "选中项索引（0 基）；越界钳制到候选项范围内", "number", "0" ] },
                { cells: ["title", "工具栏中间的标题", "string", "''" ] },
                { cells: ["confirmText", "确认按钮文字", "string", "'确认'" ] },
                { cells: ["cancelText", "取消按钮文字", "string", "'取消'" ] },
                { cells: ["onValueChange", "滚轮停止且选中项变化时触发", "(value: number) => void", "空函数" ] },
                { cells: ["onConfirm", "点击确认时触发，携带当前选中索引（随后触发 onClose）", "(value: number) => void", "空函数" ] },
                { cells: ["onCancel", "点击取消时触发（随后触发 onClose）", "() => void", "空函数" ] },
                { cells: ["onClose", "确认 / 取消后触发", "() => void", "空函数" ] },
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
                { cells: ["picker.height", "面板高度（260vp）" ] },
                { cells: ["picker.toolbarHeight", "顶部工具栏高度（44vp）" ] },
                { cells: ["picker.itemHeight", "候选项高度（滚轮单页高度，40vp）" ] },
                { cells: ["picker.itemFontSize", "候选项字号（14）" ] },
                { cells: ["picker.borderRadius", "面板顶部圆角" ] },
                { cells: ["color.background.default / color.background.overlay", "面板底色 / 遮罩色" ] },
                { cells: ["color.text.primary / color.text.secondary", "选中项 / 相邻项文字色" ] },
                { cells: ["color.primary.default", "确认按钮与选中项高亮色" ] },
                { cells: ["color.border.lighter", "工具栏与滚轮选中区分隔线" ] },
                { cells: ["shadow.base", "面板阴影" ] },
                { cells: ["zIndex.modalBackdrop / zIndex.modal", "遮罩 / 弹层层级" ] },
                { cells: ["typography.fontSize.medium / fontSize.base", "标题 / 按钮字号" ] },
                ],
              }
      ],
    },
    {
      title: "黄金用例对照",
      prose: [
        "cases/picker.json 的 8 条断言与 hypium 测试的对应关系（entry/src/test/Picker.test.ets）：",
        "另有暗色专项：dark_colors_come_from_dark_tokens / dimensions_are_identical_in_dark_mode。",
        "运行：DevEco Studio 右键 entry/src/test → Run Tests。",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                { cells: ["confirm-emits-onconfirm-with-value", "确认携带当前值触发 onConfirm", "resolve_clamps_selected_index" ] },
                { cells: ["confirm-also-emits-onclose", "确认同时触发 onClose", "toolbar_colors_use_tokens" ] },
                { cells: ["cancel-emits-oncancel", "取消触发 onCancel", "toolbar_colors_use_tokens" ] },
                { cells: ["scroll-emits-onvaluechange", "滚轮变化触发 onValueChange", "wheel_height_minus_toolbar" ] },
                { cells: ["clamp-negative-value-to-zero", "负索引钳制到 0", "clamp_negative_value_to_zero" ] },
                { cells: ["clamp-overflow-value-to-last", "溢出索引钳制到末项", "clamp_overflow_value_to_last" ] },
                { cells: ["title-renders-text", "标题渲染文字", "toolbar_colors_use_tokens" ] },
                { cells: ["hidden-not-rendered", "隐藏时不渲染", "overlay_and_zindex_use_tokens（visible gate）" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * Picker 选择器（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct PickerDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: pickerEntry }) {
      DocSectionView({ section: pickerEntry.sections[0] }) {
        PickerBasicPreview({ toast: this.toast })
      }
      DocSectionView({ section: pickerEntry.sections[1] }) {
        // 「API」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: pickerEntry.sections[2] }) {
        // 「令牌对照」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: pickerEntry.sections[3] }) {
        // 「黄金用例对照」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
