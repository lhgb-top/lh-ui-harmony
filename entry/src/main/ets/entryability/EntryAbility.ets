import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { window } from '@kit.ArkUI'
import { LhTheme } from '../../../common/theme/LhThemeApply'

const DOMAIN = 0x0000
const TAG = 'LhDemo'

/**
 * 演示应用入口 Ability。窗口创建后注入明色板（LhTheme.apply）。
 */
export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(DOMAIN, TAG, 'Ability onCreate')
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent('pages/Index', () => {
      LhTheme.apply(false)
      hilog.info(DOMAIN, TAG, 'Succeeded in loading the content')
    })
  }
}
