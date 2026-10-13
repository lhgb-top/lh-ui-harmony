// 本文件由 scripts/gen-doc-pages.mjs 从 docs/guide/quickstart.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/GuideQuickstartPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'

const quickstartEntry: DocEntry =
    {
      id: "quickstart",
      title: "快速开始",
      group: DocGroup.Guide,
      lede: [],
      contract: [],
      sections: [
    {
      title: "最小示例",
      prose: [
        "LhTheme.apply(isDark) 把色板序列化进 AppStorage，所有 Lh 组件自动消费；不调用时回退明色板。",
      ],
      code: [
        "import { LhButton } from '../components/button/Index'",
        "import { LhButtonType } from '../components/button/LhButtonTokens'",
        "import { LhTheme } from '../common/theme/LhThemeApply'",
        "",
        "@Entry",
        "@Component",
        "struct Demo {",
        "  aboutToAppear(): void {",
        "    LhTheme.apply(false) // 注入明色板；切暗色传 true",
        "  }",
        "",
        "  build() {",
        "    Column() {",
        "      LhButton({",
        "        onClick: () => { /* 处理点击 */ },",
        "        type: LhButtonType.Primary,",
        "        text: '主要按钮',",
        "      })",
        "    }",
        "  }",
        "}",
      ],
      tables: [],
    },
    {
      title: "类型与尺寸",
      prose: [],
      code: [
        "// 六种类型",
        "LhButton({ onClick: () => {}, text: '默认' })                        // Default",
        "LhButton({ onClick: () => {}, type: LhButtonType.Primary, text: '主要' })",
        "LhButton({ onClick: () => {}, type: LhButtonType.Success, text: '成功' })",
        "LhButton({ onClick: () => {}, type: LhButtonType.Warning, text: '警告' })",
        "LhButton({ onClick: () => {}, type: LhButtonType.Danger, text: '危险' })",
        "LhButton({ onClick: () => {}, type: LhButtonType.Info, text: '信息' })",
        "",
        "// 三种尺寸",
        "LhButton({ onClick: () => {}, size: LhButtonSize.Small, text: '小型' })",
        "LhButton({ onClick: () => {}, size: LhButtonSize.Medium, text: '中型' })",
        "LhButton({ onClick: () => {}, size: LhButtonSize.Large, text: '大型' })",
      ],
      tables: [],
    },
    {
      title: "状态",
      prose: [],
      code: [
        "// 禁用：不响应点击（.enabled 拦截），呈现禁用样式",
        "LhButton({ onClick: () => {}, disabled: true, text: '禁用' })",
        "",
        "// 加载中：显示指示器，不触发 onClick",
        "LhButton({ onClick: () => {}, loading: true, text: '加载中' })",
        "",
        "// 两者共存：按禁用优先处理（黄金用例 disabled-precedes-loading）",
        "LhButton({ onClick: () => {}, disabled: true, loading: true, text: '禁用优先' })",
      ],
      tables: [],
    },
    {
      title: "图标与花纹底",
      prose: [],
      code: [
        "// 图标名按本地图标体系解析（SymbolGlyph 映射见 LhButtonTokens.iconFor，未登记名不绘制）",
        "LhButton({ onClick: () => {}, type: LhButtonType.Primary, icon: 'search', text: '搜索' })",
        "",
        "// 国风花纹底纹（消费 color.decoration 令牌）",
        "LhButton({ onClick: () => {}, type: LhButtonType.Primary, bgPattern: true, text: '花纹底' })",
      ],
      tables: [],
    },
    {
      title: "明暗主题",
      prose: [],
      code: [
        "LhTheme.apply(true)  // 全局切暗色；所有组件下次外观解析时自动跟随",
      ],
      tables: [],
    },
    {
      title: "组件示例预览",
      prose: [
        "原生 UI 无法在浏览器实时渲染，本站用内联静态 HTML 手机框模拟器展示外观：",
        "> 模拟器的暗色与站点联动：右上角切换主题，手机框内颜色即变（暗色令牌由 core 预计算）。",
      ],
      code: [],
      tables: [],
    },
      ],
    }

/**
 * 快速开始（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct GuideQuickstartDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: quickstartEntry }) {
      DocSectionView({ section: quickstartEntry.sections[0] }) {
        // 「最小示例」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: quickstartEntry.sections[1] }) {
        // 「类型与尺寸」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: quickstartEntry.sections[2] }) {
        // 「状态」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: quickstartEntry.sections[3] }) {
        // 「图标与花纹底」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: quickstartEntry.sections[4] }) {
        // 「明暗主题」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: quickstartEntry.sections[5] }) {
        // 「组件示例预览」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
