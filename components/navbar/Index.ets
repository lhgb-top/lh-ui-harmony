import { LhNavbarTokens, LhNavbarAppearance } from './LhNavbarTokens'
import { LH_COLORS_KEY, LightLhColors, LhColors } from '../../common/theme/LhTheme'
import { LhIcon } from '../icon/Index'
import { LhIconTokens } from '../icon/LhIconTokens'
import { lhVp } from '../../common/LhVp'

/**
 * 导航栏组件：页面顶部标题栏（ArkUI 手写）。
 *
 * props 与 `lh-ui-core/specs/navbar.json` 逐字对齐；行为遵循 `cases/navbar.json`
 * 的 6 条黄金用例（已翻译为 hypium 测试，见 entry/src/test/Navbar.test.ets）。
 *
 * 左中右三段布局：标题水平居中于可用宽度；左/右区域存在内容时可点击，
 * 分别触发 onLeftClick/onRightClick；无内容时不响应点击。
 * 层级取 zIndex.sticky，宿主将其作为页面顶部固定栏。
 */
@Component
export struct LhNavbar {
  /** 中间标题 */
  @Prop title: string = ''
  /** 左侧按钮文字；与 leftIcon 二者非空时都显示 */
  @Prop leftText: string = ''
  /** 左侧图标名（本地字形体系渲染） */
  @Prop leftIcon?: string = undefined
  /** 右侧按钮文字；与 rightIcon 二者非空时都显示 */
  @Prop rightText: string = ''
  /** 右侧图标名（本地字形体系渲染） */
  @Prop rightIcon?: string = undefined
  /** 是否绘制底部分隔线 */
  @Prop @Watch('recompute') bordered: boolean = true

  /** 点击左侧区域时触发（回调属性不加 @Prop） */
  onLeftClick: () => void = () => {}
  /** 点击右侧区域时触发 */
  onRightClick: () => void = () => {}

  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''

  private appearance: LhNavbarAppearance = LhNavbarTokens.resolve(true, LightLhColors())

  aboutToAppear(): void {
    this.recompute()
  }

  private recompute(): void {
    let colors = LightLhColors()
    if (this.colorsJson !== '') {
      colors = JSON.parse(this.colorsJson) as LhColors
    }
    this.appearance = LhNavbarTokens.resolve(this.bordered, colors)
  }

  build() {
    Stack() {
      // 标题：水平居中于可用宽度
      Text(this.title)
        .fontSize(lhVp(this.appearance.titleFontSize))
        .fontColor(this.appearance.titleColor)
        .fontWeight(FontWeight.Bold)
        .maxLines(1)
        .textOverflow(TextOverflow.Ellipsis)
        .constraintSize({ maxWidth: '60%' })

      // 左中右三段：左/右区域存在内容时可点击
      Row() {
        // 左侧区域
        if (this.leftText !== '' || this.leftIcon !== undefined) {
          Row() {
            if (this.leftIcon !== undefined) {
              LhIcon({ name: this.mappedIcon(this.leftIcon) })
                .margin({ right: lhVp(this.appearance.paddingHorizontal) })
            }
            if (this.leftText !== '') {
              Text(this.leftText)
                .fontSize(lhVp(this.appearance.titleFontSize))
                .fontColor(this.appearance.titleColor)
            }
          }
          .alignItems(VerticalAlign.Center)
          .onClick(() => {
            this.onLeftClick()
          })
        }

        Blank()

        // 右侧区域
        if (this.rightText !== '' || this.rightIcon !== undefined) {
          Row() {
            if (this.rightText !== '') {
              Text(this.rightText)
                .fontSize(lhVp(this.appearance.titleFontSize))
                .fontColor(this.appearance.titleColor)
                .margin({ right: lhVp(this.appearance.paddingHorizontal) })
            }
            if (this.rightIcon !== undefined) {
              LhIcon({ name: this.mappedIcon(this.rightIcon) })
            }
          }
          .alignItems(VerticalAlign.Center)
          .onClick(() => {
            this.onRightClick()
          })
        }
      }
      .width('100%')
      .height('100%')
      .padding({
        left: lhVp(this.appearance.paddingHorizontal),
        right: lhVp(this.appearance.paddingHorizontal),
      })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(lhVp(this.appearance.height))
    .backgroundColor(this.appearance.containerColor)
    .zIndex(this.appearance.zIndex)
    .border({
      width: { bottom: lhVp(this.appearance.borderWidth) },
      color: { bottom: this.appearance.dividerColor === undefined ? Color.Transparent : this.appearance.dividerColor },
    })
  }

  /** 左右图标名映射到本地字形体系（导航栏常用返回/更多） */
  private mappedIcon(name: string): string {
    if (name === 'back') {
      return LhIconTokens.glyphFor('back')
    }
    return name
  }
}
