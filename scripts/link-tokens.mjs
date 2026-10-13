/**
 * 令牌本地连接（家族统一机制，总纲 D18）。
 *
 * 三级存在性守卫，优先级从高到低：
 *   1. 同级 ../lh-ui-core/dist/<platform>  —— 家族布局下直连 codegen 产物（改令牌后
 *      `cd lh-ui-core && pnpm codegen` 再跑本脚本即生效，无需发包）
 *   2. node_modules/@lh-ui/core/dist/<platform> —— npm 已发包产物（CI 单仓 clone 回退）
 *   3. 都不存在 —— 报错退出（令牌是本仓唯一令牌源，缺它无法构建）
 *
 * 目标目录是生成物（.gitignore），禁止手改；唯一真源是 lh-ui-core/tokens/*.json。
 * 与 web 血脉的 vite alias 守卫机制同构（用户定调：本地调试都采用本地连接仓库）。
 *
 * 用法：
 *   pnpm link:tokens          # 同步令牌到本仓源码树
 *   pnpm link:tokens --check  # 仅探测，不写入（CI 校验令牌是否已同步）
 */

import { cpSync, existsSync, readFileSync, readdirSync, rmSync, statSync } from 'node:fs'
import { resolve, relative } from 'node:path'

const PLATFORM = 'harmony'
const REPO_ROOT = resolve(import.meta.dirname, '..')
const CORE_ROOT = resolve(REPO_ROOT, '..', 'lh-ui-core')

/**
 * 令牌产物在本仓源码树中的落点。harmony codegen 的 relativePath 是 tokens/*.ets
 * （与 android 的 top/lhgb/ui/tokens/*.kt 同构：落点是「源根」而非叶子目录），
 * 因此把 dist/harmony 整树拷入仓根，得到 <仓根>/tokens/*.ets；
 * 组件侧的 import 路径 ../../tokens/LhTokens 即指向此处。
 */
const TOKEN_DEST = REPO_ROOT
/** 生成物在源根下的子目录（清理与同步校验只作用于它，绝不整体删除源根） */
const TOKEN_SUBDIR = 'tokens'

/**
 * 解析令牌产物来源。
 * @returns 来源绝对路径；都不存在返回 null
 */
function resolveTokenSource() {
  // 1. 本地直连：家族布局下同级的 lh-ui-core/dist
  const localDist = resolve(CORE_ROOT, 'dist', PLATFORM)
  if (existsSync(localDist)) return localDist
  // 2. npm 回退：已发包 @lh-ui/core 的 dist（files 字段含四端产物）
  const npmDist = resolve(REPO_ROOT, 'node_modules', '@lh-ui', 'core', 'dist', PLATFORM)
  if (existsSync(npmDist)) return npmDist
  return null
}

/** 清空生成物子目录（生成物全量覆盖，避免残留旧令牌；只删 tokens/，不动源根其他内容） */
function cleanDest() {
  rmSync(resolve(TOKEN_DEST, TOKEN_SUBDIR), { recursive: true, force: true })
}

/** 收集目录内全部文件的相对路径（相对该目录，POSIX 分隔符），用于集合比对 */
function listFiles(dir, base = dir) {
  const out = []
  for (const name of readdirSync(dir)) {
    const full = resolve(dir, name)
    if (statSync(full).isDirectory()) out.push(...listFiles(full, base))
    else out.push(relative(base, full).split('\\').join('/'))
  }
  return out
}

/**
 * 校验落点与来源是否逐文件一致（名称集合 + 字节内容）。
 *
 * 早期版本只比文件数：内容过期（甚至改名的令牌）都能蒙混过关，曾在
 * checkbox.dashScale 缺失时给出假绿灯。名称集合比对拦「改名/新增/删除」，
 * 逐文件字节比对拦「内容漂移」。
 *
 * 比对基准与 cpSync(source, TOKEN_DEST) 的整树拷贝语义一致：来源相对路径即
 * 落点相对路径，落点侧只看 TOKEN_SUBDIR 下的文件（仓根其余内容不是生成物）。
 *
 * @returns 缺失 / 多余 / 改动 三个清单
 */
function diffTokens(source, destRoot) {
  const srcNames = listFiles(source)
  const destNames = existsSync(resolve(destRoot, TOKEN_SUBDIR))
    ? listFiles(destRoot).filter(n => n.startsWith(`${TOKEN_SUBDIR}/`))
    : []
  const srcSet = new Set(srcNames)
  const destSet = new Set(destNames)
  const missing = srcNames.filter(n => !destSet.has(n))
  const extra = destNames.filter(n => !srcSet.has(n))
  const modified = srcNames.filter(n => {
    if (!destSet.has(n)) return false
    const a = readFileSync(resolve(source, n))
    const b = readFileSync(resolve(destRoot, n))
    return Buffer.compare(a, b) !== 0
  })
  return { missing, extra, modified }
}

function main() {
  const checkOnly = process.argv.slice(2).includes('--check')
  const source = resolveTokenSource()

  if (!source) {
    console.error(
      `❌ 未找到 ${PLATFORM} 令牌产物：既无本地 ${resolve(CORE_ROOT, 'dist', PLATFORM)}，` +
        `也无 node_modules/@lh-ui/core/dist/${PLATFORM}。\n` +
        '请先在家族布局下 `cd ../lh-ui-core && pnpm codegen`，或安装 @lh-ui/core。',
    )
    process.exitCode = 1
    return
  }

  const isLocal = source === resolve(CORE_ROOT, 'dist', PLATFORM)
  const mode = isLocal ? '本地直连（../lh-ui-core/dist）' : 'npm 产物回退（@lh-ui/core）'

  if (checkOnly) {
    const { missing, extra, modified } = diffTokens(source, TOKEN_DEST)
    if (missing.length || extra.length || modified.length) {
      console.error(`❌ 令牌未同步（来源：${mode}）`)
      if (missing.length) console.error(`   缺失 ${missing.length} 个：${missing.join(', ')}`)
      if (extra.length) console.error(`   多余 ${extra.length} 个：${extra.join(', ')}`)
      if (modified.length) console.error(`   改动 ${modified.length} 个：${modified.join(', ')}`)
      console.error('   请执行 `pnpm link:tokens` 重新同步（令牌真源在 lh-ui-core/tokens/*.json）')
      process.exitCode = 1
      return
    }
    console.log(`✅ 令牌已同步：${listFiles(resolve(TOKEN_DEST, TOKEN_SUBDIR)).length} 个文件逐文件一致（来源：${mode}）`)
    return
  }

  cleanDest()
  cpSync(source, TOKEN_DEST, { recursive: true })
  console.log(`✅ ${PLATFORM} 令牌已同步：${listFiles(resolve(TOKEN_DEST, TOKEN_SUBDIR)).length} 个文件 → ${resolve(TOKEN_DEST, TOKEN_SUBDIR)}（${mode}）`)
  if (isLocal) {
    console.log('   令牌改动后：cd ../lh-ui-core && pnpm codegen，再回本仓 pnpm link:tokens')
  }
}

main()
