/**
 * 生成演示应用图标 entry/src/main/resources/base/media/app_icon.png（构建期工具，非运行时）。
 *
 * 解决的问题：app.json5 与 module.json5 都引用 `$media:app_icon`，但资源目录里从未
 * 存在该媒体文件——DevEco 构建期资源解析必失败。
 *
 * 图像内容：主色（靛蓝 #2B4C7C）底 + 白色菱形。菱形是本组件库图标体系的占位母题
 * （LhIconTokens.glyphFor 的未知名回退字形即 ◆），作为演示应用图标保持血脉一致。
 * 颜色直接读 ../lh-ui-core/tokens/color.json（令牌唯一源，不写色值字面量）。
 *
 * 用法：pnpm gen:icon
 */

import { mkdirSync, writeFileSync, existsSync, readFileSync } from 'node:fs'
import { deflateSync } from 'node:zlib'
import { resolve, dirname } from 'node:path'
import { fileURLToPath } from 'node:url'

const __dirname = dirname(fileURLToPath(import.meta.url))
const REPO_ROOT = resolve(__dirname, '..')
const CORE_ROOT = resolve(REPO_ROOT, '..', 'lh-ui-core')

/** 从 core 令牌源读品牌色（不引入色值字面量，红线 1 的工具侧体现） */
function brandColors() {
  const colorJsonPath = resolve(CORE_ROOT, 'tokens', 'color.json')
  if (!existsSync(colorJsonPath)) {
    throw new Error(`找不到令牌源 ${colorJsonPath}（家族布局下应有 ../lh-ui-core）`)
  }
  const colors = JSON.parse(readFileSync(colorJsonPath, 'utf8'))
  return {
    bg: colors.primary.default.value,
    fg: colors.onPrimary.value,
  }
}

/** #RRGGBB → [r, g, b] */
function hexToRgb(hex) {
  const h = hex.replace('#', '')
  return [parseInt(h.slice(0, 2), 16), parseInt(h.slice(2, 4), 16), parseInt(h.slice(4, 6), 16)]
}

/**
 * 生成 RGBA 像素缓冲（超采样后均值降采样，得到抗锯齿边缘）。
 * @param {number} size 输出边长（px）
 * @param {number} ss   超采样倍数
 */
function renderPixels(size, bg, fg) {
  const ss = 4
  const w = size * ss
  const mask = new Float32Array(w * w)
  const cx = w / 2
  const cy = w / 2
  const radius = w * 0.30 // 菱形「半径」占边长 30%
  // 菱形距离场：|dx| + |dy| < radius
  for (let y = 0; y < w; y++) {
    for (let x = 0; x < w; x++) {
      const d = Math.abs(x - cx + 0.5) + Math.abs(y - cy + 0.5)
      mask[y * w + x] = d < radius ? 1 : 0
    }
  }
  const out = Buffer.alloc(size * size * 4)
  for (let y = 0; y < size; y++) {
    for (let x = 0; x < size; x++) {
      let acc = 0
      for (let dy = 0; dy < ss; dy++) {
        for (let dx = 0; dx < ss; dx++) {
          acc += mask[(y * ss + dy) * w + (x * ss + dx)]
        }
      }
      const a = acc / (ss * ss)
      const i = (y * size + x) * 4
      out[i] = Math.round(bg[0] * (1 - a) + fg[0] * a)
      out[i + 1] = Math.round(bg[1] * (1 - a) + fg[1] * a)
      out[i + 2] = Math.round(bg[2] * (1 - a) + fg[2] * a)
      out[i + 3] = 255
    }
  }
  return out
}

/** 组装 PNG（RGBA8 + zlib 压缩） */
function encodePng(width, height, rgba) {
  const chunks = []
  const push = (type, data) => {
    const len = Buffer.alloc(4)
    len.writeUInt32BE(data.length, 0)
    const typeBuf = Buffer.from(type, 'ascii')
    const crc = crc32(Buffer.concat([typeBuf, data]))
    const crcBuf = Buffer.alloc(4)
    crcBuf.writeUInt32BE(crc >>> 0, 0)
    chunks.push(Buffer.concat([len, typeBuf, data, crcBuf]))
  }
  const ihdr = Buffer.alloc(13)
  ihdr.writeUInt32BE(width, 0)
  ihdr.writeUInt32BE(height, 4)
  ihdr[8] = 8 // bit depth
  ihdr[9] = 6 // color type RGBA
  ihdr[10] = 0 // compression
  ihdr[11] = 0 // filter
  ihdr[12] = 0 // interlace
  push('IHDR', ihdr)
  // 每条扫描线前置 filter 字节 0（None）
  const rows = []
  for (let y = 0; y < height; y++) {
    rows.push(Buffer.from([0]))
    rows.push(rgba.subarray(y * width * 4, (y + 1) * width * 4))
  }
  push('IDAT', deflateSync(Buffer.concat(rows), { level: 9 }))
  push('IEND', Buffer.alloc(0))
  return Buffer.concat([Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]), ...chunks])
}

const CRC_TABLE = (() => {
  const table = new Uint32Array(256)
  for (let n = 0; n < 256; n++) {
    let c = n
    for (let k = 0; k < 8; k++) {
      c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1
    }
    table[n] = c >>> 0
  }
  return table
})()

function crc32(buf) {
  let c = 0xffffffff
  for (let i = 0; i < buf.length; i++) {
    c = CRC_TABLE[(c ^ buf[i]) & 0xff] ^ (c >>> 8)
  }
  return c ^ 0xffffffff
}

function main() {
  const SIZE = 216 // DevEco 应用图标推荐尺寸
  const { bg, fg } = brandColors()
  const pixels = renderPixels(SIZE, hexToRgb(bg), hexToRgb(fg))
  const png = encodePng(SIZE, SIZE, pixels)
  const outPath = resolve(REPO_ROOT, 'entry', 'src', 'main', 'resources', 'base', 'media', 'app_icon.png')
  mkdirSync(dirname(outPath), { recursive: true })
  writeFileSync(outPath, png)
  console.log(`✅ 应用图标已生成：${outPath}（${SIZE}×${SIZE}，底色 ${bg} + onPrimary ${fg} 菱形）`)
}

main()
