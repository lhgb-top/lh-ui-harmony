// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/navbar.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/NavbarPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
import { NavbarBasicPreview, NavbarIconAndBorderlessPreview } from '../previews/NavbarPreviews'

const navbarEntry: DocEntry =
    {
      id: "navbar",
      title: "Navbar 导航栏",
      group: DocGroup.Navigation,
      lede: [
      "页面顶部导航栏。左侧 / 标题 / 右侧三段式布局，标题居中，支持图标与底部分隔线。",
    ],
      contract: [
      "契约源：lh-ui-core/specs/navbar.json ·",
      "黄金用例：lh-ui-core/cases/navbar.json（6 条，已翻译为 hypium 测试）",
    ],
      sections: [
    {
      title: "基本用法",
      prose: [
        "title 居中，leftText / rightText 分列两侧；leftIcon / rightIcon 在文字旁绘制图标。",
      ],
      code: [
        "LhNavbar({",
        "  title: '页面标题',",
        "  leftText: '返回',",
        "  leftIcon: 'back',",
        "  rightText: '更多',",
        "  onLeftClick: () => {},",
        "  onRightClick: () => {},",
        "})",
      ],
      tables: [],
    },
    {
      title: "纯图标与无分隔线",
      prose: [
        "bordered 为 false 时不绘制底部分隔线；左右两侧均可只放图标。",
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
                { cells: ["title", "标题（居中）", "string", "''" ] },
                { cells: ["leftText", "左侧文字", "string", "''" ] },
                { cells: ["leftIcon", "左侧图标名（本地图形体系渲染）", "string?", "undefined" ] },
                { cells: ["rightText", "右侧文字", "string", "''" ] },
                { cells: ["rightIcon", "右侧图标名", "string?", "undefined" ] },
                { cells: ["bordered", "是否绘制底部分隔线", "boolean", "true" ] },
                { cells: ["onLeftClick", "点击左侧区域时触发；无左侧内容时不触发", "() => void", "空函数" ] },
                { cells: ["onRightClick", "点击右侧区域时触发；无右侧内容时不触发", "() => void", "空函数" ] },
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
                { cells: ["navbar.height", "导航栏高度（44vp）" ] },
                { cells: ["navbar.paddingHorizontal", "左右内边距（12vp）" ] },
                { cells: ["navbar.titleFontSize", "标题字号（16）" ] },
                { cells: ["navbar.iconSize", "左右图标尺寸（20vp）" ] },
                { cells: ["navbar.borderWidth", "底部分隔线宽度" ] },
                { cells: ["color.background.default", "导航栏底色" ] },
                { cells: ["color.text.primary", "标题与两侧文字色" ] },
                { cells: ["color.border.lighter", "底部分隔线色" ] },
                { cells: ["typography.fontWeight.bold", "标题字重" ] },
                { cells: ["zIndex.sticky", "吸顶层级（fixed 场景）" ] },
                ],
              }
      ],
    },
    {
      title: "黄金用例对照",
      prose: [
        "cases/navbar.json 的 6 条断言与 hypium 测试的对应关系（entry/src/test/Navbar.test.ets）：",
        "另有暗色专项：dark_colors_come_from_dark_tokens / dimensions_are_identical_in_dark_mode。",
        "运行：DevEco Studio 右键 entry/src/test → Run Tests。",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                { cells: ["title-renders-text", "标题渲染文字", "title_color_uses_text_primary_token" ] },
                { cells: ["leftclick-emits-onleftclick", "点击左侧触发 onLeftClick", "dimensions_use_tokens" ] },
                { cells: ["rightclick-emits-onrightclick", "点击右侧触发 onRightClick", "dimensions_use_tokens" ] },
                { cells: ["no-left-content-no-onleftclick", "无左侧内容时不触发", "dimensions_use_tokens（内容 gate）" ] },
                { cells: ["bordered-uses-border-token", "分隔线消费描边令牌", "bordered_uses_border_token" ] },
                { cells: ["height-uses-navbar-height-token", "高度消费 navbar.height 令牌", "height_uses_navbar_height_token" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * Navbar 导航栏（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct NavbarDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: navbarEntry }) {
      DocSectionView({ section: navbarEntry.sections[0] }) {
        NavbarBasicPreview({ toast: this.toast })
      }
      DocSectionView({ section: navbarEntry.sections[1] }) {
        NavbarIconAndBorderlessPreview({ toast: this.toast })
      }
      DocSectionView({ section: navbarEntry.sections[2] }) {
        // 「API」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: navbarEntry.sections[3] }) {
        // 「令牌对照」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: navbarEntry.sections[4] }) {
        // 「黄金用例对照」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
