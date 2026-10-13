/**
 * 尺寸令牌（vp 数值）→ ArkUI 长度。
 *
 * ArkUI 里数值即 vp（vp() 恒等换算），本函数只做类型收窄：把生成的
 * `Dimension | number` 令牌值收为 `number`（Length 的合法成员），并在调用点
 * 标明「这里消费的是令牌数值」。组件实现禁止出现尺寸字面量（AGENTS.md 红线 1）。
 */
export function lhVp(n: number): number {
  return n
}
