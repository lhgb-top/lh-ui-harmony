import { LhColors, LightLhColors, DarkLhColors, LH_COLORS_KEY, LH_IS_DARK_KEY } from '../../common/theme/LhTheme'

/**
 * 主题工具：把明/暗色板序列化进 AppStorage，供所有 Lh 组件 @StorageProp 消费。
 * 应用入口（EntryAbility onWindowStageCreate 或首页 aboutToAppear）调用一次即可。
 *
 * 用法：
 *   LhTheme.apply(isDark)          // 切换主题
 *   const isDark = LhTheme.isDark  // 读当前态
 */
export class LhTheme {
  static apply(isDark: boolean): void {
    const colors: LhColors = isDark ? DarkLhColors() : LightLhColors()
    AppStorage.setOrCreate(LH_COLORS_KEY, JSON.stringify(colors))
    AppStorage.setOrCreate(LH_IS_DARK_KEY, isDark)
  }

  static get isDark(): boolean {
    return AppStorage.get<boolean>(LH_IS_DARK_KEY) ?? false
  }
}
