/**
 * 文档宿主页（等价 android `:docsui` 的宿主 Activity / ios `LhDocsHost`）。
 *
 * 四支柱落地：
 *  ① 令牌先行：自身不出现任何色值 / 尺寸字面量，全部取 LhTokens / LhColors（经主题层）。
 *  ② 内容与预览分离：页面内容由 `scripts/gen-doc-pages.mjs` 从 md 生成（pages/，禁手改），
 *     交互预览手写在 previews/，由生成页的 DocSectionView 尾随闭包挂接。
 *  ③ 宿主零依赖：本仓无 Router（demo 也是单页），返回栈手写在 @State pageStack 上；
 *     顶栏 dogfood 自家 LhNavbar；全局反馈 dogfood 自家 LhToast（宿主控制器注入预览）。
 *  ④ 分发形态：本模块是库内组件，由使用方（entry 或宿主 App）在自己的页面里嵌入 LhDocs。
 *
 * 用法：在页面里 `LhDocs()` 即可；主题初始化（LhTheme.apply）由宿主负责。
 */
import { LhNavbar } from '../../components/navbar/Index'
import { LhToast } from '../../components/toast/Index'
import { LhToastType, LhToastPosition, LhToastController } from '../../components/toast/Index'
import { LhCell } from '../../components/cell/Index'
import { LhText } from '../../components/text/Index'
import { LhTextLevel } from '../../components/text/LhTextTokens'
import { LhTheme } from '../../common/theme/LhThemeApply'
import { LhColors, LightLhColors, LH_COLORS_KEY, LH_IS_DARK_KEY } from '../../common/theme/LhTheme'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocRegistry } from './DocRegistry'
import { DocEntry, DocGroup } from './model/DocModels'
import { DocPageDispatch } from './pages/DocPageDispatch'

/** 首页标题（内容字符串，非外观令牌） */
const HOME_TITLE: string = 'lh-ui 文档'

@Component
export struct LhDocs {
  /** 手写返回栈：空 = 首页分组列表；非空 = 栈顶为当前文档页 id。 */
  @State pageStack: string[] = []
  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''
  @StorageProp(LH_IS_DARK_KEY) isDark: boolean = false
  private colors: LhColors = LightLhColors()
  private toastCenter: LhToastController = new LhToastController()

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    this.colors = LightLhColors()
    if (this.colorsJson !== '') {
      this.colors = JSON.parse(this.colorsJson) as LhColors
    }
  }

  private canBack(): boolean {
    return this.pageStack.length > 0
  }

  private currentTitle(): string {
    if (this.canBack()) {
      const entry = DocRegistry.byId(this.pageStack[this.pageStack.length - 1])
      if (entry !== undefined) {
        return entry.title
      }
    }
    return HOME_TITLE
  }

  private open(id: string): void {
    this.pageStack.push(id)
  }

  private goBack(): void {
    this.pageStack.pop()
  }

  private toggleTheme(): void {
    LhTheme.apply(!this.isDark)
  }

  /** 首页：按分组的文档索引（dogfood LhText 做分组标题、LhCell 做条目）。 */
  @Builder homeList() {
    Scroll() {
      Column() {
        ForEach(DocRegistry.groups(), (group: DocGroup, groupIndex: number) => {
          LhText({ content: group, level: LhTextLevel.Medium })
            .margin({
              top: lhVp(groupIndex === 0 ? LhTokens.Spacing.md : LhTokens.Spacing.lg),
              bottom: lhVp(LhTokens.Spacing.xs),
              left: lhVp(LhTokens.Docs.Card.padding),
              right: lhVp(LhTokens.Docs.Card.padding),
            })
          ForEach(DocRegistry.entriesInGroup(group), (entry: DocEntry, entryIndex: number) => {
            LhCell({
              title: entry.title,
              value: '查看',
              clickable: true,
              onClick: () => this.open(entry.id),
            })
          }, (entry: DocEntry, entryIndex: number) => entry.id)
        }, (group: DocGroup, groupIndex: number) => group)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding({ bottom: lhVp(LhTokens.Spacing.xxl) })
    }
    .width('100%')
    .layoutWeight(1)
    .align(Alignment.TopStart)
    .backgroundColor(this.colors.backgroundPage)
  }

  build() {
    Stack() {
      Column() {
        LhNavbar({
          title: this.currentTitle(),
          leftText: this.canBack() ? '返回' : '',
          leftIcon: this.canBack() ? 'back' : undefined,
          rightText: this.isDark ? '切明色' : '切暗色',
          bordered: true,
          onLeftClick: () => this.goBack(),
          onRightClick: () => this.toggleTheme(),
        })

        if (this.canBack()) {
          DocPageDispatch({
            entryId: this.pageStack[this.pageStack.length - 1],
            toast: this.toastCenter,
          })
        } else {
          this.homeList()
        }
      }

      LhToast({
        type: LhToastType.Success,
        position: LhToastPosition.Bottom,
        controller: this.toastCenter,
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.backgroundPage)
  }
}
