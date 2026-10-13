// gen-doc-pages.mjs —— md → 原生文档页（ArkTS / ArkUI）
//
// 数据驱动：新增/改文档只重跑本脚本（pnpm gen:docs）。生成的 pages/*.ets 与
// DocRegistry.ets / DocPageDispatch.ets 禁手改（漂移由脚本兜底）；真交互预览手写
// 在 docsui/previews/，本脚本按 section 标题经 SCENE_MAP 映射引用，命名固定为
// {Comp}{Scene}Preview（普通属性 toast: LhToastController 接收宿主反馈通道）。
//
// 输入：docs/components/{slug}.md + docs/guide/{slug}.md + docs/.vitepress/config.ts（分组顺序真源）
// 输出：docsui/pages/{Pascal}DocPage.ets（组件）/ Guide{Pascal}DocPage.ets（指南）
//       + docsui/DocRegistry.ets（注册表）+ docsui/DocPageDispatch.ets（id → 页面结构体分发）
//
// md 解析约定（与 lh-ui-android / lh-ui-ios / lh-ui-windows 的同名脚本对齐）：
//   首行 `# ` 为 title；其后散文为 lede；连续 `> ` 合并为 contract
//   `## ` 分节，`### ` 为 API 子标题（表的标题沿用子标题名）
//   `|` 表格逐行解析，含 `:-:` 的分割行跳过
//   ```bash 代码块进 commands，其余代码块进当前 section 的 code
//   `<div>` / `<p>` / `<details>` / `::: tip` 容器整块跳过（网页模拟器 HTML 不进原生）
//   散文与表格单元里的反引号在生成期剥离（ArkUI 端 DocProse 只做单一样式渲染）

import { readFileSync, writeFileSync, existsSync, mkdirSync } from 'node:fs'
import { resolve, dirname } from 'node:path'
import { fileURLToPath } from 'node:url'

const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), '..')
const DOCS = resolve(ROOT, 'docs')
const OUT_DIR = resolve(ROOT, 'docsui/pages')
const OUT_REGISTRY = resolve(ROOT, 'docsui/DocRegistry.ets')
const OUT_DISPATCH = resolve(ROOT, 'docsui/DocPageDispatch.ets')

// section 标题 → 预览结构体后缀（手写预览须命名 {Comp}{Scene}Preview）
const SCENE_MAP = {
  // Button
  类型: 'Types',
  尺寸: 'Sizes',
  状态: 'States',
  图标与花纹底: 'IconAndPattern',
  明暗主题: 'Theme',
  // Icon / Loading / Text
  色调: 'Tone',
  图标名: 'IconNames',
  字号级别: 'Levels',
  字重: 'Weight',
  对齐与行高: 'AlignAndLineHeight',
  // Tag
  描边与圆角: 'PlainAndRound',
  尺寸与关闭: 'SizesAndClosable',
  // Cell
  基本用法: 'Basic',
  '图标 / 必填 / 可点击': 'IconRequiredAndClickable',
  // Checkbox
  半选与禁用: 'IndeterminateAndDisabled',
  // Input / Textarea
  聚焦与尺寸: 'FocusAndSizes',
  状态与清除: 'StatesAndClearable',
  字数统计: 'Count',
  // Dialog
  // Toast
  类型与位置: 'TypesAndPosition',
  // Navbar
  纯图标与无分隔线: 'IconAndBorderless',
}

const TERMINAL_SECTIONS = ['API', '令牌对照', '黄金用例对照']

const GROUP_TO_ENUM = {
  基础组件: 'Basic',
  表单组件: 'Form',
  反馈组件: 'Feedback',
  导航组件: 'Navigation',
}

function pascal(slug) {
  return slug.split(/[-_]/).map((s) => s.charAt(0).toUpperCase() + s.slice(1)).join('')
}

function camel(slug) {
  const p = pascal(slug)
  return p.charAt(0).toLowerCase() + p.slice(1)
}

