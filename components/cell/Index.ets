import { LhCellTokens, LhCellAppearance } from './LhCellTokens'
import { LH_COLORS_KEY, LightLhColors, LhColors } from '../../common/theme/LhTheme'
import { LhIconTokens } from '../icon/LhIconTokens'
import { lhVp } from '../../common/LhVp'

/**
 * 单元格组件：列表行（ArkUI 手写）。
 *
 * props 与 `lh-ui-core/specs/cell.json` 逐字对齐；行为遵循 `cases/cell.json`
 * 的 6 条黄金用例（已翻译为 hypium 测试，见 entry/src/test/Cell.test.ets）。
 *
 * 块级铺满 layout 传入的可用宽度（width('100%')），高度由内容与内边距决定。
 */
@Component
export struct LhCell {
  /** 标题（主文字） */
  @Prop title: string = ''
  /** 右侧值（次文字，右对齐） */
  @Prop value: string = ''
  /** 标题下方的说明文字 */
  @Prop label: string = ''
  /** 是否绘制底部分隔线 */
  @Prop @Watch('recompute') bordered: boolean = true
  /** 是否可点击；为 true 时显示右侧指示箭头并响应点击 */
  @Prop @Watch('recompute') clickable: boolean = false
  /** 是否在标题前显示必填红星（取 color.danger.default） */
  @Prop required: boolean = false
  /** 左侧图标名（本地字形体系渲染） */
  @Prop icon?: string = undefined

  /** 点击单元格时触发；clickable 为 false 时不触发（回调属性不加 @Prop） */
  onClick: () => void = () => {}

  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''

  private appearance: LhCellAppearance = LhCellTokens.resolve(true, false, LightLhColors())

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    let colors = LightLhColors()
    if (this.colorsJson !== '') {
      colors = JSON.parse(this.colorsJson) as LhColors
    }
    this.appearance = LhCellTokens.resolve(this.bordered, this.clickable, colors)
  }

  build() {
    Column() {
      Row() {
        if (this.icon !== undefined) {
          Text(LhIconTokens.glyphFor(this.icon))
            .fontSize(lhVp(this.appearance.iconSize))
            .fontColor(this.appearance.iconColor)
            .margin({ right: lhVp(this.appearance.iconGap) })
        }

        // 标题列：必填红星 + 标题（+ 说明行）
        Column() {
          Row() {
            if (this.required) {
              Text('＊')
                .fontSize(lhVp(this.appearance.fontSizeTitle))
                .fontColor(this.appearance.requiredColor)
            }
            Text(this.title)
              .fontSize(lhVp(this.appearance.fontSizeTitle))
              .fontColor(this.appearance.titleColor)
              .layoutWeight(1)
              .maxLines(1)
              .textOverflow(TextOverflow.Ellipsis)
          }
          .width('100%')

          if (this.label !== '') {
            Text(this.label)
              .fontSize(lhVp(this.appearance.fontSizeLabel))
              .fontColor(this.appearance.labelColor)
              .width('100%')
              .margin({ top: lhVp(this.appearance.gap) })
              .maxLines(1)
              .textOverflow(TextOverflow.Ellipsis)
          }
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        // 右侧值（右对齐）
        if (this.value !== '') {
          Text(this.value)
            .fontSize(lhVp(this.appearance.fontSizeValue))
            .fontColor(this.appearance.valueColor)
            .maxLines(1)
            .textOverflow(TextOverflow.Ellipsis)
            .margin({ left: lhVp(this.appearance.iconGap) })
        }

        // 可点击时的指示箭头（端侧落点为 → 字形）
        if (this.clickable) {
          Text(LhIconTokens.glyphFor('arrow'))
            .fontSize(lhVp(this.appearance.iconSize))
            .fontColor(this.appearance.arrowColor)
            .margin({ left: lhVp(this.appearance.iconGap) })
        }
      }
      .width('100%')
      .padding({
        left: lhVp(this.appearance.paddingHorizontal),
        right: lhVp(this.appearance.paddingHorizontal),
        top: lhVp(this.appearance.paddingVertical),
        bottom: lhVp(this.appearance.paddingVertical),
      })
      .onClick(() => {
        // 状态 gate：clickable 为 false 时不触发
        if (this.clickable) {
          this.onClick()
        }
      })

      // 底部分隔线（bordered 为 false 时不绘制）
      if (this.appearance.dividerColor !== undefined) {
        Divider()
          .color(this.appearance.dividerColor)
          .width('100%')
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
