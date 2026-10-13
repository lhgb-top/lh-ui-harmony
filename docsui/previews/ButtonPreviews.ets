/**
 * Button 文档页的真交互预览（对应 `docs/components/button.md` 的 `##` 分节）。
 *
 * 约定：预览只做交互演示，外观全部由组件自身的令牌解析（零字面量）；点击类回调
 * 通过宿主注入的 `toast` 控制器反馈，指令式组件的演示在自身 Stack 内挂浮层。
 */
import { LhButton } from '../../components/button/Index'
import { LhButtonType, LhButtonSize } from '../../components/button/LhButtonTokens'
import { LhToastController } from '../../components/toast/Index'
import { LhTheme } from '../../common/theme/LhThemeApply'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocPreviewFrame, DocProse } from '../widgets/DocWidgets'

/** 类型：六种类型决定底色与文字色。 */
@Component
export struct ButtonTypesPreview {
  toast: LhToastController = new LhToastController()

  build() {
    DocPreviewFrame({ title: '六种类型决定底色与文字色（点击触发 onClick 回调）' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        Row({ space: lhVp(LhTokens.Spacing.sm) }) {
          LhButton({ onClick: () => this.toast.show('onClick：默认类型'), type: LhButtonType.Default, text: '默认按钮' })
          LhButton({ onClick: () => this.toast.show('onClick：主要类型'), type: LhButtonType.Primary, text: '主要按钮' })
        }
        Row({ space: lhVp(LhTokens.Spacing.sm) }) {
          LhButton({ onClick: () => this.toast.show('onClick：成功类型'), type: LhButtonType.Success, text: '成功按钮' })
          LhButton({ onClick: () => this.toast.show('onClick：警告类型'), type: LhButtonType.Warning, text: '警告按钮' })
        }
        Row({ space: lhVp(LhTokens.Spacing.sm) }) {
          LhButton({ onClick: () => this.toast.show('onClick：危险类型'), type: LhButtonType.Danger, text: '危险按钮' })
          LhButton({ onClick: () => this.toast.show('onClick：信息类型'), type: LhButtonType.Info, text: '信息按钮' })
        }
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 尺寸：三档映射到 height / paddingHorizontal / fontSize 令牌。 */
@Component
export struct ButtonSizesPreview {
  toast: LhToastController = new LhToastController()

  build() {
    DocPreviewFrame({ title: '三档尺寸：small / medium / large' }) {
      Row({ space: lhVp(LhTokens.Spacing.md) }) {
        LhButton({ onClick: () => this.toast.show('small'), size: LhButtonSize.Small, type: LhButtonType.Primary, text: '小型按钮' })
        LhButton({ onClick: () => this.toast.show('medium'), type: LhButtonType.Primary, text: '中型按钮' })
        LhButton({ onClick: () => this.toast.show('large'), size: LhButtonSize.Large, type: LhButtonType.Primary, text: '大型按钮' })
      }
      .alignItems(VerticalAlign.Center)
    }
  }
}

/** 状态：禁用与加载中都不触发 onClick，两者共存时禁用优先。 */
@Component
export struct ButtonStatesPreview {
  toast: LhToastController = new LhToastController()

  build() {
    DocPreviewFrame({ title: '禁用 / 加载中 / 禁用优先（三者均不触发 onClick）' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        Row({ space: lhVp(LhTokens.Spacing.sm) }) {
          LhButton({ onClick: () => this.toast.show('正常按钮可点击'), type: LhButtonType.Primary, text: '正常' })
          LhButton({ onClick: () => this.toast.show('不会触发'), type: LhButtonType.Primary, disabled: true, text: '禁用' })
        }
        Row({ space: lhVp(LhTokens.Spacing.sm) }) {
          LhButton({ onClick: () => this.toast.show('不会触发'), type: LhButtonType.Primary, loading: true, text: '加载中' })
          LhButton({
            onClick: () => this.toast.show('不会触发'),
            type: LhButtonType.Primary, disabled: true, loading: true, text: '禁用优先',
          })
        }
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 图标与花纹底：图标名按本地图标体系解析，花纹底消费 color.decoration 令牌。 */
@Component
export struct ButtonIconAndPatternPreview {
  toast: LhToastController = new LhToastController()

  build() {
    DocPreviewFrame({ title: 'icon 按名解析；bgPattern 绘制 45° 花纹底' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        Row({ space: lhVp(LhTokens.Spacing.sm) }) {
          LhButton({ onClick: () => this.toast.show('search'), type: LhButtonType.Primary, icon: 'search', text: '搜索' })
          LhButton({ onClick: () => this.toast.show('check'), icon: 'check', text: '校验' })
        }
        Row({ space: lhVp(LhTokens.Spacing.sm) }) {
          LhButton({
            onClick: () => this.toast.show('主要花纹底'),
            type: LhButtonType.Primary, bgPattern: true, text: '主要花纹底',
          })
          LhButton({ onClick: () => this.toast.show('默认花纹底'), bgPattern: true, text: '默认花纹底' })
        }
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/**
 * 明暗主题：ArkUI 主题是全局的（AppStorage），这里直接调用 LhTheme.apply
 * 切换全局明暗，整页（含宿主顶栏）热重绘——即 D18 的主题消费模式演示。
 */
@Component
export struct ButtonThemePreview {
  toast: LhToastController = new LhToastController()
  build() {
    DocPreviewFrame({ title: '点击切换全局明暗主题，按钮底色 / 文字色热重绘' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhButton({
          onClick: () => LhTheme.apply(!LhTheme.isDark),
          type: LhButtonType.Primary,
          text: '切换全局明暗主题',
        })
        DocProse({ text: '明/暗色值全部取自 core 令牌快照；切换后顶栏、预览框与所有组件同步重绘。', secondary: true })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}
