// check-docs.mjs —— docsui 模块一致性校验（CI 门禁，对齐 link:tokens:check / sim:check 的定位）
//
// 三项检查：
//   1. 生成页引用的预览结构体与 previews/ 的手写声明双向一致（无缺漏、无孤儿）
//   2. docsui/ 全树无未使用的 import（漂移的信号）
//   3. pages/ 的页面结构与 DocRegistry / DocPageDispatch 的登记项一致
//
// 用法：pnpm docs:check

import { readFileSync, readdirSync, statSync } from 'node:fs'
import { resolve, join, extname, dirname } from 'node:path'
import { fileURLToPath } from 'node:url'

const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), '..')
const PAGES = resolve(ROOT, 'docsui/pages')
const PREVIEWS = resolve(ROOT, 'docsui/previews')
const DOCSUI = resolve(ROOT, 'docsui')

function walk(dir, out) {
  for (const f of readdirSync(dir)) {
    const p = join(dir, f)
    if (statSync(p).isDirectory()) walk(p, out)
    else if (extname(f) === '.ets') out.push(p)
  }
  return out
}

function escapeRe(s) {
  return s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')
}

let problems = 0
const fail = (msg) => {
  console.error(`✗ ${msg}`)
  problems++
}

// ---------- 1. 预览结构体双向一致 ----------
const referenced = new Set()
for (const f of readdirSync(PAGES)) {
  const src = readFileSync(join(PAGES, f), 'utf-8')
  const re = /([A-Za-z]+Preview)\(\{ toast: this\.toast \}\)/g
  let m
  while ((m = re.exec(src))) referenced.add(m[1])
}

const declared = new Set()
for (const f of readdirSync(PREVIEWS)) {
  const src = readFileSync(join(PREVIEWS, f), 'utf-8')
  for (const m of src.matchAll(/export struct ([A-Za-z]+Preview)/g)) declared.add(m[1])
}

for (const n of referenced) if (!declared.has(n)) fail(`生成页引用了不存在的预览结构体：${n}`)
for (const n of declared) if (!referenced.has(n)) fail(`孤儿预览结构体（未被任何生成页引用）：${n}`)

// ---------- 2. 未使用 import ----------
for (const f of walk(DOCSUI, [])) {
  const src = readFileSync(f, 'utf-8')
  const body = src.replace(/^import .*$/gm, '')
  for (const m of src.matchAll(/^import \{([^}]+)\} from/gm)) {
    m[1]
      .split(',')
      .map((s) => s.trim())
      .filter((s) => s !== '')
      .forEach((n) => {
        if (!new RegExp(`\\b${escapeRe(n)}\\b`).test(body)) {
          fail(`${f.replace(ROOT + '/', '')}：未使用的 import -> ${n}`)
        }
      })
  }
}

// ---------- 3. 页面结构体与注册表 / 分发层一致 ----------
const pageStructs = new Set()
for (const f of readdirSync(PAGES)) {
  if (f.endsWith('DocPage.ets')) {
    const src = readFileSync(join(PAGES, f), 'utf-8')
    for (const m of src.matchAll(/export struct ([A-Za-z]+)/g)) pageStructs.add(m[1])
  }
}
const registrySrc = readFileSync(resolve(DOCSUI, 'DocRegistry.ets'), 'utf-8')
const dispatchSrc = readFileSync(resolve(DOCSUI, 'DocPageDispatch.ets'), 'utf-8')
for (const s of pageStructs) {
  if (!registrySrc.includes(s)) fail(`页面结构体 ${s} 未在 DocRegistry.ets 登记`)
  if (!dispatchSrc.includes(s)) fail(`页面结构体 ${s} 未在 DocPageDispatch.ets 登记`)
}

console.log(`docsui 一致性校验：预览 ${referenced.size} 个、页面 ${pageStructs.size} 个`)
if (problems > 0) {
  console.error(`✗ ${problems} 处不一致，请跑 pnpm gen:docs 后重试`)
  process.exit(1)
}
console.log('✅ docsui 模块一致')