// 散文 / 表格单元：剥离 md 行内标记（反引号与 ** 加粗），ArkUI 端 DocProse 只做单一样式渲染
function stripBackticks(s) {
  return s.replace(/`/g, '').replace(/\*\*/g, '')
}

// 转义进 ArkTS 字符串字面量：反斜杠与双引号
function esc(s) {
  return s.replace(/\\/g, '\\\\').replace(/"/g, '\\"')
}

function stringArray(lines, indent) {
  if (lines.length === 0) return '[]'
  return `[\n${lines.map((l) => `${indent}"${esc(stripBackticks(l))}"`).join(',\n')},\n${indent.slice(0, -2)}]`
}

// ---------- config.ts 分组顺序解析（侧边栏顺序即首页顺序）----------
function sliceArrayLiteral(src, startKeyword) {
  const kw = src.indexOf(startKeyword)
  const br = src.indexOf('[', kw)
  let depth = 0
  for (let i = br; i < src.length; i++) {
    if (src[i] === '[') depth++
    else if (src[i] === ']') {
      depth--
      if (depth === 0) return src.slice(br, i + 1)
    }
  }
  return src.slice(br)
}

function parseConfig() {
  const src = readFileSync(resolve(DOCS, '.vitepress/config.ts'), 'utf-8')
  const out = { guides: [], components: [] }

  const guideSeg = sliceArrayLiteral(src, 'const guideGroups =')
  const compSeg = sliceArrayLiteral(src, 'const componentGroups =')

  const pairRe = /text:\s*'([^']+)'[^}]*?slug:\s*'([^']+)'/g
  let m
  while ((m = pairRe.exec(guideSeg))) out.guides.push({ text: m[1], slug: m[2] })

  const groupRe = /text:\s*'([^']+)'\s*,\s*items:\s*\[([\s\S]*?)\]/g
  while ((m = groupRe.exec(compSeg))) {
    const items = []
    const itemRe = /text:\s*'([^']+)'[^}]*?slug:\s*'([^']+)'/g
    let im
    while ((im = itemRe.exec(m[2]))) items.push({ text: im[1], slug: im[2] })
    out.components.push({ group: m[1], items })
  }
  return out
}

// ---------- md 解析 ----------
function parseTable(lines) {
  const rows = lines
    .filter((l) => l.trim().startsWith('|'))
    .filter((l) => !/^\|[\s:|-]+\|$/.test(l.trim()))
    .map((l) =>
      l
        .trim()
        .replace(/^\|/, '')
        .replace(/\|$/, '')
        .split('|')
        .map((c) => c.trim()),
    )
  if (rows.length === 0) return null
  return { headers: rows[0], rows: rows.slice(1) }
}

function parseMd(path, isGuide) {
  const raw = readFileSync(path, 'utf-8').replace(/^\uFEFF/, '')
  const lines = raw.split(/\r?\n/)
  const entry = { title: '', lede: [], contract: [], sections: [] }

  let i = 0
  while (i < lines.length && !lines[i].startsWith('# ')) i++
  entry.title = lines[i].slice(2).trim()
  i++

  // lede 与 contract（到首个 ## 之前）
  while (i < lines.length && !lines[i].startsWith('## ')) {
    const l = lines[i].trim()
    if (l.startsWith('>')) {
      entry.contract.push(l.replace(/^>\s?/, '').trim())
    } else if (l !== '') {
      entry.lede.push(l)
    }
    i++
  }

  let section = null
  let inDiv = 0
  let inFence = false
  let fenceLines = []
  let tableLines = []
  let apiSubTitle = null

  const flushTable = () => {
    if (tableLines.length === 0) return
    const t = parseTable(tableLines)
    tableLines = []
    if (t && section) {
      // API 节内：### 属性 的表为 Props，其余 ### 的表为枚举表（标题沿用子标题名）
      const title = section.terminal === 'API' && apiSubTitle && apiSubTitle !== '属性' ? apiSubTitle : ''
      section.tables.push({ title, ...t })
    }
  }

  while (i < lines.length) {
    const line = lines[i]

    if (inFence) {
      if (line.trim() === '```') {
        inFence = false
        if (section) section.code.push(...fenceLines)
        fenceLines = []
      } else {
        fenceLines.push(line)
      }
      i++
      continue
    }

    if (inDiv > 0) {
      inDiv += (line.match(/<div/g) || []).length - (line.match(/<\/div>/g) || []).length
      i++
      continue
    }

    const trimmed = line.trim()

    if (trimmed.startsWith('```')) {
      inFence = true
      fenceLines = []
      i++
      continue
    }
    if (trimmed.startsWith('<div')) {
      inDiv = (line.match(/<div/g) || []).length - (line.match(/<\/div>/g) || []).length
      i++
      continue
    }
    if (trimmed.startsWith('<p') || trimmed.startsWith('<details')) {
      i++
      continue
    }
    // vitepress 容器（::: tip / ::: warning …）：只剥掉标记行，正文当散文保留
    if (trimmed.startsWith(':::')) {
      i++
      continue
    }

    if (line.startsWith('## ')) {
      flushTable()
      const title = line.slice(3).trim()
      section = {
        title,
        prose: [],
        code: [],
        tables: [],
        preview: null,
        terminal: TERMINAL_SECTIONS.includes(title) ? title : null,
      }
      apiSubTitle = null
      entry.sections.push(section)
      i++
      continue
    }

    if (line.startsWith('### ')) {
      flushTable()
      apiSubTitle = line.slice(4).trim()
      i++
      continue
    }

    if (trimmed.startsWith('|')) {
      tableLines.push(line)
      i++
      continue
    }
    flushTable()

    if (trimmed === '') {
      i++
      continue
    }
    if (section) section.prose.push(trimmed)
    i++
  }
  flushTable()

  // 预览映射：组件页按 SCENE_MAP；指南页不要预览
  if (!isGuide) {
    for (const s of entry.sections) {
      if (s.terminal) continue
      const name = SCENE_MAP[s.title]
      if (!name) {
        console.warn(`⚠ 未登记场景标题：${path} 的「${s.title}」（该节不生成预览）`)
        continue
      }
      s.preview = name
    }
  }
  return entry
}

