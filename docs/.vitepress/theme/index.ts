import type { Theme } from 'vitepress'
import DefaultTheme from 'vitepress/theme'
import './style.css'
// 模拟器：基础手机框 + 平台外观 + 生成的令牌 CSS 变量（D19）
import './sim/base.css'
import './sim/harmony.css'
import './sim-tokens.css'

export default {
  extends: DefaultTheme,
  enhanceApp() {
    // 站点不注册任何组件：模拟器是 md 内联的静态 HTML，零运行时框架依赖
  },
} satisfies Theme
