import { defineConfig } from 'vitepress'
import { loadEnv } from 'vite'
import { resolve } from 'node:path'

// DOCS_BASE 必须显式 loadEnv：Vite 内置 env 加载在用户 config 求值之后，
// 直接读 process.env.DOCS_BASE 生产构建拿不到 .env.production 的值。
const mode = process.env.NODE_ENV === 'production' ? 'production' : 'development'
const env = loadEnv(mode, resolve(__dirname, '..'), 'DOCS_')

const base = env.DOCS_BASE || '/'
const hostname = (env.DOCS_HOSTNAME || 'https://www.lhgb.top').replace(/\/$/, '')

// 数据驱动侧边栏：新增组件只需在此加一条
const componentGroups = [
  {
    text: '基础组件',
    items: [{ text: 'Button 按钮', slug: 'button' }],
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
        socialLinks: [{ icon: 'github', link: 'https://github.com/lhgb/lh-ui' }],
        search: { provider: 'local' },
        footer: {
          message: 'lh-ui 原生血脉 · 鸿蒙端（ArkTS + ArkUI）',
          copyright: 'MIT License',
        },
      },
    },
  },

  vite: {
    // 模拟器令牌 CSS 由 scripts/gen-sim-tokens.mjs 生成（docs:dev / docs:build 前自动跑）
    // 站点主题只引静态 CSS，无运行时框架依赖（D19）
  },
})
