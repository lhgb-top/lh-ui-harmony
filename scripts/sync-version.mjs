/**
 * 把 package.json 的 version 单向同步到鸿蒙包描述的版本真源，幂等。
 *
 * 家族约定：changeset version 只 bump package.json，平台版本真源由本脚本
 * 跟随同步。harmony 端的真源是仓根 oh-package.json5 的 version
 * （ohpm 发布与 HAR 包版本读它，见 docs/发包流程.md §5.5）。
 *
 * 由 `pnpm changeset:version` 自动调用（见 package.json），也可单独执行：
 *   node scripts/sync-version.mjs          同步
 *   node scripts/sync-version.mjs --check  只校验一致性，不同步（CI 门禁用）
 *
 * 注意：令牌目录 tokens/ 是 codegen 生成物，本脚本不触碰它；
 * entry/oh-package.json5 是演示应用（version 固定 1.0.0，不发布），也不同步。
 */
import fs from 'node:fs'
import path from 'node:path'
import { fileURLToPath } from 'node:url'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const root = path.resolve(__dirname, '..')
const pkgPath = path.resolve(root, 'package.json')
const ohPkgPath = path.resolve(root, 'oh-package.json5')

const checkOnly = process.argv.includes('--check')

const pkg = JSON.parse(fs.readFileSync(pkgPath, 'utf8'))
const { version } = pkg

if (!version) {
  console.error('package.json 缺少 version 字段')
  process.exit(1)
}

if (!fs.existsSync(ohPkgPath)) {
  console.error(`未找到 ${ohPkgPath}`)
  process.exit(1)
}

const content = fs.readFileSync(ohPkgPath, 'utf8')

// oh-package.json5 是 JSON5，但 version 一行只可能写作 "version": "x.y.z"，
// 用正则替换该行，避免引入 JSON5 解析依赖
const versionLineRe = /^(\s*"version"\s*:\s*")([^"]*)("\s*,?\s*)$/m

const match = content.match(versionLineRe)
if (!match) {
  console.error(`${ohPkgPath} 中未找到 "version" 字段，请先手工补上初值`)
  process.exit(1)
}

const current = match[2].trim()

if (current === version) {
  console.log(`✅ 版本一致：${version}（oh-package.json5）`)
  process.exit(0)
}

if (checkOnly) {
  console.error(
    `❌ 版本不一致：package.json=${version}，oh-package.json5=${current}`,
  )
  process.exit(1)
}

const updated = content.replace(versionLineRe, (_m, prefix, _old, suffix) => {
  return `${prefix}${version}${suffix}`
})
fs.writeFileSync(ohPkgPath, updated, 'utf8')

console.log(`✅ 已同步版本 ${current} → ${version}（oh-package.json5）`)
