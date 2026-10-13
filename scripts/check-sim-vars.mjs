/**
 * 模拟器变量名守卫（CI 门禁）。
 *
 * 模拟器样式（sim/*.css、style.css）只吃 var(--lh-*) 令牌变量，红线是零令牌字面量。
 * 但 gen-sim-tokens.mjs 生成的变量名保留令牌点路径的驼峰（--lh-button-paddingHorizontal-medium），
 * 手写 CSS 一旦按 kebab 习惯写（--lh-button-padding-horizontal-medium）就会静默失配，
 * 变量未定义、样式悄悄失效。本脚本把这类失配拦在 CI：
 *
 *   pnpm sim:check
 *
 * 逻辑：收集主题 CSS 里所有 var(--lh-*) 引用，与 sim-tokens.css 的定义做全量 diff，
 * 只允许声明过的变量被引用（含 var(--x, fallback) 回退写法，取主变量名校验）。
 */

import { readFileSync, readdirSync, statSync, existsSync } from 'node:fs'
import { resolve, relative, join } from 'node:path'

const REPO_ROOT = resolve(import.meta.dirname, '..')
const THEME_DIR = resolve(REPO_ROOT, 'docs', '.vitepress', 'theme')
const SIM_TOKENS = resolve(THEME_DIR, 'sim-tokens.css')

/** 递归收集目录下所有 .css（排除生成物） */
function collectCss(dir, acc = []) {
  for (const name of readdirSync(dir)) {
    const p = join(dir, name)
    const st = statSync(p)
    if (st.isDirectory()) collectCss(p, acc)
    else if (name.endsWith('.css') && p !== SIM_TOKENS) acc.push(p)
  }
  return acc
}

/** 从一段 CSS 文本里提取所有 var(--lh-*) 引用，返回 [{ line, var }] */
function extractVarRefs(text) {
  const refs = []
  const lines = text.split('\n')
  lines.forEach((line, i) => {
    // 匹配 var(--lh-xxx，兼容 var(--lh-xxx, fallback)
    const re = /var\((--lh-[A-Za-z0-9-]+)/g
    let m
    while ((m = re.exec(line)) !== null) refs.push({ line: i + 1, var: m[1] })
  })
  return refs
}

function main() {
  if (!existsSync(SIM_TOKENS)) {
    console.error(
      '❌ 未找到 sim-tokens.css（生成物）。请先 `pnpm gen:sim`。',
    )
    process.exitCode = 1
    return
  }

  // 已定义的令牌变量（:root + html.dark 合并）
  const defined = new Set()
  for (const line of readFileSync(SIM_TOKENS, 'utf-8').split('\n')) {
    const m = line.match(/^\s*(--lh-[A-Za-z0-9-]+)\s*:/)
    if (m) defined.add(m[1])
  }

  const files = collectCss(THEME_DIR)
  const missing = []
  let checked = 0

  for (const file of files) {
    const text = readFileSync(file, 'utf-8')
    for (const ref of extractVarRefs(text)) {
      checked++
      if (!defined.has(ref.var)) {
        missing.push({ file: relative(REPO_ROOT, file), ...ref })
      }
    }
  }

  if (missing.length === 0) {
    console.log(`✅ 模拟器变量名校验通过：${checked} 个 var(--lh-*) 引用全部有定义（${defined.size} 个令牌变量）。`)
    return
  }

  console.error(`❌ 模拟器引用了 ${missing.length} 个未定义的令牌变量（共检查 ${checked} 个引用）：\n`)
  for (const m of missing) {
    console.error(`  ${m.file}:${m.line}  var(${m.var})`)
  }
  console.error('\n变量名必须与 sim-tokens.css 的生成名逐字一致（令牌点路径保留驼峰，如 paddingHorizontal）。')
  console.error('改令牌请去 lh-ui-core 仓的 tokens/*.json → pnpm codegen → 本仓 pnpm gen:sim。')
  process.exitCode = 1
}

main()