// ---------- ArkTS 代码生成 ----------
function emitTable(t, baseIndent) {
  const cells = (arr) => arr.map((c) => `"${esc(stripBackticks(c))}"`).join(', ')
  const rows = t.rows
    .map((r) => `${baseIndent}        { cells: [${cells(r.length ? r : [''])} ] },`)
    .join('\n')
  return `${baseIndent}      {
${baseIndent}        title: "${esc(stripBackticks(t.title))}",
${baseIndent}        headers: [${cells(t.headers)}],
${baseIndent}        rows: [
${rows}
${baseIndent}        ],
${baseIndent}      }`
}

function emitEntry(entry, constName, group) {
  const sections = entry.sections.map((s) => {
    const prose = stringArray(s.prose, '        ')
    const code = stringArray(s.code, '        ')
    const tables =
      s.tables.length > 0
        ? `[\n${s.tables.map((t) => emitTable(t, '        ')).join(',\n')}\n      ]`
        : '[]'
    return `    {
      title: "${esc(s.title)}",
      prose: ${prose},
      code: ${code},
      tables: ${tables},
    },`
  })

  return `    {
      id: "${esc(entry.id)}",
      title: "${esc(entry.title)}",
      group: DocGroup.${group},
      lede: ${stringArray(entry.lede, '      ')},
      contract: ${stringArray(entry.contract, '      ')},
      sections: [
${sections.join('\n')}
      ],
    }`
}

function emitPage(entry, constName, structName, group, previewModule, previewNames) {
  const previewImports = previewNames.length > 0
    ? `import { ${previewNames.join(', ')} } from '../previews/${previewModule}'\n`
    : ''
  const sectionViews = entry.sections.map((s, index) => {
    if (s.preview) {
      const struct = `${pascal(entry.id)}${s.preview}Preview`
      return `      DocSectionView({ section: ${constName}.sections[${index}] }) {
        ${struct}({ toast: this.toast })
      }`
    }
    return `      DocSectionView({ section: ${constName}.sections[${index}] }) {
        // 「${esc(s.title)}」为终止节或未登记预览，本节无真交互预览
      }`
  })

  return `// 本文件由 scripts/gen-doc-pages.mjs 从 ${entry.source} 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 docsui/previews/${previewModule}.ets。

import { LhToastController } from '../../components/toast/Index'
import { DocScroll, DocSectionView } from '../widgets/DocWidgets'
import { DocEntry, DocGroup } from '../model/DocModels'
${previewImports}
const ${constName}: DocEntry =
${emitEntry(entry, constName, group)}

/**
 * ${entry.title}（生成物，勿手改）。
 * sections 由 DocSectionView 渲染；预览节通过尾随闭包挂接 previews/ 里的真交互结构体。
 */
@Component
export struct ${structName} {
  toast: LhToastController = new LhToastController()

  build() {
    DocScroll({ entry: ${constName} }) {
${sectionViews.join('\n')}
    }
  }
}
`
}

function emitRegistry(registrations) {
  const imports = registrations
    .map((r) => `import { ${r.constName} } from './pages/${r.structName}'`)
    .join('\n')
  const list = registrations.map((r) => `    ${r.constName},`).join('\n')
  return `// 本文件由 scripts/gen-doc-pages.mjs 生成 —— 禁手改（分组顺序对齐 docs 侧边栏）。

import { DocEntry, DocGroup } from './model/DocModels'
${imports}

/**
 * 文档注册表：数据驱动的页面清单。顺序与 docs/.vitepress/config.ts 的侧边栏一致。
 * 宿主（docsui/LhDocsPage.ets）的分组首页与返回栈都走它。
 */
export class DocRegistry {
  /** 全部条目（侧边栏顺序：指南在前，其后基础 / 表单 / 反馈 / 导航） */
  static readonly all: DocEntry[] = [
${list}
  ]

  /** 分组顺序（首页分组列表的真源） */
  static groups(): DocGroup[] {
    return [DocGroup.Guide, DocGroup.Basic, DocGroup.Form, DocGroup.Feedback, DocGroup.Navigation]
  }

  /** 按 id 取条目；宿主的返回栈与标题都走它 */
  static byId(id: string): DocEntry | undefined {
    return DocRegistry.all.find((entry: DocEntry) => entry.id === id)
  }

  /** 取某分组的条目（保持 all 内顺序） */
  static entriesInGroup(group: DocGroup): DocEntry[] {
    return DocRegistry.all.filter((entry: DocEntry) => entry.group === group)
  }
}
`
}

