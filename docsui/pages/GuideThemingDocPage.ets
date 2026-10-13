// 本文件由 scripts/gen-doc-pages.mjs 从 docs/guide/theming.md 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/GuideThemingPreviews.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'

const themingEntry: DocEntry =
    {
      id: "theming",
      title: "主题与暗色",
      group: DocGroup.Guide,
      lede: [],
      contract: [],
      sections: [
    {
      title: "令牌模型",
      prose: [
        "原生血脉的令牌真源在 lh-ui-core/tokens/*.json，codegen 生成鸿蒙产物：",
        "> 这与 android / ios / windows 一致（并列对象），与 docs 端（浅合并 JSON）形态不同。",
        "> 主题层据此设计：LhColors 接口只承载颜色，尺寸由组件直接取 LhTokens。",
      ],
      code: [],
      tables: [
              {
                title: "",
                headers: ["产物", "内容", "暗色形态"],
                rows: [
                { cells: ["LhTokens", "明色全量：Button 尺寸、Color 色板、Motion、Radius、Shadow、Spacing、Typography、ZIndex", "—" ] },
                { cells: ["LhDarkTokens", "仅 Color 子类（并列对象模型）", "暗色只覆盖颜色，尺寸/动效/圆角暗色不变" ] },
                { cells: ["LhShadow", "ArkUI 阴影载体接口（color/radius/offsetX/offsetY）", "—" ] },
                ],
              }
      ],
    },
    {
      title: "LhColors",
      prose: [
        "LightLhColors() / DarkLhColors() 工厂把生成的两个类平铺为一份接口对象：",
        "工厂函数公开：单测可直接构造色板做断言；应用侧通过 LhTheme.apply 消费。",
      ],
      code: [
        "export interface LhColors {",
        "  primary: ResourceColor",
        "  onPrimary: ResourceColor",
        "  // ... 全部语义色",
        "}",
        "",
        "export function LightLhColors(): LhColors {",
        "  return { primary: LhTokens.Color.Primary.default, /* ... */ }",
        "}",
        "export function DarkLhColors(): LhColors {",
        "  return { primary: LhDarkTokens.Color.Primary.default, /* ... */ }",
        "}",
      ],
      tables: [],
    },
    {
      title: "AppStorage 注入",
      prose: [
        "ArkTS 的 AppStorage 只收可序列化类型，色板以 JSON 传递：",
        "组件在 aboutToAppear 读取并解析，未注入时回退明色板。",
      ],
      code: [
        "LhTheme.apply(isDark)  // setOrCreate(LH_COLORS_KEY, JSON.stringify(colors))",
      ],
      tables: [],
    },
    {
      title: "暗色预计算（重要）",
      prose: [
        "web 血脉的暗色用 CSS color-mix() 动态求值，原生无 CSS 级联，故 core 已把暗色表达式",
        "预计算为字面量（如 '#403D649E'、'#FFB1C1D8' 的 #AARRGGBB 串）。后果（总纲 R-n6）：",
        "> 改预设主色时，暗色预计算值不会自动跟随，必须重新人工计算并更新",
        "> lh-ui-core/tokens/color-dark.json，同步刷新《设计语言基线》。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "鸿蒙端特有约定",
      prose: [
        "- 时长单位是毫秒：Motion.Duration.base = 300（iOS 是秒），curve / animateTo 直接消费。",
        "- 色值表达：'#AARRGGBB' 字符串（ResourceColor），带透明度前缀（'#FF2B4C7C' 不透明）。",
        "- 圆角：Radius.circle 是 0.5 分数，端侧取 min(宽,高)/2 换算，不能当 vp 用。",
        "- 阴影：ArkUI 不支持扩展量（spread），生成的 LhShadow 已忽略 spread 并注释。",
        "- AppStorage 序列化：ResourceColor 不在 AppStorage 类型白名单内，色板走 JSON 字符串。",
        "- 嵌套类无 export：生成的令牌只有根类 export class LhTokens，嵌套 class Color 等",
        "不带 export（类体内不允许 export 声明，core harmony target 已处理）。",
      ],
      code: [],
      tables: [],
    },
    {
      title: "令牌速查",
      prose: [
        "完整令牌表（明/暗/说明）见 core 仓 dist/docs/tokens.md（pnpm codegen 后生成）。",
        "组件级令牌映射见 [Button 令牌对照](/components/button#令牌对照)。",
      ],
      code: [],
      tables: [],
    },
      ],
    }

/**
 * 主题与暗色（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct GuideThemingDocPage {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: themingEntry }) {
      DocSectionView({ section: themingEntry.sections[0] }) {
        // 「令牌模型」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: themingEntry.sections[1] }) {
        // 「LhColors」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: themingEntry.sections[2] }) {
        // 「AppStorage 注入」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: themingEntry.sections[3] }) {
        // 「暗色预计算（重要）」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: themingEntry.sections[4] }) {
        // 「鸿蒙端特有约定」为终止节或未登记预览，本节无真交互预览
      }
      DocSectionView({ section: themingEntry.sections[5] }) {
        // 「令牌速查」为终止节或未登记预览，本节无真交互预览
      }
    }
  }
}
