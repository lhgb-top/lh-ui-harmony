// 本文件由 scripts/gen-doc-pages.mjs 从 docs/guide/local-linking.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/GuideLocalLinkingPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'

const localLinkingEntry: DocEntry =
    {
      id: "local-linking",
      title: "本地联调",
      group: DocGroup.Guide,
      lede: [],
      contract: [],
      sections: [
    {
      title: "家族布局约定",
      prose: [
        "各仓同父目录时，令牌本地直连；兄弟仓不存在（CI 单仓 clone）时自动回退 npm 包。",
        "这与 web 血脉的 vite alias 守卫机制同构（总纲 D18）。",
      ],
      code: [
        "lh-ui/                        # 家族父目录（非仓库）",
        "├── lh-ui-core/               # 令牌真源 + codegen",
        "├── lh-ui-android/            # 兄弟仓",
        "├── lh-ui-ios/",
        "├── lh-ui-harmony/            # 本仓",
        "└── lh-ui-windows/",
      ],
      tables: [],
    },
    {
      title: "三级守卫",
      prose: [
        "scripts/link-tokens.mjs 按优先级查找令牌产物：",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["优先级", "来源", "说明"],
                rows: [
                { cells: ["1", "../lh-ui-core/dist/harmony", "本地直连：改令牌即时生效" ] },
                { cells: ["2", "node_modules/@lh-ui/core/dist/harmony", "npm 回退：@lh-ui/core 的 files:[\"dist\"] 含四端产物" ] },
                { cells: ["3", "—", "报错退出，缺令牌无法构建" ] },
                ],
              }
      ],
    },
    {
      title: "日常流程",
      prose: [],
      code: [
        "# 1. 改令牌（在 core 仓）",
        "cd ../lh-ui-core",
        "vim tokens/color.json           # 或 spacing / typography / ...",
        "",
        "# 2. 重新生成 + 校验",
        "pnpm codegen                    # 生成 dist/ 四端产物",
        "pnpm verify                     # schema + 引用 + WCAG 对比度 + 契约一致性",
        "",
        "# 3. 回本仓同步",
        "cd ../lh-ui-harmony",
        "pnpm link:tokens                # 覆盖 tokens/",
        "",
        "# 4. 回归（DevEco）",
        "# 右键 tests → Run Tests（hypium 黄金用例）",
      ],
      tables: [],
    },
    {
      title: "CI 门禁",
      prose: [],
      code: [
        "pnpm link:tokens:check          # 检测令牌是否已同步（文件数比对，未同步则退出码 1）",
      ],
      tables: [],
    },
    {
      title: "禁止事项",
      prose: [
        "- ❌ 手改 tokens/（生成物，gitignore）",
        "- ❌ 把生成的令牌文件提交入库",
        "- ❌ 在组件里写色值/间距字面量（如 '#FF2B4C7C'、vp(40)、字号数字）",
        "- ❌ 绕过 link:tokens 手动拷贝产物",
      ],
      code: [],
      tables: [],
    },
    {
      title: "排查",
      prose: [],
      code: [],
      tables: [
              {
                title: "",
                headers: ["症状", "原因", "解决"],
                rows: [
                { cells: ["编译报 Cannot find module 'LhTokens'", "令牌未同步", "pnpm link:tokens" ] },
                { cells: ["令牌值与预期不符", "core 仓未重新 codegen", "core 仓 pnpm codegen 后重新 link" ] },
                { cells: ["link:tokens 报「未找到令牌产物」", "兄弟仓不在且未装 npm 包", "检查家族布局或 pnpm i -D @lh-ui/core" ] },
                { cells: ["暗色颜色不对", "改了明色主色但没更新暗色预计算", "更新 color-dark.json 并重跑（R-n6）" ] },
                { cells: ["组件颜色全是明色", "入口未调 LhTheme.apply", "EntryAbility 窗口创建后调用一次" ] },
                ],
              }
      ],
    },
      ],
    }

/**
 * 本地联调（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct GuideLocalLinkingDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: localLinkingEntry }) {
      DocSectionView({ section: localLinkingEntry.sections[0] }) {
        // 「家族布局约定」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: localLinkingEntry.sections[1] }) {
        // 「三级守卫」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: localLinkingEntry.sections[2] }) {
        // 「日常流程」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: localLinkingEntry.sections[3] }) {
        // 「CI 门禁」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: localLinkingEntry.sections[4] }) {
        // 「禁止事项」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: localLinkingEntry.sections[5] }) {
        // 「排查」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
