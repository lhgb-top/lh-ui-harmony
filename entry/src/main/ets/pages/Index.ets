import { LhButton } from '../../../../components/button/Index'
import { LhButtonType, LhButtonSize } from '../../../../components/button/LhButtonTokens'
import { LhTheme } from '../../../../common/theme/LhThemeApply'

/**
 * 演示应用首页（等价 dev 沙箱）：展示 button 全形态。
 * 应用入口先调 LhTheme.apply(false) 注入明色板（切暗色传 true）。
 */
@Entry
@Component
struct Index {
  @State isDark: boolean = false

  aboutToAppear(): void {
    LhTheme.apply(this.isDark)
  }

  build() {
    Column({ space: 12 }) {
      Text('lh-ui-harmony · button 打样')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)

      Row({ space: 8 }) {
        LhButton({ onClick: () => {}, text: '默认按钮' })
        LhButton({ onClick: () => {}, type: LhButtonType.Primary, text: '主要按钮' })
      }

      Row({ space: 8 }) {
        LhButton({ onClick: () => {}, type: LhButtonType.Success, text: '成功' })
        LhButton({ onClick: () => {}, type: LhButtonType.Warning, text: '警告' })
        LhButton({ onClick: () => {}, type: LhButtonType.Danger, text: '危险' })
      }

      Row({ space: 8 }) {
        LhButton({ onClick: () => {}, size: LhButtonSize.Small, text: '小型' })
        LhButton({ onClick: () => {}, size: LhButtonSize.Large, type: LhButtonType.Primary, text: '大型' })
      }

      Row({ space: 8 }) {
        LhButton({ onClick: () => {}, type: LhButtonType.Primary, disabled: true, text: '禁用' })
        LhButton({ onClick: () => {}, type: LhButtonType.Primary, loading: true, text: '加载中' })
      }

      Row({ space: 8 }) {
        LhButton({ onClick: () => {}, type: LhButtonType.Primary, icon: 'search', text: '搜索' })
        LhButton({ onClick: () => {}, type: LhButtonType.Primary, bgPattern: true, text: '花纹底' })
      }

      Button(this.isDark ? '切明色' : '切暗色')
        .onClick(() => {
          this.isDark = !this.isDark
          LhTheme.apply(this.isDark)
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.isDark ? '#1E1A16' : '#F5F0EB')
  }
}
