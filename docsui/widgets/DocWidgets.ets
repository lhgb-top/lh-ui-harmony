/**
 * 文档模块通用 widget：标题 / 正文 / 契约卡片 / 分隔线 / 代码块 / 表格 /
 * 页面骨架（DocScroll）/ 章节骨架（DocSectionView）/ 预览框（DocPreviewFrame）。
 *
 * 约定：
 * - 颜色一律经 `DocPalette`（Docs 令牌组 + LhColors），尺寸一律经 `lhVp(LhTokens.*)`，
 *   零字面量（对齐 android `:docsui` 范式与仓 AGENTS.md 红线 1）。
 * - 主题热重绘走仓内统一模式：`@StorageProp(LH_COLORS_KEY) @Watch('recompute')`。
 * - 需要嵌入子内容的 widget 用 `@BuilderParam content: () => void` + 尾随闭包语法。
 */
import { LhColors, LightLhColors, LH_COLORS_KEY, LH_IS_DARK_KEY } from '../../common/theme/LhTheme'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocPalette, docColors } from './DocPalette'
import { DocEntry, DocGroup, DocRow, DocSection, DocTable } from '../model/DocModels'

/** 散文段落：行内反引号在生成期已剥离，这里只做单一样式的正文渲染。 */
@Component
export struct DocProse {
  @Prop text: string = ''
  @Prop secondary: boolean = false
  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''
  private palette: DocPalette = new DocPalette(false)

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    this.palette = new DocPalette(AppStorage.get<boolean>(LH_IS_DARK_KEY) ?? false)
  }

  build() {
    Text(this.text)
      .fontSize(lhVp(this.palette.proseFontSize))
      .fontColor(this.secondary ? this.palette.proseSecondary : this.palette.proseText)
      .width('100%')
  }
}

/** 标题：level 1 = 页面标题，2 = 章节，3 = 表格小节。 */
@Component
export struct DocHeading {
  @Prop text: string = ''
  @Prop level: number = 2
  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''
  private palette: DocPalette = new DocPalette(false)

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    this.palette = new DocPalette(AppStorage.get<boolean>(LH_IS_DARK_KEY) ?? false)
  }

  private sizeOf(): number {
    if (this.level === 1) {
      return this.palette.headingSizeH1
    }
    if (this.level === 3) {
      return this.palette.headingSizeH3
    }
    return this.palette.headingSizeH2
  }

  build() {
    Text(this.text)
      .fontSize(lhVp(this.sizeOf()))
      .fontColor(this.palette.headingColor)
      .fontWeight(this.level === 1 ? FontWeight.Bold : FontWeight.Medium)
      .maxLines(2)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
  }
}

/** 契约卡片：md 中连续 `>` 的契约行集合。 */
@Component
export struct DocCard {
  lines: string[] = []
  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''
  private palette: DocPalette = new DocPalette(false)

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    this.palette = new DocPalette(AppStorage.get<boolean>(LH_IS_DARK_KEY) ?? false)
  }

  build() {
    Column() {
      ForEach(this.lines, (line: string, index: number) => {
        DocProse({ text: line })
      }, (line: string, index: number) => `${index}`)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(lhVp(this.palette.cardPadding))
    .backgroundColor(this.palette.cardBackground)
    .borderRadius(lhVp(this.palette.cardRadius))
    .border({ width: lhVp(this.palette.cardBorderWidth), color: this.palette.cardBorder })
  }
}

@Component
export struct DocDivider {
  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''
  private palette: DocPalette = new DocPalette(false)

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    this.palette = new DocPalette(AppStorage.get<boolean>(LH_IS_DARK_KEY) ?? false)
  }

  build() {
    Divider()
      .color(this.palette.cardBorder)
      .strokeWidth(lhVp(this.palette.cardBorderWidth))
      .width('100%')
  }
}

/** 代码块：等宽字体栈（Docs.Code.fontFamily），逐行渲染。 */
@Component
export struct DocCodeBlock {
  lines: string[] = []
  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''
  private palette: DocPalette = new DocPalette(false)

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    this.palette = new DocPalette(AppStorage.get<boolean>(LH_IS_DARK_KEY) ?? false)
  }

  build() {
    Column() {
      ForEach(this.lines, (line: string, index: number) => {
        Text(line)
          .fontSize(lhVp(this.palette.codeFontSize))
          .fontColor(this.palette.codeText)
          .fontFamily(this.palette.codeFontFamily)
          .width('100%')
      }, (line: string, index: number) => `${index}`)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({
      left: lhVp(this.palette.codePaddingX),
      right: lhVp(this.palette.codePaddingX),
      top: lhVp(this.palette.codePaddingY),
      bottom: lhVp(this.palette.codePaddingY),
    })
    .backgroundColor(this.palette.codeBackground)
    .borderRadius(lhVp(this.palette.codeRadius))
  }
}

