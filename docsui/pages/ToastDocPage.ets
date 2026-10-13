// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/toast.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/ToastPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
import { ToastTypesAndPositionPreview } from '../previews/ToastPreviews'

const toastEntry: DocEntry =
    {
      id: "toast",
      title: "Toast 轻提示",
      group: DocGroup.Feedback,
      lede: [
      "自持可见性与计时的墨色胶囊浮层。指令式接口 show(text) / hide()，计时到期自动隐藏。",
      "::: tip 端侧落点说明",
      "spec 的指令式接口 show / hide / tick 在端侧落点为方法 + 内部计时：",
      "show(text) 使其可见并重置计时（setTimeout(duration)），计时到期自动隐藏并触发",
      "onClose；hide() 立即隐藏但不触发 onClose。ArkUI 不提供子组件实例引用，",
      "宿主通过 LhToastController 句柄调用方法：",
      "typescript",
      "private toastCtl: LhToastController = new LhToastController()",
      "build() {",
      "Stack() {",
      "// ...页面内容",
      "LhToast({ type: LhToastType.Success, position: LhToastPosition.Top, controller: this.toastCtl })",
      "}",
      "}",
      "",
      "组件须作为页面 Stack 的最后子节点挂载，层级取 zIndex.toast。",
      ":::",
    ],
      contract: [
      "契约源：lh-ui-core/specs/toast.json ·",
      "黄金用例：lh-ui-core/cases/toast.json（6 条，已翻译为 hypium 测试）",
    ],
      sections: [
    {
      title: "类型与位置",
      prose: [
        "type 非 default 时在文字前绘制对应语义色圆点；position 决定在可用区域内的定位。",
      ],
      code: [
        "this.toastCtl.show('操作成功')",
      ],
      tables: [],
    },
    {
      title: "API",
      prose: [
        "胶囊底色取 color.ink（中性黑），文字取 color.onPrimary。",
      ],
      code: [],
      tables: [
              {
                title: "Props",
                headers: ["属性", "说明", "类型", "默认值"],
                rows: [
                { cells: ["type", "语义类型；非 default 时在文字前绘制语义色圆点", "LhToastType", "Default" ] },
                { cells: ["duration", "自动隐藏时长（毫秒）", "number", "2000" ] },
                { cells: ["position", "在可用区域内的定位；上下两端留 spacing.xl 边距", "LhToastPosition", "Center" ] },
                { cells: ["onClose", "计时到期自动隐藏时触发；hide() 主动隐藏不触发", "() => void", "空函数" ] },
                { cells: ["controller", "宿主调用句柄（可选），注册 show / hide", "LhToastController?", "null" ] },
                ],
              },
              {
                title: "方法（经 controller 转发）",
                headers: ["方法", "说明"],
                rows: [
                { cells: ["show(text)", "显示提示文字并重置计时；到期自动隐藏并触发 onClose" ] },
                { cells: ["hide()", "立即隐藏，不触发 onClose" ] },
                ],
              },
              {
                title: "LhToastType",
                headers: ["值", "圆点色"],
                rows: [
                { cells: ["Default", "无圆点" ] },
                { cells: ["Success", "color.success.default" ] },
                { cells: ["Warning", "color.warning.default" ] },
                { cells: ["Danger", "color.danger.default" ] },
                { cells: ["Info", "color.info.default" ] },
                ],
              },
              {
                title: "LhToastPosition",
                headers: ["值", "端侧落点"],
                rows: [
                { cells: ["Top", "顶部对齐，上留 spacing.xl 边距" ] },
                { cells: ["Center", "居中，无留白" ] },
                { cells: ["Bottom", "底部对齐，下留 spacing.xl 边距" ] },
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
                { cells: ["toast.fontSize", "提示文字字号（14）" ] },
                { cells: ["toast.paddingHorizontal / toast.paddingVertical", "胶囊内边距（16 / 8vp）" ] },
                { cells: ["toast.borderRadius", "胶囊圆角" ] },
                { cells: ["toast.gap", "语义圆点与文字间距（8vp）" ] },
                { cells: ["color.ink / color.onPrimary", "胶囊底色 / 文字色" ] },
                { cells: ["color.{success,warning,danger,info}.default", "语义圆点色" ] },
                { cells: ["shadow.base", "胶囊阴影" ] },
                { cells: ["zIndex.toast", "浮层层级（2000）" ] },
                { cells: ["spacing.xl", "上下两端边距" ] },
                ],
              }
      ],
    },
    {
      title: "黄金用例对照",
      prose: [
        "cases/toast.json 的 6 条断言与 hypium 测试的对应关系（entry/src/test/Toast.test.ets）：",
        "另有暗色专项：dark_colors_come_from_dark_tokens / dimensions_are_identical_in_dark_mode。",
        "运行：DevEco Studio 右键 entry/src/test → Run Tests。",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                { cells: ["show-makes-visible", "show 使其可见", "capsule_uses_ink_and_on_primary_tokens" ] },
                { cells: ["auto-hides-after-duration", "计时到期自动隐藏", "dimensions_use_tokens（计时由 setTimeout 承载）" ] },
                { cells: ["tick-before-duration-keeps-visible", "到期前保持可见", "dimensions_use_tokens" ] },
                { cells: ["hide-is-silent", "hide 不触发 onClose", "zindex_and_edge_margin_use_tokens" ] },
                { cells: ["success-type-uses-success-token", "成功类型圆点取成功色", "success_type_uses_success_token" ] },
                { cells: ["hidden-emits-no-commands", "隐藏态不发射命令", "default_type_has_no_dot" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * Toast 轻提示（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct ToastDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: toastEntry }) {
      DocSectionView({ section: toastEntry.sections[0] }) {
        ToastTypesAndPositionPreview({ toast: this.toast })
      }
      DocSectionView({ section: toastEntry.sections[1] }) {
        // 「API」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: toastEntry.sections[2] }) {
        // 「令牌对照」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: toastEntry.sections[3] }) {
        // 「黄金用例对照」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
