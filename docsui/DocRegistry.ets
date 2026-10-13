// 本文件由 scripts/gen-doc-pages.mjs 生成 —— 禁手改（分组顺序对齐 docs 侧边栏）。

import { DocEntry, DocGroup } from './model/DocModels'
import { introductionEntry } from './pages/GuideIntroductionDocPage'
import { installationEntry } from './pages/GuideInstallationDocPage'
import { quickstartEntry } from './pages/GuideQuickstartDocPage'
import { themingEntry } from './pages/GuideThemingDocPage'
import { localLinkingEntry } from './pages/GuideLocalLinkingDocPage'
import { buttonEntry } from './pages/ButtonDocPage'
import { iconEntry } from './pages/IconDocPage'
import { tagEntry } from './pages/TagDocPage'
import { cellEntry } from './pages/CellDocPage'
import { textEntry } from './pages/TextDocPage'
import { inputEntry } from './pages/InputDocPage'
import { textareaEntry } from './pages/TextareaDocPage'
import { checkboxEntry } from './pages/CheckboxDocPage'
import { radioEntry } from './pages/RadioDocPage'
import { switchEntry } from './pages/SwitchDocPage'
import { pickerEntry } from './pages/PickerDocPage'
import { dialogEntry } from './pages/DialogDocPage'
import { toastEntry } from './pages/ToastDocPage'
import { loadingEntry } from './pages/LoadingDocPage'
import { navbarEntry } from './pages/NavbarDocPage'

/**
 * 文档注册表：数据驱动的页面清单。顺序与 docs/.vitepress/config.ts 的侧边栏一致。
 * 宿主（docsui/LhDocsPage.ets）的分组首页与返回栈都走它。
 */
export class DocRegistry {
  /** 全部条目（侧边栏顺序：指南在前，其后基础 / 表单 / 反馈 / 导航） */
  static readonly all: DocEntry[] = [
    introductionEntry,
    installationEntry,
    quickstartEntry,
    themingEntry,
    localLinkingEntry,
    buttonEntry,
    iconEntry,
    tagEntry,
    cellEntry,
    textEntry,
    inputEntry,
    textareaEntry,
    checkboxEntry,
    radioEntry,
    switchEntry,
    pickerEntry,
    dialogEntry,
    toastEntry,
    loadingEntry,
    navbarEntry,
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