function emitDispatch(registrations) {
  if (registrations.length === 0) {
    throw new Error('无文档条目可分发，请检查 docs/.vitepress/config.ts')
  }
  const imports = registrations
    .map((r) => `import { ${r.structName} } from './${r.structName}'`)
    .join('\n')
  const first = registrations[0]
  const rest = registrations
    .slice(1)
    .map((r) => `    } else if (this.entryId === '${r.id}') {\n      ${r.structName}({ toast: this.toast })`)
    .join('\n')
  return `// 本文件由 scripts/gen-doc-pages.mjs 生成 —— 禁手改。
// id → 页面结构体的分发层：宿主按当前栈顶 id 渲染对应文档页，toast 通道逐页透传。

import { LhToastController } from '../components/toast/Index'
import { DocProse } from '../widgets/DocWidgets'
${imports}

@Component
export struct DocPageDispatch {
  entryId: string = ''
  toast: LhToastController = new LhToastController()

  build() {
    if (this.entryId === '${first.id}') {
      ${first.structName}({ toast: this.toast })
${rest}
    } else {
      DocProse({ text: '未知文档页：' + this.entryId, secondary: true })
    }
  }
}
`
}

// ---------- 主流程 ----------
function main() {
  const cfg = parseConfig()
  if (!existsSync(OUT_DIR)) mkdirSync(OUT_DIR, { recursive: true })

  const registrations = []
  let warnings = 0

  // 指南页
  for (const g of cfg.guides) {
    const mdPath = resolve(DOCS, 'guide', `${g.slug}.md`)
    if (!existsSync(mdPath)) {
      console.warn(`⚠ 缺少指南 md：${mdPath}`)
      warnings++
      continue
    }
    const entry = parseMd(mdPath, true)
    entry.id = g.slug
    entry.source = `docs/guide/${g.slug}.md`
    const constName = `${camel(g.slug)}Entry`
    const structName = `Guide${pascal(g.slug)}DocPage`
    writeFileSync(
      resolve(OUT_DIR, `${structName}.ets`),
      emitPage(entry, constName, structName, 'Guide', `Guide${pascal(g.slug)}Previews`, []),
    )
    registrations.push({ id: entry.id, constName, structName })
  }

  // 组件页
  for (const grp of cfg.components) {
    const group = GROUP_TO_ENUM[grp.group]
    if (!group) {
      console.warn(`⚠ 未知分组「${grp.group}」，请在 GROUP_TO_ENUM 登记`)
      warnings++
    }
    for (const item of grp.items) {
      const mdPath = resolve(DOCS, 'components', `${item.slug}.md`)
      if (!existsSync(mdPath)) {
        console.warn(`⚠ 缺少组件 md：${mdPath}`)
        warnings++
        continue
      }
      const entry = parseMd(mdPath, false)
      entry.id = item.slug
      entry.source = `docs/components/${item.slug}.md`
      const constName = `${camel(item.slug)}Entry`
      const structName = `${pascal(item.slug)}DocPage`
      const previewModule = `${pascal(item.slug)}Previews`
      const previewNames = entry.sections
        .filter((s) => s.preview)
        .map((s) => `${pascal(item.slug)}${s.preview}Preview`)
      writeFileSync(
        resolve(OUT_DIR, `${structName}.ets`),
        emitPage(entry, constName, structName, group, previewModule, previewNames),
      )
      registrations.push({ id: entry.id, constName, structName })
    }
  }

  writeFileSync(OUT_REGISTRY, emitRegistry(registrations))
  writeFileSync(OUT_DISPATCH, emitDispatch(registrations))
  console.log(`✅ 生成 ${registrations.length} 个条目`)
  console.log(`   页面目录：${OUT_DIR}`)
  console.log(`   注册表：${OUT_REGISTRY}`)
  console.log(`   分发层：${OUT_DISPATCH}`)
  if (warnings > 0) console.log(`⚠ ${warnings} 处告警，请检查上方输出`)
}

main()
