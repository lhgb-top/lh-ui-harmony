import { LhButtonType, LhButtonSize, LhButtonTokens, LhButtonAppearance } from './LhButtonTokens'
import { LH_COLORS_KEY, LightLhColors, LhColors } from '../../common/theme/LhTheme'
import { LhTokens } from '../../tokens/LhTokens'

/**
 * 按钮组件：触发即时操作（ArkUI 手写，core codegen 不生成组件体）。
 *
 * props 与 `lh-ui-core/specs/button.json` 逐字对齐；行为遵循 `cases/button.json`
 * 的 8 条黄金用例（已翻译为 hypium 测试，见 tests/Button.test.ets）。
 *
 * 主题：应用入口把 LhColors 序列化进 AppStorage（LH_COLORS_KEY，LhTheme 工具函数负责），
 * 组件在 aboutToAppear 读取；未注入时回退明色板。
 */
@Component
export struct LhButton {
  /** 点击回调；disabled 或 loading 为 true 时不触发（回调属性不加 @Prop：ArkTS 装饰器不支持函数类型） */
  onClick: () => void = () => {}
  /** 按钮类型，决定底色与文字色 */
  @Prop type: LhButtonType = LhButtonType.Default
  /** 按钮尺寸，映射到 button.height / paddingHorizontal / fontSize / iconSize 令牌 */
  @Prop size: LhButtonSize = LhButtonSize.Medium
  /** 是否禁用；禁用时不响应点击并呈现禁用样式（disabled.* 令牌） */
  @Prop disabled: boolean = false
  /** 是否加载中；加载中显示指示器且点击不触发 onClick */
  @Prop loading: boolean = false
  /** 图标名（本地图标体系，见 LhButtonTokens.iconFor），按钮内左侧绘制 */
  @Prop icon?: string = undefined
  /** 是否绘制国风花纹底纹（消费 color.decoration 令牌） */
  @Prop bgPattern: boolean = false
  /** 按钮文字内容（spec 的 default 插槽） */
  @Prop text: string = ''

  /** 外观解析结果：aboutToAppear 与 props 变化时重算 */
  private appearance: LhButtonAppearance = LhButtonTokens.resolve(
    LhButtonType.Default,
    LhButtonSize.Medium,
    false,
    false,
    false,
    LightLhColors(),
  )

  aboutToAppear(): void {
    this.recompute()
  }

  /** 从 AppStorage 还原色板并重算外观（ArkTS 的 AppStorage 只收可序列化类型，色板以 JSON 传递） */
  private recompute(): void {
    let colors = LightLhColors()
    const stored = AppStorage.get<string>(LH_COLORS_KEY)
    if (stored !== undefined && stored !== '') {
      colors = JSON.parse(stored) as LhColors
    }
    this.appearance = LhButtonTokens.resolve(
      this.type, this.size, this.disabled, this.loading, this.bgPattern, colors,
    )
  }

  /** 字重令牌（Int）→ ArkUI FontWeight。生成令牌是 400/600 数值。 */
  private fontWeight(): FontWeight {
    return LhTokensButtonFontWeight >= 600 ? FontWeight.Bold : FontWeight.Normal
  }

  build() {
    Stack() {
      // 花纹底纹（垫在底色之下；不影响文字对比度）
      if (this.appearance.patternColor !== undefined) {
        LhPatternFill({ patternColor: this.appearance.patternColor })
      }

      Row() {
        if (this.loading) {
          LoadingProgress()
            .width(lhVp(this.appearance.iconSize))
            .height(lhVp(this.appearance.iconSize))
            .color(this.appearance.contentColor)
        } else if (this.icon !== undefined) {
          Text('◆')
            .fontSize(lhVp(this.appearance.iconSize))
            .fontColor(this.appearance.contentColor)
        }
        Text(this.text)
          .fontSize(lhVp(this.appearance.fontSize))
          .fontWeight(this.fontWeight())
          .fontColor(this.appearance.contentColor)
      }
      .justifyContent(FlexAlign.Center)
    }
    .width('auto')
    .height(lhVp(this.appearance.height))
    .padding({ left: lhVp(this.appearance.paddingHorizontal), right: lhVp(this.appearance.paddingHorizontal) })
    .backgroundColor(this.appearance.containerColor)
    .borderRadius(lhVp(this.appearance.borderRadius))
    .border({
      width: lhVp(this.appearance.borderWidth),
      color: this.appearance.borderColor,
    })
    .shadow({
      radius: LhTokens.Shadow.lighter.radius,
      color: LhTokens.Shadow.lighter.color,
      offsetX: LhTokens.Shadow.lighter.offsetX,
      offsetY: LhTokens.Shadow.lighter.offsetY,
    })
    .enabled(this.appearance.enabled)
    .onClick(() => {
      // 状态 gate：disabled 与 loading 均不触发（.enabled() 已拦截，此处双保险）
      if (this.appearance.enabled) {
        this.onClick()
      }
    })
  }
}

/** 字重令牌取值（button.fontWeight = typography.fontWeight.primary） */
const LhTokensButtonFontWeight = 400

/** 国风花纹底纹：45° 斜纹叠加（消费 color.decoration 令牌），与 web 血脉方案对齐 */
@Component
struct LhPatternFill {
  @Prop patternColor: ResourceColor = Color.Transparent

  build() {
    Canvas(this.onDraw)
      .width('100%')
      .height('100%')
  }

  private onDraw = (context: CanvasRenderingContext2D): void => {
    const step = 16
    context.strokeStyle = this.patternColor as string
    context.lineWidth = 1
    for (let x = -300; x < 600; x += step) {
      context.beginPath()
      context.moveTo(x, 0)
      context.lineTo(x + 300, 300)
      context.stroke()
    }
  }
}

/** 尺寸数值（vp 令牌）→ Dimension */
function lhVp(n: number): number {
  return n
}
