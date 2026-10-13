import { LhToastType, LhToastPosition, LhToastTokens, LhToastAppearance } from './LhToastTokens'
import { LH_COLORS_KEY, LightLhColors, LhColors } from '../../common/theme/LhTheme'
import { lhVp } from '../../common/LhVp'

/**
 * 轻提示组件：自持可见性与计时的墨色胶囊浮层（ArkUI 手写）。
 *
 * props 与 `lh-ui-core/specs/toast.json` 逐字对齐；行为遵循 `cases/toast.json`
 * 的 6 条黄金用例（已翻译为 hypium 测试，见 entry/src/test/Toast.test.ets）。
 *
 * 指令式接口（spec 的 show / hide / tick）在端侧落点为方法 + 内部计时：
 * - show(text) 使其可见并重置计时
 * - hide() 立即隐藏但不触发 onClose
 * - 计时由 setTimeout 承载（等价于每帧 tick 推进），到期自动隐藏并触发 onClose
 *
 * 宿主须将其作为页面 Stack 的最后子节点挂载（层级 zIndex.toast）。
 */
/**
 * 宿主调用句柄：组件在 aboutToAppear 把自身的 show/hide 注册到控制器上，宿主即可
 * 在不持有组件实例的情况下触发显示/隐藏。ArkUI 不提供子组件实例引用，这是指令式
 * 组件在声明式 UI 中被宿主驱动的推荐接法；不传入时组件仍可独立使用。
 */
export class LhToastController {
  show: (text: string) => void = () => {}
  hide: () => void = () => {}
}

@Component
export struct LhToast {
  /** 语义类型；非 default 时在文字前绘制对应语义色圆点 */
  @Prop @Watch('recompute') type: LhToastType = LhToastType.Default
  /** 自动隐藏时长（毫秒） */
  @Prop duration: number = 2000
  /** 在可用区域内的定位；上下两端留 spacing.xl 边距 */
  @Prop position: LhToastPosition = LhToastPosition.Center

  /** 计时到期自动隐藏时触发；hide() 主动隐藏不触发（回调属性不加 @Prop） */
  onClose: () => void = () => {}

  /** 宿主控制器（可选；普通属性，不加 @Prop） */
  controller: LhToastController | null = null

  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''
  /** 内部可见态（由 show/hide 维护，不可见时不渲染任何内容） */
  @State visible: boolean = false
  /** 当前提示文字（由 show(text) 设置） */
  @State text: string = ''
  private timerId: number = -1

  private appearance: LhToastAppearance = LhToastTokens.resolve(LhToastType.Default, LightLhColors())

  aboutToAppear(): void {
    this.recompute()
    if (this.controller !== null) {
      this.controller.show = (text: string) => { this.show(text) }
      this.controller.hide = () => { this.hide() }
    }
  }

  aboutToDisappear(): void {
    this.clearTimer()
  }

  private recompute(): void {
    let colors = LightLhColors()
    if (this.colorsJson !== '') {
      colors = JSON.parse(this.colorsJson) as LhColors
    }
    this.appearance = LhToastTokens.resolve(this.type, colors)
  }

  private clearTimer(): void {
    if (this.timerId !== -1) {
      clearTimeout(this.timerId)
      this.timerId = -1
    }
  }

  /** show(text)：使其可见并重置计时 */
  show(text: string): void {
    this.text = text
    this.visible = true
    this.clearTimer()
    this.timerId = setTimeout(() => {
      // 计时到期：自动隐藏并触发 onClose
      this.visible = false
      this.timerId = -1
      this.onClose()
    }, this.duration)
  }

  /** hide()：立即隐藏但不触发 onClose */
  hide(): void {
    this.clearTimer()
    this.visible = false
  }

  build() {
    if (this.visible) {
      Stack() {
        Row() {
          if (this.appearance.dotColor !== undefined) {
            // type 非 default 时在文字前绘制直径为字号的语义色圆点
            Circle()
              .width(lhVp(this.appearance.dotSize))
              .height(lhVp(this.appearance.dotSize))
              .fill(this.appearance.dotColor)
              .margin({ right: lhVp(this.appearance.gap) })
              .alignSelf(ItemAlign.Center)
          }
          Text(this.text)
            .fontSize(lhVp(this.appearance.fontSize))
            .fontColor(this.appearance.contentColor)
            .maxLines(2)
            .textOverflow(TextOverflow.Ellipsis)
        }
        .padding({
          left: lhVp(this.appearance.paddingHorizontal),
          right: lhVp(this.appearance.paddingHorizontal),
          top: lhVp(this.appearance.paddingVertical),
          bottom: lhVp(this.appearance.paddingVertical),
        })
        .backgroundColor(this.appearance.containerColor)
        .borderRadius(lhVp(this.appearance.borderRadius))
        .constraintSize({ maxWidth: `${this.appearance.maxWidthPercent}%` })
        .zIndex(this.appearance.zIndex)
      }
      .width('100%')
      .height('100%')
      .alignContent(this.alignForPosition())
      .padding(this.edgePadding())
    }
  }

  /** position → Stack 对齐方式 */
  private alignForPosition(): Alignment {
    switch (this.position) {
      case LhToastPosition.Top:
        return Alignment.Top
      case LhToastPosition.Bottom:
        return Alignment.Bottom
      case LhToastPosition.Center:
        return Alignment.Center
    }
  }

  /** 上下两端留 spacing.xl 边距（center 时无留白） */
  private edgePadding(): Padding {
    const margin = lhVp(this.appearance.edgeMargin)
    switch (this.position) {
      case LhToastPosition.Top:
        return { top: margin }
      case LhToastPosition.Bottom:
        return { bottom: margin }
      case LhToastPosition.Center:
        return {}
    }
  }
}
