// 本文件由 scripts/gen-doc-pages.mjs 从 docs/components/loading.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/LoadingPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
import { LoadingSizesPreview, LoadingTonePreview } from '../previews/LoadingPreviews'

const loadingEntry: DocEntry =
    {
      id: "loading",
      title: "Loading 加载",
      group: DocGroup.Feedback,
      lede: [
      "环形旋转加载指示器。支持三档尺寸与五种语义色。",
      "旋转动画由 ArkUI 的 LoadingProgress 内置驱动（spec 的「旋转交由后端驱动」在本端由平台动画承担）。",
    ],
      contract: [
      "契约源：lh-ui-core/specs/loading.json ·",
      "黄金用例：lh-ui-core/cases/loading.json（5 条，已翻译为 hypium 测试）",
    ],
      sections: [
    {
      title: "尺寸",
      prose: [
        "三档尺寸映射到 loading.size 令牌。",
      ],
      code: [
        "LhLoading({ size: LhLoadingSize.Large })",
      ],
      tables: [],
    },
    {
      title: "色调",
      prose: [
        "tone 决定环色，与语义色令牌一一对应。",
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
                { cells: ["size", "指示器直径，映射到 loading.size 令牌", "LhLoadingSize", "Medium" ] },
                { cells: ["tone", "环色，取对应语义色令牌", "LhLoadingTone", "Primary" ] },
                ],
              },
              {
                title: "LhLoadingSize",
                headers: ["值", "size"],
                rows: [
                { cells: ["Small", "loading.size.small（16vp）" ] },
                { cells: ["Medium", "loading.size.medium（20vp）" ] },
                { cells: ["Large", "loading.size.large（24vp）" ] },
                ],
              },
              {
                title: "LhLoadingTone",
                headers: ["值", "环色"],
                rows: [
                { cells: ["Primary", "color.primary.default" ] },
                { cells: ["Success", "color.success.default" ] },
                { cells: ["Warning", "color.warning.default" ] },
                { cells: ["Danger", "color.danger.default" ] },
                { cells: ["Info", "color.info.default" ] },
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
                { cells: ["loading.size.{small,medium,large}", "三档直径" ] },
                { cells: ["loading.strokeWidth", "环描边宽度（2vp）" ] },
                { cells: ["color.{primary,success,warning,danger,info}.default", "五种环色" ] },
                ],
              }
      ],
    },
    {
      title: "黄金用例对照",
      prose: [
        "cases/loading.json 的 5 条断言与 hypium 测试的对应关系（entry/src/test/Loading.test.ets）：",
        "另有暗色专项：dark_colors_come_from_dark_tokens / dimensions_are_identical_in_dark_mode。",
        "运行：DevEco Studio 右键 entry/src/test → Run Tests。",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["case id", "断言", "本地测试"],
                rows: [
                { cells: ["medium-size-uses-medium-token", "中号取 medium 尺寸令牌", "medium_size_uses_medium_token" ] },
                { cells: ["large-size-uses-large-token", "大号取 large 尺寸令牌", "large_size_uses_large_token" ] },
                { cells: ["primary-tone-uses-primary-token", "主色调取主色令牌", "primary_tone_uses_primary_token" ] },
                { cells: ["success-tone-uses-success-token", "成功色调取成功色令牌", "success_tone_uses_success_token" ] },
                { cells: ["render-emits-ring-command", "渲染发射环形命令", "端侧无对应命令（LoadingProgress 平台组件，描边宽度见 stroke_width_uses_token）" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * Loading 加载（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct LoadingDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: loadingEntry }) {
      DocSectionView({ section: loadingEntry.sections[0] }) {
        LoadingSizesPreview({ toast: this.toast })
      }
      DocSectionView({ section: loadingEntry.sections[1] }) {
        LoadingTonePreview({ toast: this.toast })
      }
      DocSectionView({ section: loadingEntry.sections[2] }) {
        // 「API」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: loadingEntry.sections[3] }) {
        // 「令牌对照」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: loadingEntry.sections[4] }) {
        // 「黄金用例对照」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
