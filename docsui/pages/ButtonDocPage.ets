// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/button.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/ButtonPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
import { ButtonTypesPreview, ButtonSizesPreview, ButtonStatesPreview, ButtonIconAndPatternPreview, ButtonThemePreview } from '../previews/ButtonPreviews'

const buttonEntry: DocEntry =
    {
      id: "button",
      title: "Button 按钮",
      group: DocGroup.Basic,
      lede: [
      "基础操作按钮。触发即时操作，支持类型、尺寸、加载、禁用、图标与国风花纹底。",
    ],
      contract: [
      "契约源：lh-ui-core/specs/button.json ·",
      "黄金用例：lh-ui-core/cases/button.json（8 条，已翻译为 hypium 测试）",
    ],
      sections: [
    {
      title: "类型",
      prose: [
        "六种类型决定底色与文字色。",
      ],
      code: [
        "LhButton({ onClick: () => {}, type: LhButtonType.Primary, text: '主要按钮' })",
      ],
      tables: [],
    },
    {
      title: "尺寸",
      prose: [
        "三档尺寸映射到 button.height / paddingHorizontal / fontSize / iconSize 令牌。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "状态",
      prose: [
        "禁用与加载中都不触发 onClick；两者共存时按禁用优先处理（黄金用例 disabled-precedes-loading）。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "图标与花纹底",
      prose: [
        "图标名按本地图标体系解析（LhButtonTokens.iconFor，当前支持 search / refresh / check / close，",
        "未登记名不绘制）。花纹底消费 color.decoration 令牌，Canvas 绘制 45° 斜纹。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "明暗主题",
      prose: [
        "切换站点右上角主题，模拟器手机框内的按钮颜色即变；真机通过 LhTheme.apply(true) 切换。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "API",
      prose: [
        "禁用态覆盖：底色 color.disabled.bg、文字 color.disabled.text、描边 color.disabled.border。",
      ],
      code: [],
      tables: [
              {
                title: "Props",
                headers: ["属性", "说明", "类型", "默认值"],
                rows: [
                { cells: ["onClick", "点击回调；disabled 或 loading 为 true 时不触发", "() => void", "空函数" ] },
                { cells: ["type", "按钮类型，决定底色与文字色", "LhButtonType", "Default" ] },
                { cells: ["size", "按钮尺寸，映射到尺寸令牌", "LhButtonSize", "Medium" ] },
                { cells: ["disabled", "是否禁用", "boolean", "false" ] },
                { cells: ["loading", "是否加载中（显示指示器，不触发 onClick）", "boolean", "false" ] },
                { cells: ["icon", "图标名（本地图标体系解析）", "string?", "undefined" ] },
                { cells: ["bgPattern", "是否绘制国风花纹底纹", "boolean", "false" ] },
                { cells: ["text", "按钮文字内容（spec 的 default 插槽）", "string", "''" ] },
                ],
              },
              {
                title: "LhButtonType",
                headers: ["值", "底色", "文字色"],
                rows: [
                { cells: ["Default", "color.background.default", "color.text.primary" ] },
                { cells: ["Primary", "color.primary.default", "color.onPrimary" ] },
                { cells: ["Success", "color.success.default", "color.onPrimary" ] },
                { cells: ["Warning", "color.warning.default", "color.onPrimary" ] },
                { cells: ["Danger", "color.danger.default", "color.onPrimary" ] },
                { cells: ["Info", "color.info.default", "color.onPrimary" ] },
                ],
              },
              {
                title: "LhButtonSize",
                headers: ["值", "height", "paddingHorizontal", "fontSize", "iconSize"],
                rows: [
                { cells: ["Small", "button.height.small（32vp）", "button.paddingHorizontal.small（16vp）", "button.fontSize.small（13）", "button.iconSize.small（16）" ] },
                { cells: ["Medium", "button.height.medium（40vp）", "button.paddingHorizontal.medium（20vp）", "button.fontSize.medium（14）", "button.iconSize.medium（18）" ] },
                { cells: ["Large", "button.height.large（48vp）", "button.paddingHorizontal.large（24vp）", "button.fontSize.large（16）", "button.iconSize.large（20）" ] },
                ],
              }
      ],
    },
    {
      title: "令牌对照",
      prose: [
        "按钮消费的令牌（与 specs/button.json 的 tokenRefs 逐条对齐）：",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["令牌", "用途"],
                rows: [
                { cells: ["button.height.{small,medium,large}", "三档高度" ] },
                { cells: ["button.paddingHorizontal.{small,medium,large}", "三档横向内边距" ] },
                { cells: ["button.fontSize.{small,medium,large}", "三档字号" ] },
                { cells: ["button.iconSize.{small,medium,large}", "三档图标尺寸" ] },
                { cells: ["button.borderRadius / button.borderWidth", "圆角（跟随 radius.base）与描边宽度" ] },
                { cells: ["button.fontWeight", "字重（跟随 typography.fontWeight.primary，端侧映射 FontWeight）" ] },
                { cells: ["color.primary.default / color.onPrimary", "主色类型底/文字" ] },
                { cells: ["color.{success,warning,danger,info}.default", "语义类型底色" ] },
                { cells: ["color.background.default / color.text.primary / color.border.base", "默认类型底/文字/描边" ] },
                { cells: ["color.disabled.{bg,text,border}", "禁用态三色" ] },
                { cells: ["color.decoration", "花纹底纹色" ] },
                { cells: ["shadow.lighter", "默认 elevation（LhTokens.Shadow.lighter）" ] },
                ],
              }
      ],
    },
    {
      title: "黄金用例对照",
      prose: [
        "cases/button.json 的 8 条断言与 hypium 测试的对应关系（entry/src/test/Button.test.ets）：",
        "另有暗色专项：dark_colors_come_from_dark_tokens / dimensions_are_identical_in_dark_mode。",
        "运行：DevEco Studio 右键 entry/src/test → Run Tests。",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                { cells: ["click-emits-onclick", "gate 放行（可交互）", "enabled_button_is_interactive" ] },
                { cells: ["disabled-blocks-click", "禁用态不可交互", "disabled_is_not_interactive" ] },
                { cells: ["loading-blocks-click", "加载态不可交互", "loading_is_not_interactive" ] },
                { cells: ["disabled-precedes-loading", "禁用优先 + 禁用样式", "disabled_precedes_loading" ] },
                { cells: ["default-type-renders-text", "默认类型中性底/文字", "default_type_uses_neutral_tokens" ] },
                { cells: ["primary-type-uses-primary-tokens", "主色类型消费主色令牌", "primary_type_uses_primary_tokens" ] },
                { cells: ["small-size-uses-small-tokens", "小号消费 small 尺寸令牌", "small_size_uses_small_tokens" ] },
                { cells: ["bgpattern-uses-decoration-token", "花纹底消费装饰色", "bgpattern_uses_decoration_token" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * Button 按钮（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct ButtonDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: buttonEntry }) {
      DocSectionView({ section: buttonEntry.sections[0] }) {
        ButtonTypesPreview({ toast: this.toast })
      }
      DocSectionView({ section: buttonEntry.sections[1] }) {
        ButtonSizesPreview({ toast: this.toast })
      }
      DocSectionView({ section: buttonEntry.sections[2] }) {
        ButtonStatesPreview({ toast: this.toast })
      }
      DocSectionView({ section: buttonEntry.sections[3] }) {
        ButtonIconAndPatternPreview({ toast: this.toast })
      }
      DocSectionView({ section: buttonEntry.sections[4] }) {
        ButtonThemePreview({ toast: this.toast })
      }
      DocSectionView({ section: buttonEntry.sections[5] }) {
        // 「API」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: buttonEntry.sections[6] }) {
        // 「令牌对照」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: buttonEntry.sections[7] }) {
        // 「黄金用例对照」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
