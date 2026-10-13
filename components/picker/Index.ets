import { LhPickerTokens, LhPickerAppearance } from './LhPickerTokens'
import { LH_COLORS_KEY, LightLhColors, LhColors } from '../../common/theme/LhTheme'
import { lhVp } from '../../common/LhVp'

/**
 * 选择器组件：底部弹出的单列滚轮（ArkUI 手写）。
 *
 * props 与 `lh-ui-core/specs/picker.json` 逐字对齐；行为遵循 `cases/picker.json`
 * 的 8 条黄金用例（已翻译为 hypium 测试，见 entry/src/test/Picker.test.ets）。
 *
 * 单列滚轮由 ArkUI 的 TextPicker 承载（P0 只做单列，多列留待后续）。
 * 声明式可见性：visible 为 false 时不渲染任何内容；确认/取消后触发 onClose，
 * 宿主据此置 visible 为 false。组件须作为页面 Stack 的最后子节点挂载。
 */
@Component
export struct LhPicker {
  /** 是否显示；为 false 时不渲染任何内容 */
  @Prop visible: boolean = false
  /** 候选项文本数组（单列） */
  @Prop options: Array<string> = []
  /** 选中项索引（0 基）；越界时钳制到候选项范围内 */
  @Prop @Watch('recompute') value: number = 0
  /** 工具栏中间的标题 */
  @Prop title: string = ''
  /** 确认按钮文字 */
  @Prop confirmText: string = '确认'
  /** 取消按钮文字 */
  @Prop cancelText: string = '取消'

  /** 滚轮停止且选中项变化时触发（回调属性不加 @Prop） */
  onValueChange: (value: number) => void = () => {}
  /** 点击确认按钮时触发，携带当前选中索引 */
  onConfirm: (value: number) => void = () => {}
  /** 点击取消按钮时触发 */
  onCancel: () => void = () => {}
  /** 确认/取消后触发，宿主据此置 visible 为 false */
  onClose: () => void = () => {}

  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''
  /** 滚轮当前选中索引（内部态，确认时上报） */
  @State selectedIndex: number = 0

  private appearance: LhPickerAppearance = LhPickerTokens.resolve(0, 0, LightLhColors())

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    let colors = LightLhColors()
    if (this.colorsJson !== '') {
      colors = JSON.parse(this.colorsJson) as LhColors
    }
    this.appearance = LhPickerTokens.resolve(this.options.length, this.value, colors)
    this.selectedIndex = this.appearance.selectedIndex
  }

  build() {
    if (this.visible) {
      Stack() {
        // 遮罩（点击不关闭：确认/取消是唯一关闭路径）
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(this.appearance.overlayColor)
          .zIndex(this.appearance.zIndexBackdrop)

        // 底部面板
        Column() {
          // 工具栏：左取消、中标题、右确认
          Row() {
            Text(this.cancelText)
              .fontSize(lhVp(this.appearance.itemFontSize))
              .fontColor(this.appearance.cancelColor)
              .onClick(() => {
                this.onCancel()
                this.onClose()
              })

            Text(this.title)
              .fontSize(lhVp(this.appearance.itemFontSize))
              .fontColor(this.appearance.titleColor)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)
              .maxLines(1)
              .textOverflow(TextOverflow.Ellipsis)

            Text(this.confirmText)
              .fontSize(lhVp(this.appearance.itemFontSize))
              .fontColor(this.appearance.confirmColor)
              .onClick(() => {
                this.onConfirm(this.selectedIndex)
                this.onClose()
              })
          }
          .width('100%')
          .height(lhVp(this.appearance.toolbarHeight))
          .padding({
            left: lhVp(this.appearance.itemHeight),
            right: lhVp(this.appearance.itemHeight),
          })

          // 滚轮区（中央指示器由 TextPicker 自带高亮承担）
          TextPicker({
            range: this.options,
            selected: this.appearance.selectedIndex,
          })
            .height(lhVp(this.appearance.wheelHeight))
            .itemHeight(lhVp(this.appearance.itemHeight))
            .fontSize(lhVp(this.appearance.itemFontSize))
            .selectedTextStyle({
              color: this.appearance.titleColor,
              fontSize: lhVp(this.appearance.itemFontSize),
            })
            .onChange((newValue: string | string[], newIndex: number | number[]) => {
              // 滚轮停止后，选中项变化时触发 onValueChange（单列，索引是 number）
              const index = newIndex as number
              if (index !== this.selectedIndex) {
                this.selectedIndex = index
                this.onValueChange(index)
              }
            })
        }
        .width('100%')
        .height(lhVp(this.appearance.height))
        .backgroundColor(this.appearance.containerColor)
        .borderRadius({ topLeft: lhVp(this.appearance.borderRadius), topRight: lhVp(this.appearance.borderRadius) })
        .zIndex(this.appearance.zIndexModal)
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Bottom)
    }
  }
}
