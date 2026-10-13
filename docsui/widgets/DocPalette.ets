/**
 * 文档模块取色板。
 *
 * 零字面量（对齐 android `:docsui` 范式）：所有颜色取 core 生成的 `Docs` 令牌组
 * （`LhTokens.Docs.*`），暗色只覆盖颜色（`LhDarkTokens.Docs.*`，D18 并列对象模型）；
 * 尺寸一律取明色对象（暗色不含尺寸）。页面底色等通用色取 `LhColors`（主题层）。
 */
import { LhColors, LightLhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'
import { LhDarkTokens } from '../../tokens/LhDarkTokens'

/** 把 AppStorage 的色板 JSON 还原为 LhColors；未 apply 时回退明色色板（与组件一致）。 */
export function docColors(colorsJson: string): LhColors {
  if (colorsJson === '') {
    return LightLhColors()
  }
  return JSON.parse(colorsJson) as LhColors
}

/**
 * Docs 令牌组的明/暗取值器：宿主与各 widget 持有一个实例，主题变化时重建。
 */
export class DocPalette {
  private readonly dark: boolean

  constructor(isDark: boolean) {
    this.dark = isDark
  }

  // —— Card（预览框 / 契约卡片）——
  get cardBackground(): ResourceColor {
    return this.dark ? LhDarkTokens.Docs.Card.background : LhTokens.Docs.Card.background
  }
  get cardBorder(): ResourceColor {
    return this.dark ? LhDarkTokens.Docs.Card.borderColor : LhTokens.Docs.Card.borderColor
  }
  get cardRadius(): number {
    return LhTokens.Docs.Card.borderRadius
  }
  get cardBorderWidth(): number {
    return LhTokens.Docs.Card.borderWidth
  }
  get cardPadding(): number {
    return LhTokens.Docs.Card.padding
  }

  // —— Code（代码块）——
  get codeBackground(): ResourceColor {
    return this.dark ? LhDarkTokens.Docs.Code.background : LhTokens.Docs.Code.background
  }
  get codeText(): ResourceColor {
    return this.dark ? LhDarkTokens.Docs.Code.textColor : LhTokens.Docs.Code.textColor
  }
  get codeRadius(): number {
    return LhTokens.Docs.Code.borderRadius
  }
  get codeFontSize(): number {
    return LhTokens.Docs.Code.fontSize
  }
  get codePaddingX(): number {
    return LhTokens.Docs.Code.paddingX
  }
  get codePaddingY(): number {
    return LhTokens.Docs.Code.paddingY
  }
  get codeFontFamily(): string {
    return LhTokens.Docs.Code.fontFamily
  }

  // —— Heading（标题）——
  get headingColor(): ResourceColor {
    return this.dark ? LhDarkTokens.Docs.Heading.color : LhTokens.Docs.Heading.color
  }
  get headingSizeH1(): number {
    return LhTokens.Docs.Heading.fontSizeH1
  }
  get headingSizeH2(): number {
    return LhTokens.Docs.Heading.fontSizeH2
  }
  get headingSizeH3(): number {
    return LhTokens.Docs.Heading.fontSizeH3
  }

  // —— Prose（正文）——
  get proseText(): ResourceColor {
    return this.dark ? LhDarkTokens.Docs.Prose.textColor : LhTokens.Docs.Prose.textColor
  }
  get proseSecondary(): ResourceColor {
    return this.dark ? LhDarkTokens.Docs.Prose.secondaryColor : LhTokens.Docs.Prose.secondaryColor
  }
  get proseFontSize(): number {
    return LhTokens.Docs.Prose.fontSize
  }

  // —— Table（表格）——
  get tableBorder(): ResourceColor {
    return this.dark ? LhDarkTokens.Docs.Table.borderColor : LhTokens.Docs.Table.borderColor
  }
  get tableBorderWidth(): number {
    return LhTokens.Docs.Table.borderWidth
  }
  get tableCellPaddingX(): number {
    return LhTokens.Docs.Table.cellPaddingX
  }
  get tableCellPaddingY(): number {
    return LhTokens.Docs.Table.cellPaddingY
  }
  get tableFontSize(): number {
    return LhTokens.Docs.Table.fontSize
  }
  get tableHeaderBg(): ResourceColor {
    return this.dark ? LhDarkTokens.Docs.Table.headerBg : LhTokens.Docs.Table.headerBg
  }
  get tableHeaderText(): ResourceColor {
    return this.dark ? LhDarkTokens.Docs.Table.headerTextColor : LhTokens.Docs.Table.headerTextColor
  }
}
