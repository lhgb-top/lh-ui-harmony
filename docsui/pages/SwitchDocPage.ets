// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/switch.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/SwitchPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
import { SwitchBasicPreview, SwitchSizesPreview, SwitchStatesPreview } from '../previews/SwitchPreviews'

const switchEntry: DocEntry =
    {
      id: "switch",
      title: "Switch 开关",
      group: DocGroup.Form,
      lede: [
      "开关控件。点击翻转开合态，支持禁用与加载中遮罩。",
    ],
      contract: [
      "契约源：lh-ui-core/specs/switch.json ·",
      "黄金用例：lh-ui-core/cases/switch.json（6 条，已翻译为 hypium 测试）",
    ],
      sections: [
    {
      title: "基本用法",
      prose: [
        "checked 受控，点击翻转并触发 onChange 携带新开合态。滑块位移动画取",
        "motion.duration.base。",
      ],
      code: [
        "LhSwitch({",
        "  checked: this.enabled,",
        "  onChange: (checked: boolean) => { this.enabled = checked },",
        "})",
      ],
      tables: [],
    },
    {
      title: "尺寸",
      prose: [
        "三档尺寸映射到 switch.width / switch.height 令牌；轨道圆角与滑块偏移随高度换算。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "状态",
      prose: [
        "disabled 与 loading 都阻止切换（黄金用例 loading-blocks-change）；",
        "加载中时轨道中央显示平台指示器。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "API",
      prose: [
        "开轨底色 color.primary.default；关轨底色 color.background.disabled；",
        "滑块 color.onPrimary，直径 = 高度 − 2 × switch.gap。",
      ],
      code: [],
      tables: [
              {
                title: "Props",
                headers: ["属性", "说明", "类型", "默认值"],
                rows: [
                { cells: ["checked", "是否开启", "boolean", "false" ] },
                { cells: ["disabled", "是否禁用；禁用时不触发 onChange", "boolean", "false" ] },
                { cells: ["loading", "是否加载中；加载时不触发 onChange，轨道显示指示器", "boolean", "false" ] },
                { cells: ["size", "开关尺寸，映射到尺寸令牌", "LhSwitchSize", "Medium" ] },
                { cells: ["onChange", "点击切换时触发，携带新开合态", "(checked: boolean) => void", "空函数" ] },
                ],
              },
              {
                title: "LhSwitchSize",
                headers: ["值", "width", "height"],
                rows: [
                { cells: ["Small", "switch.width.small（36vp）", "switch.height.small（20vp）" ] },
                { cells: ["Medium", "switch.width.medium（44vp）", "switch.height.medium（24vp）" ] },
                { cells: ["Large", "switch.width.large（52vp）", "switch.height.large（28vp）" ] },
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
                { cells: ["switch.width.{small,medium,large}", "三档轨道宽度" ] },
                { cells: ["switch.height.{small,medium,large}", "三档轨道高度（圆角与滑块偏移据此换算）" ] },
                { cells: ["switch.gap", "滑块与轨道之间的留白（2vp）" ] },
                { cells: ["color.primary.default", "开轨底色" ] },
                { cells: ["color.background.disabled", "关轨底色" ] },
                { cells: ["color.onPrimary", "滑块色" ] },
                { cells: ["color.disabled.*", "禁用态色" ] },
                { cells: ["motion.duration.base", "滑块位移动画时长（300ms）" ] },
                ],
              }
      ],
    },
    {
      title: "黄金用例对照",
      prose: [
        "cases/switch.json 的 6 条断言与 hypium 测试的对应关系（entry/src/test/Switch.test.ets）：",
        "另有暗色专项：dark_colors_come_from_dark_tokens / dimensions_are_identical_in_dark_mode。",
        "运行：DevEco Studio 右键 entry/src/test → Run Tests。",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                { cells: ["tap-toggles-and-emits-onchange", "点击翻转并触发 onChange", "enabled_is_interactive" ] },
                { cells: ["tap-checked-turns-off", "开启态点击关闭", "thumb_offset_follows_checked（位移断言）" ] },
                { cells: ["disabled-blocks-change", "禁用态不触发 onChange", "disabled_is_not_interactive" ] },
                { cells: ["loading-blocks-change", "加载态不触发 onChange", "loading_is_not_interactive" ] },
                { cells: ["checked-uses-primary-token", "开轨消费主色令牌", "checked_uses_primary_token" ] },
                { cells: ["unchecked-uses-border-token", "关轨消费禁用底色令牌", "unchecked_uses_border_token" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * Switch 开关（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct SwitchDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: switchEntry }) {
      DocSectionView({ section: switchEntry.sections[0] }) {
        SwitchBasicPreview({ toast: this.toast })
      }
      DocSectionView({ section: switchEntry.sections[1] }) {
        SwitchSizesPreview({ toast: this.toast })
      }
      DocSectionView({ section: switchEntry.sections[2] }) {
        SwitchStatesPreview({ toast: this.toast })
      }
      DocSectionView({ section: switchEntry.sections[3] }) {
        // 「API」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: switchEntry.sections[4] }) {
        // 「令牌对照」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: switchEntry.sections[5] }) {
        // 「黄金用例对照」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
