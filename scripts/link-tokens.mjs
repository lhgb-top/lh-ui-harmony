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

import { cpSync, existsSync, readdirSync, rmSync, statSync } from 'node:fs'
import { resolve } from 'node:path'

const PLATFORM = 'harmony'
const REPO_ROOT = resolve(import.meta.dirname, '..')
const CORE_ROOT = resolve(REPO_ROOT, '..', 'lh-ui-core')

/** 令牌产物在本仓源码树中的落点（相对仓根）。harmony 产物是 tokens/*.ets */
const TOKEN_DEST = resolve(REPO_ROOT, 'tokens')

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

/** 清空落点目录（生成物全量覆盖，避免残留旧令牌） */
function cleanDest() {
  rmSync(TOKEN_DEST, { recursive: true, force: true })
}

/** 统计目录内文件数（递归） */
function countFiles(dir) {
  let count = 0
  for (const name of readdirSync(dir)) {
    const full = resolve(dir, name)
    if (statSync(full).isDirectory()) count += countFiles(full)
    else count += 1
  }
  return count
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
    const current = existsSync(TOKEN_DEST) ? countFiles(TOKEN_DEST) : 0
    const expected = countFiles(source)
    if (current !== expected) {
      console.error(`❌ 令牌未同步：落点 ${current} 个文件，来源 ${expected} 个（来源：${mode}）`)
      process.exitCode = 1
      return
    }
    console.log(`✅ 令牌已同步：${current} 个文件（来源：${mode}）`)
    return
  }

  cleanDest()
  cpSync(source, TOKEN_DEST, { recursive: true })
  console.log(`✅ ${PLATFORM} 令牌已同步：${countFiles(TOKEN_DEST)} 个文件 → ${TOKEN_DEST}（${mode}）`)
  if (isLocal) {
    console.log('   令牌改动后：cd ../lh-ui-core && pnpm codegen，再回本仓 pnpm link:tokens')
  }
}

main()
