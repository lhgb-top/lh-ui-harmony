// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/dialog.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/DialogPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
import { DialogBasicPreview, DialogTypesPreview } from '../previews/DialogPreviews'

const dialogEntry: DocEntry =
    {
      id: "dialog",
      title: "Dialog 对话框",
      group: DocGroup.Feedback,
      lede: [
      "声明式模态对话框。标题 + 内容 + 确认 / 取消按钮，遮罩层与卡片分层渲染。",
      "::: tip 声明式可见性",
      "visible 为 false 时不渲染任何内容。确认 / 取消后组件触发 onClose，",
      "宿主据此把 visible 置回 false（与 react 的 open / onClose 同构）。",
      "组件须作为页面 Stack 的最后子节点挂载，层级由 zIndex 令牌承担。",
      ":::",
    ],
      contract: [
      "契约源：lh-ui-core/specs/dialog.json ·",
      "黄金用例：lh-ui-core/cases/dialog.json（8 条，已翻译为 hypium 测试）",
    ],
      sections: [
    {
      title: "基本用法",
      prose: [],
      code: [
        "LhDialog({",
        "  visible: this.dialogVisible,",
        "  title: '删除确认',",
        "  content: '删除后不可恢复，确定要删除这条记录吗？',",
        "  type: LhDialogType.Warning,",
        "  closable: true,",
        "  onConfirm: () => {},",
        "  onCancel: () => {},",
        "  onClose: () => { this.dialogVisible = false },",
        "})",
      ],
      tables: [],
    },
    {
      title: "类型",
      prose: [
        "type 决定确认按钮的语义类型（映射到 LhButtonType）；危险类型确认按钮取危险色。",
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
                { cells: ["visible", "是否显示；为 false 时不渲染任何内容", "boolean", "false" ] },
                { cells: ["title", "标题", "string", "''" ] },
                { cells: ["content", "正文内容", "string", "''" ] },
                { cells: ["type", "语义类型，决定确认按钮的类型", "LhDialogType", "Default" ] },
                { cells: ["confirmText", "确认按钮文字", "string", "'确认'" ] },
                { cells: ["cancelText", "取消按钮文字", "string", "'取消'" ] },
                { cells: ["closable", "点击遮罩区域是否触发 onClose", "boolean", "false" ] },
                { cells: ["onConfirm", "点击确认按钮时触发（随后触发 onClose）", "() => void", "空函数" ] },
                { cells: ["onCancel", "点击取消按钮时触发（随后触发 onClose）", "() => void", "空函数" ] },
                { cells: ["onClose", "确认 / 取消 / 点击可关闭遮罩后触发", "() => void", "空函数" ] },
                ],
              },
              {
                title: "LhDialogType",
                headers: ["值", "确认按钮类型"],
                rows: [
                { cells: ["Default", "LhButtonType.Default" ] },
                { cells: ["Primary", "LhButtonType.Primary" ] },
                { cells: ["Success", "LhButtonType.Success" ] },
                { cells: ["Warning", "LhButtonType.Warning" ] },
                { cells: ["Danger", "LhButtonType.Danger" ] },
                { cells: ["Info", "LhButtonType.Info" ] },
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
                { cells: ["dialog.width", "内容卡宽度（320vp）" ] },
                { cells: ["dialog.paddingHorizontal / dialog.paddingVertical", "卡片内边距（20 / 20vp）" ] },
                { cells: ["dialog.titleFontSize / dialog.contentFontSize", "标题 / 正文字号（16 / 14）" ] },
                { cells: ["dialog.gap", "标题与正文、正文与按钮组的间距（12vp）" ] },
                { cells: ["dialog.borderRadius", "卡片圆角" ] },
                { cells: ["color.background.default / color.background.overlay", "卡片底色 / 遮罩色" ] },
                { cells: ["color.text.primary / color.text.regular", "标题 / 正文色" ] },
                { cells: ["shadow.base", "卡片阴影" ] },
                { cells: ["zIndex.modalBackdrop / zIndex.modal", "遮罩 / 弹层层级" ] },
                ],
              }
      ],
    },
    {
      title: "黄金用例对照",
      prose: [
        "cases/dialog.json 的 8 条断言与 hypium 测试的对应关系（entry/src/test/Dialog.test.ets）：",
        "另有暗色专项：dark_colors_come_from_dark_tokens / dimensions_are_identical_in_dark_mode。",
        "运行：DevEco Studio 右键 entry/src/test → Run Tests。",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                { cells: ["confirm-emits-onconfirm", "确认触发 onConfirm", "confirm_button_type_maps_from_dialog_type" ] },
                { cells: ["cancel-emits-oncancel", "取消触发 onCancel", "type_variants_map_to_button_types" ] },
                { cells: ["confirm-also-emits-onclose", "确认同时触发 onClose", "type_variants_map_to_button_types" ] },
                { cells: ["closable-overlay-emits-onclose", "可关闭遮罩点击触发 onClose", "overlay_and_zindex_use_tokens" ] },
                { cells: ["not-closable-blocks-overlay-close", "不可关闭遮罩吞掉点击", "overlay_and_zindex_use_tokens" ] },
                { cells: ["hidden-not-rendered", "隐藏时不渲染", "card_dimensions_use_tokens（visible gate）" ] },
                { cells: ["title-renders-text", "标题消费字号令牌", "title_and_content_use_font_tokens" ] },
                { cells: ["danger-type-uses-danger-token", "危险类型确认按钮取危险色", "danger_type_uses_danger_token" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * Dialog 对话框（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct DialogDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: dialogEntry }) {
      DocSectionView({ section: dialogEntry.sections[0] }) {
        DialogBasicPreview({ toast: this.toast })
      }
      DocSectionView({ section: dialogEntry.sections[1] }) {
        DialogTypesPreview({ toast: this.toast })
      }
      DocSectionView({ section: dialogEntry.sections[2] }) {
        // 「API」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: dialogEntry.sections[3] }) {
        // 「令牌对照」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: dialogEntry.sections[4] }) {
        // 「黄金用例对照」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
