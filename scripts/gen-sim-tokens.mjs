/**
 * 文档模拟器令牌生成（HTML 模拟器方案，总纲 D19）。
 *
 * 原生 UI 无法在浏览器实时渲染，文档站用 HTML 手机框模拟外观。本脚本把
 * core 的平台中性令牌快照（dist/docs/tokens.light.json / tokens.dark.json）
 * 转成 CSS 自定义属性，供模拟器样式消费：
 *
 *   :root { --lh-color-primary-default:#2B4C7C; --lh-button-height-medium:40px; ... }
 *   html.dark { --lh-color-primary-default:#3D649E; ... }
 *
 * 要点：
 * - 明色全量写 :root；暗色只写覆盖键（与 core docs target 的浅合并语义同构，
 *   未覆盖键靠 CSS 级联继承明色值——与 android/ios/harmony 的并列对象模型一致）
 * - VitePress 暗色即在 <html class="dark">，故选择器用 html.dark，随站点开关自动联动
 * - 暗色预计算已在 core 完成（R-n6），本脚本不做任何运行时调色
 *
 * 令牌 JSON 来源同样走三级守卫（本地 dist 优先）。`pnpm docs:dev` / `docs:build`
 * 前自动执行。
 */

import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs'
import { resolve } from 'node:path'

const REPO_ROOT = resolve(import.meta.dirname, '..')
const CORE_ROOT = resolve(REPO_ROOT, '..', 'lh-ui-core')
const OUT = resolve(REPO_ROOT, 'docs', '.vitepress', 'theme', 'sim-tokens.css')

function resolveDocsDir() {
  const local = resolve(CORE_ROOT, 'dist', 'docs')
  if (existsSync(local)) return local
  const npm = resolve(REPO_ROOT, 'node_modules', '@lh-ui', 'core', 'dist', 'docs')
  if (existsSync(npm)) return npm
  return null
}

/** 令牌点路径转 CSS 变量名：color.primary.default → --lh-color-primary-default */
function cssVarName(path) {
  return `--lh-${path.replaceAll('.', '-')}`
}

/**
 * 令牌值转 CSS 值：
 * - 字符串原样可用（hex / rgba / px / s / 百分号 / 字体栈）
 * - 数字直接输出（字重、层级）
 * - 数组（cubicBezier 控制点）转 cubic-bezier() 函数
 */
function cssValue(value) {
  if (Array.isArray(value)) return `cubic-bezier(${value.join(', ')})`
  return String(value)
}

function buildBlock(selector, entries) {
  const lines = [selector, ' {']
  for (const [path, value] of entries) {
    lines.push(`  ${cssVarName(path)}: ${cssValue(value)};`)
  }
  lines.push('}')
  return lines.join('\n')
}

function main() {
  const docsDir = resolveDocsDir()
  if (!docsDir) {
    console.error(
      '❌ 未找到令牌快照：既无本地 ../lh-ui-core/dist/docs，也无 node_modules/@lh-ui/core/dist/docs。\n' +
        '请先 `cd ../lh-ui-core && pnpm codegen`，或安装 @lh-ui/core。',
    )
    process.exitCode = 1
    return
  }

  const light = JSON.parse(readFileSync(resolve(docsDir, 'tokens.light.json'), 'utf8'))
  const dark = JSON.parse(readFileSync(resolve(docsDir, 'tokens.dark.json'), 'utf8'))

  // 明色全量；暗色只写覆盖键（浅合并）
  const lightEntries = Object.entries(light).sort(([a], [b]) => a.localeCompare(b))
  const darkEntries = Object.entries(dark).sort(([a], [b]) => a.localeCompare(b))

  const header = [
    '/* =====================================================================================',
    ' * 本文件由 scripts/gen-sim-tokens.mjs 自动生成（源：@lh-ui/core dist/docs 令牌快照），',
    ' * 请勿手改。改令牌请编辑 lh-ui-core 仓的 tokens/*.json 后重跑 pnpm codegen + pnpm gen:sim。',
    ' * 暗色只列覆盖键，未覆盖键继承 :root（与 core docs target 浅合并语义同构）。',
    ' * ===================================================================================== */',
  ].join('\n')

  const css = [
    header,
    '',
    buildBlock(':root', lightEntries),
    '',
    buildBlock('html.dark', darkEntries),
    '',
  ].join('\n')

  mkdirSync(resolve(OUT, '..'), { recursive: true })
  writeFileSync(OUT, css, 'utf8')
  console.log(
    `✅ 模拟器令牌已生成：${lightEntries.length} 个明色 + ${darkEntries.length} 个暗色覆盖 → docs/.vitepress/theme/sim-tokens.css`,
  )
}

main()
