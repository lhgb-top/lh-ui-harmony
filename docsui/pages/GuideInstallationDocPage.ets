// 本文件由 scripts/gen-doc-pages.mjs 从 docs/guide/installation.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/GuideInstallationPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'

const installationEntry: DocEntry =
    {
      id: "installation",
      title: "安装",
      group: DocGroup.Guide,
      lede: [],
      contract: [],
      sections: [
    {
      title: "环境要求",
      prose: [
        "- DevEco Studio 5.0+（HarmonyOS NEXT SDK，compatibleSdkVersion 5.0.0(12)）",
        "- 构建期工具链：Node.js >= 20 + pnpm（仅令牌连接与文档站使用，不进入运行时）",
      ],
      code: [],
      tables: [],
    },
    {
      title: "ohpm 引入（nM6 发包链路打通后）",
      prose: [],
      code: [
        "ohpm install top.lhgb.ui.harmony",
        "// oh-package.json5",
        "{",
        "  \"dependencies\": {",
        "    \"top.lhgb.ui.harmony\": \"^0.0.1\"",
        "  }",
        "}",
      ],
      tables: [],
    },
    {
      title: "源码集成（当前阶段）",
      prose: [
        "家族布局下直接引用本仓模块（DevEco 打开 lh-ui-harmony 工程即可）：",
      ],
      code: [
        "lh-ui-harmony/",
        "├── common/theme/        # LhTheme（AppStorage 注入）",
        "├── components/button/   # LhButton 组件",
        "├── entry/               # 演示应用（全形态展示 + 明暗切换）",
        "└── tokens/              # 生成物（见下）",
      ],
      tables: [],
    },
    {
      title: "同步令牌",
      prose: [
        "令牌是生成物，必须从 lh-ui-core 同步（唯一真源，禁止手改）：",
        "pnpm link:tokens 带三级存在性守卫：本地 ../lh-ui-core/dist/harmony → npm @lh-ui/core 产物 → 报错。",
      ],
      code: [
        "cd ../lh-ui-core && pnpm codegen   # 生成 dist/harmony 令牌产物",
        "cd ../lh-ui-harmony",
        "pnpm install                        # 安装构建期工具链",
        "pnpm link:tokens                    # 同步令牌到 tokens/",
      ],
      tables: [],
    },
    {
      title: "验证安装",
      prose: [],
      code: [
        "# DevEco Studio 打开工程后：",
        "# Build → Build Hs/Hap（编译）",
        "# 右键 tests → Run Tests（hypium 黄金用例）",
      ],
      tables: [],
    },
      ],
    }

/**
 * 安装（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct GuideInstallationDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: installationEntry }) {
      DocSectionView({ section: installationEntry.sections[0] }) {
        // 「环境要求」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: installationEntry.sections[1] }) {
        // 「ohpm 引入（nM6 发包链路打通后）」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: installationEntry.sections[2] }) {
        // 「源码集成（当前阶段）」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: installationEntry.sections[3] }) {
        // 「同步令牌」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: installationEntry.sections[4] }) {
        // 「验证安装」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
