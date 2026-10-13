// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/radio.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/RadioPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
import { RadioBasicPreview, RadioSizesPreview } from '../previews/RadioPreviews'

const radioEntry: DocEntry =
    {
      id: "radio",
      title: "Radio 单选框",
      group: DocGroup.Form,
      lede: [
      "单选控件原子。组件本身不含组逻辑，由宿主维护单选组（value + checked）。",
    ],
      contract: [
      "契约源：lh-ui-core/specs/radio.json ·",
      "黄金用例：lh-ui-core/cases/radio.json（6 条，已翻译为 hypium 测试）",
    ],
      sections: [
    {
      title: "基本用法",
      prose: [
        "由未选中变为选中时触发 onChange(true)；已选中时点击不触发（黄金用例",
        "tap-checked-keeps-checked）。单选组由宿主维护：",
      ],
      code: [
        "LhRadio({",
        "  label: '选项一',",
        "  value: 'a',",
        "  checked: this.picked === 'a',",
        "  onChange: () => { this.picked = 'a' },",
        "})",
      ],
      tables: [],
    },
    {
      title: "尺寸",
      prose: [
        "三档尺寸映射到 radio.size 令牌；内圆点直径按 radio.dotScale（50%）等比缩放。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "API",
      prose: [
        "选中态：外环描边 color.primary.default，内圆点同色，直径 = 外环尺寸 × radio.dotScale；",
        "未选中态描边 color.border.base；禁用态取 color.disabled.*。",
      ],
      code: [],
      tables: [
              {
                title: "Props",
                headers: ["属性", "说明", "类型", "默认值"],
                rows: [
                { cells: ["checked", "是否选中", "boolean", "false" ] },
                { cells: ["disabled", "是否禁用；禁用时不触发 onChange", "boolean", "false" ] },
                { cells: ["label", "文字标签", "string", "''" ] },
                { cells: ["value", "该选项的值（宿主据此维护单选组）", "string", "''" ] },
                { cells: ["size", "单选框尺寸，映射到 radio.size 令牌", "LhRadioSize", "Medium" ] },
                { cells: ["onChange", "由未选中变为选中时触发 (true)；已选中不触发", "(checked: boolean) => void", "空函数" ] },
                ],
              },
              {
                title: "LhRadioSize",
                headers: ["值", "size"],
                rows: [
                { cells: ["Small", "radio.size.small（16vp）" ] },
                { cells: ["Medium", "radio.size.medium（20vp）" ] },
                { cells: ["Large", "radio.size.large（24vp）" ] },
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
                { cells: ["radio.size.{small,medium,large}", "三档外环尺寸" ] },
                { cells: ["radio.ringWidth", "外环描边宽度（2vp）" ] },
                { cells: ["radio.dotScale", "内圆点相对外环直径的比例（50% 分数）" ] },
                { cells: ["radio.gap", "外环与文字间距（8vp）" ] },
                { cells: ["color.primary.default", "选中描边与圆点色" ] },
                { cells: ["color.border.base", "未选中描边色" ] },
                { cells: ["color.disabled.{text,border}", "禁用态色" ] },
                { cells: ["typography.fontSize.base", "标签字号" ] },
                ],
              }
      ],
    },
    {
      title: "黄金用例对照",
      prose: [
        "cases/radio.json 的 6 条断言与 hypium 测试的对应关系（entry/src/test/Radio.test.ets）：",
        "另有暗色专项：dark_colors_come_from_dark_tokens / dimensions_are_identical_in_dark_mode。",
        "运行：DevEco Studio 右键 entry/src/test → Run Tests。",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                { cells: ["tap-unchecked-emits-onchange", "未选中点击触发 onChange", "unchecked_is_interactive" ] },
                { cells: ["tap-checked-keeps-checked", "已选中点击不触发", "checked_still_interactive_but_component_gates" ] },
                { cells: ["disabled-blocks-change", "禁用态不触发 onChange", "disabled_is_not_interactive" ] },
                { cells: ["checked-uses-primary-tokens", "选中态消费主色令牌", "checked_uses_primary_tokens" ] },
                { cells: ["unchecked-uses-border-token", "未选中态消费描边令牌", "unchecked_uses_border_token" ] },
                { cells: ["small-size-uses-small-token", "小号取 small 尺寸令牌", "small_size_uses_small_token / dot_size_scales_with_size_token" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * Radio 单选框（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct RadioDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: radioEntry }) {
      DocSectionView({ section: radioEntry.sections[0] }) {
        RadioBasicPreview({ toast: this.toast })
      }
      DocSectionView({ section: radioEntry.sections[1] }) {
        RadioSizesPreview({ toast: this.toast })
      }
      DocSectionView({ section: radioEntry.sections[2] }) {
        // 「API」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: radioEntry.sections[3] }) {
        // 「令牌对照」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: radioEntry.sections[4] }) {
        // 「黄金用例对照」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