/** 表格：ArkUI 无原生 Table，用 Row + layoutWeight(1) 平分列宽。 */
@Component
export struct DocTableView {
  table: DocTable = { title: '', headers: [], rows: [] }
  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''
  private palette: DocPalette = new DocPalette(false)

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    this.palette = new DocPalette(AppStorage.get<boolean>(LH_IS_DARK_KEY) ?? false)
  }

  build() {
    Column() {
      if (this.table.title !== '') {
        DocHeading({ text: this.table.title, level: 3 })
      }
      Column() {
        Row() {
          ForEach(this.table.headers, (cell: string, index: number) => {
            Text(cell)
              .layoutWeight(1)
              .fontSize(lhVp(this.palette.tableFontSize))
              .fontColor(this.palette.tableHeaderText)
              .fontWeight(FontWeight.Medium)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .padding({
                left: lhVp(this.palette.tableCellPaddingX),
                right: lhVp(this.palette.tableCellPaddingX),
                top: lhVp(this.palette.tableCellPaddingY),
                bottom: lhVp(this.palette.tableCellPaddingY),
              })
          }, (cell: string, index: number) => `${index}`)
        }
        .width('100%')
        .backgroundColor(this.palette.tableHeaderBg)

        ForEach(this.table.rows, (row: DocRow, rowIndex: number) => {
          Row() {
            ForEach(row.cells, (cell: string, cellIndex: number) => {
              Text(cell)
                .layoutWeight(1)
                .fontSize(lhVp(this.palette.tableFontSize))
                .fontColor(this.palette.proseText)
                .maxLines(3)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .padding({
                  left: lhVp(this.palette.tableCellPaddingX),
                  right: lhVp(this.palette.tableCellPaddingX),
                  top: lhVp(this.palette.tableCellPaddingY),
                  bottom: lhVp(this.palette.tableCellPaddingY),
                })
            }, (cell: string, cellIndex: number) => `${cellIndex}`)
          }
          .width('100%')

          Divider()
            .color(this.palette.tableBorder)
            .strokeWidth(lhVp(this.palette.tableBorderWidth))
            .width('100%')
        }, (row: DocRow, rowIndex: number) => `${rowIndex}`)
      }
      .width('100%')
      .borderRadius(lhVp(this.palette.codeRadius))
      .border({ width: lhVp(this.palette.tableBorderWidth), color: this.palette.tableBorder })
      .clip(true)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

/**
 * 页面骨架：可滚动区 = 标题 + 导语 + 契约卡片 + 分隔线 + 调用方传入的章节内容。
 * 生成页用尾随闭包把 `this.sectionXxx()` 逐节挂入。
 */
@Component
export struct DocScroll {
  entry: DocEntry = {
    id: '', title: '', group: DocGroup.Guide, lede: [], contract: [], sections: [],
  }
  @BuilderParam content: () => void
  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''
  private palette: DocPalette = new DocPalette(false)
  private colors: LhColors = LightLhColors()

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    this.colors = docColors(this.colorsJson)
    this.palette = new DocPalette(AppStorage.get<boolean>(LH_IS_DARK_KEY) ?? false)
  }

  build() {
    Scroll() {
      Column() {
        DocHeading({ text: this.entry.title, level: 1 })

        ForEach(this.entry.lede, (line: string, index: number) => {
          DocProse({ text: line })
        }, (line: string, index: number) => `${index}`)

        if (this.entry.contract.length > 0) {
          DocCard({ lines: this.entry.contract })
        }

        DocDivider()

        this.content()
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding({
        left: lhVp(this.palette.cardPadding),
        right: lhVp(this.palette.cardPadding),
        top: lhVp(LhTokens.Spacing.md),
        bottom: lhVp(LhTokens.Spacing.xxl),
      })
    }
    .width('100%')
    .layoutWeight(1)
    .align(Alignment.TopStart)
    .backgroundColor(this.colors.backgroundPage)
  }
}

/**
 * 章节骨架：章节标题 + 散文 + 调用方尾随闭包（真交互预览）+ 代码块 + 表格。
 * 生成页只提供数据与预览结构体，渲染管线全在此。
 */
@Component
export struct DocSectionView {
  section: DocSection = { title: '', prose: [], code: [], tables: [] }
  @BuilderParam content: () => void
  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''
  private palette: DocPalette = new DocPalette(false)

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    this.palette = new DocPalette(AppStorage.get<boolean>(LH_IS_DARK_KEY) ?? false)
  }

  build() {
    Column() {
      DocHeading({ text: this.section.title, level: 2 })

      ForEach(this.section.prose, (line: string, index: number) => {
        DocProse({ text: line })
      }, (line: string, index: number) => `${index}`)

      this.content()

      if (this.section.code.length > 0) {
        DocCodeBlock({ lines: this.section.code })
      }

      ForEach(this.section.tables, (table: DocTable, index: number) => {
        DocTableView({ table: table })
      }, (table: DocTable, index: number) => `${index}`)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

/**
 * 预览框：真交互预览的固定高度舞台。浮层（dialog / picker）的 Stack 以本框为边界。
 */
@Component
export struct DocPreviewFrame {
  title: string = ''
  @BuilderParam content: () => void
  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''
  private palette: DocPalette = new DocPalette(false)

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    this.palette = new DocPalette(AppStorage.get<boolean>(LH_IS_DARK_KEY) ?? false)
  }

  private frameMinHeight(): number {
    const step: number = LhTokens.Spacing.xxl
    return step * 6
  }

  build() {
    Column() {
      if (this.title !== '') {
        DocProse({ text: this.title, secondary: true })
      }
      Column() {
        this.content()
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .constraintSize({ minHeight: lhVp(this.frameMinHeight()) })
      .padding(lhVp(this.palette.cardPadding))
      .backgroundColor(this.palette.cardBackground)
      .borderRadius(lhVp(this.palette.cardRadius))
      .border({ width: lhVp(this.palette.cardBorderWidth), color: this.palette.cardBorder })
    }
    .alignItems(HorizontalAlign.Start)
  }
}
