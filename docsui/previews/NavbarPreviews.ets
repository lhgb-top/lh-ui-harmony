/**
 * Navbar 文档页的真交互预览（对应 `docs/components/navbar.md` 的 `##` 分节）。
 */
import { LhNavbar } from '../../components/navbar/Index'
import { LhToastController } from '../../components/toast/Index'
import { lhVp } from '../../common/LhVp'
import { LhTokens } from '../../tokens/LhTokens'
import { DocPreviewFrame, DocProse } from '../widgets/DocWidgets'

/** 基本用法：标题 + 左右文字按钮，各自触发回调。 */
@Component
export struct NavbarBasicPreview {
  toast: LhToastController = new LhToastController()

  build() {
    DocPreviewFrame({ title: '左侧文字 + 图标；右侧文字；点击分别触发回调' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhNavbar({
          title: '页面标题',
          leftText: '返回',
          leftIcon: 'back',
          rightText: '操作',
          onLeftClick: () => this.toast.show('onLeftClick：返回'),
          onRightClick: () => this.toast.show('onRightClick：操作'),
        })
        DocProse({ text: 'leftText / leftIcon / rightText / rightIcon 任一非空即渲染对应区域。', secondary: true })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 纯图标与无分隔线：只给图标、不传文字；bordered = false 去掉底部分隔线。 */
@Component
export struct NavbarIconAndBorderlessPreview {
  toast: LhToastController = new LhToastController()

  build() {
    DocPreviewFrame({ title: 'leftIcon / rightIcon 纯图标；bordered = false 无分隔线' }) {
      Column({ space: lhVp(LhTokens.Spacing.sm) }) {
        LhNavbar({
          title: '纯图标导航',
          leftIcon: 'back',
          rightIcon: 'more',
          bordered: false,
          onLeftClick: () => this.toast.show('onLeftClick：back 图标'),
          onRightClick: () => this.toast.show('onRightClick：more 图标'),
        })
        LhNavbar({
          title: '图标 + 文字混排',
          leftText: '返回',
          leftIcon: 'back',
          rightIcon: 'edit',
          onLeftClick: () => this.toast.show('onLeftClick'),
          onRightClick: () => this.toast.show('onRightClick'),
        })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}
