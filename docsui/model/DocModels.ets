/**
 * 文档模块数据模型（`scripts/gen-doc-pages.mjs` 的产物形状，宿主与预览共用）。
 *
 * 与 android `:docsui` / ios `LhUIDocs` / windows `src/Docs` 的模型同构：
 * 一篇文档 = 标题 + 导语 + 契约行 + 若干章节；章节 = 标题 + 散文 + 预览 + 代码 + 表格。
 * 预览不由数据承载（ArkUI 无法把组件工厂放进数据里），而是由生成页用
 * `DocSectionView` 的尾随闭包把 `previews/` 里手写的 `{Comp}{Scene}Preview` 结构体挂上去。
 */

/** 文档分组；枚举值即侧边栏分组标签（单一真源，与 docs 站 config.ts 的分组一致）。 */
export enum DocGroup {
  Guide = '指南',
  Basic = '基础组件',
  Form = '表单组件',
  Feedback = '反馈组件',
  Navigation = '导航组件',
}

export interface DocRow {
  cells: string[]
}

export interface DocTable {
  /** 表格小标题（md 的 ### 子标题） */
  title: string
  headers: string[]
  rows: DocRow[]
}

export interface DocSection {
  title: string
  prose: string[]
  code: string[]
  tables: DocTable[]
}

export interface DocEntry {
  /** 条目 id（md 文件名），同时是宿主返回栈与 DocPageDispatch 的 key */
  id: string
  title: string
  group: DocGroup
  /** 首行 `#` 之后的导语散文 */
  lede: string[]
  /** 连续 `>` 开头的契约行 */
  contract: string[]
  sections: DocSection[]
}
