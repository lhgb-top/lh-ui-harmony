import { defineConfig } from 'vitepress'
import { readFileSync, existsSync } from 'node:fs'
import { resolve } from 'node:path'

// DOCS_BASE 必须显式读 env：Vite 内置 env 加载在用户 config 求值之后，
// 直接读 process.env.DOCS_BASE 生产构建拿不到 .env.production 的值。
// （不引 'vite' 的 loadEnv：vite 只是 vitepress 的间接依赖，根级不可解析）
function loadDocsEnv(mode: string, dir: string, prefix: string): Record<string, string> {
  const env: Record<string, string> = {}
  const files = ['.env', `.env.${mode}`, '.env.local', `.env.${mode}.local`]
  for (const f of files) {
    const p = resolve(dir, f)
    if (!existsSync(p)) continue
    for (const line of readFileSync(p, 'utf-8').split('\n')) {
      const m = line.match(/^\s*([A-Za-z_][\w]*)\s*=\s*(.*)\s*$/)
      if (!m) continue
      const [, key, val] = m
      if (key.startsWith(prefix)) env[key] = val.replace(/^['"]|['"]$/g, '')
    }
  }
  return env
}

const mode = process.env.NODE_ENV === 'production' ? 'production' : 'development'
const env = loadDocsEnv(mode, resolve(__dirname, '..'), 'DOCS_')

const base = env.DOCS_BASE || '/'
const hostname = (env.DOCS_HOSTNAME || 'https://www.lhgb.top').replace(/\/$/, '')

// 数据驱动侧边栏：新增组件只需在此加一条
const componentGroups = [
  {
    text: '基础组件',
    items: [
      { text: 'Button 按钮', slug: 'button' },
      { text: 'Icon 图标', slug: 'icon' },
      { text: 'Tag 标签', slug: 'tag' },
      { text: 'Cell 单元格', slug: 'cell' },
      { text: 'Text 文本', slug: 'text' },
    ],
  },
  {
    text: '表单组件',
    items: [
      { text: 'Input 输入框', slug: 'input' },
      { text: 'Textarea 多行输入', slug: 'textarea' },
      { text: 'Checkbox 复选框', slug: 'checkbox' },
      { text: 'Radio 单选框', slug: 'radio' },
      { text: 'Switch 开关', slug: 'switch' },
      { text: 'Picker 选择器', slug: 'picker' },
    ],
  },
  {
    text: '反馈组件',
    items: [
      { text: 'Dialog 对话框', slug: 'dialog' },
      { text: 'Toast 轻提示', slug: 'toast' },
      { text: 'Loading 加载', slug: 'loading' },
    ],
  },
  {
    text: '导航组件',
    items: [{ text: 'Navbar 导航栏', slug: 'navbar' }],
  },
]

const guideGroups = [
  { text: '介绍', slug: 'introduction' },
  { text: '安装', slug: 'installation' },
  { text: '快速开始', slug: 'quickstart' },
  { text: '主题与暗色', slug: 'theming' },
  { text: '本地联调', slug: 'local-linking' },
]

function buildSidebar(prefix, entries) {
  return entries.map((group) => {
    if (group.items) {
      return {
        text: group.text,
        items: group.items.map((item) => ({ text: item.text, link: `${prefix}/${item.slug}` })),
      }
    }
    return { text: group.text, link: `${prefix}/${group.slug}` }
  })
}

export default defineConfig({
  lang: 'zh-CN',
  title: 'lh-ui-harmony',
  description: 'lh-ui 原生血脉鸿蒙端 —— ArkTS + ArkUI 组件库（HarmonyOS NEXT）',
  base,
  cleanUrls: true,
  lastUpdated: true,

  head: [
    ['link', { rel: 'icon', href: `${base}logo.svg` }],
    ['meta', { property: 'og:url', content: hostname + base }],
    ['meta', { property: 'og:site_name', content: 'lh-ui-harmony' }],
  ],

  // search 必须放在顶层 themeConfig：VitePress 的 __VP_LOCAL_SEARCH__ 编译期常量
  // 判定的是顶层 site.themeConfig.search，放 locale 下会导致搜索 UI 完全不渲染。
  // locale 级 themeConfig 会与顶层合并，nav/sidebar/footer 等不受影响。
  themeConfig: {
    search: { provider: 'local' },
  },

  locales: {
    root: {
      label: '简体中文',
      lang: 'zh-CN',
      themeConfig: {
        nav: [
          { text: '指南', link: '/guide/introduction' },
          { text: '组件', link: '/components/button' },
          { text: '家族', items: [
            { text: 'lh-ui（总览）', link: 'https://www.lhgb.top' },
            { text: 'lh-ui-plus（Vue3）', link: 'https://www.lhgb.top/lhui/plus/' },
          ] },
        ],
        sidebar: {
          '/guide/': buildSidebar('/guide', guideGroups),
          '/components/': buildSidebar('/components', componentGroups),
        },
        outline: { level: [2, 3], label: '本页目录' },
        socialLinks: [{ icon: 'github', link: 'https://github.com/lhgb-top/lh-ui-harmony' }],
        footer: {
          message: 'lh-ui 原生血脉 · 鸿蒙端（ArkTS + ArkUI）',
          copyright: 'Apache-2.0 License',
        },
      },
    },
  },

  vite: {
    // 模拟器令牌 CSS 由 scripts/gen-sim-tokens.mjs 生成（docs:dev / docs:build 前自动跑）
    // 站点主题只引静态 CSS，无运行时框架依赖（D19）
  },
})
