// 本文件由 scripts/gen-doc-pages.mjs 生成 —— 禁手改。
// id → 页面结构体的分发层：宿主按当前栈顶 id 渲染对应文档页，toast 通道逐页透传。

import { LhToastController } from '../components/toast/Index'
import { DocProse } from '../widgets/DocWidgets'
import { GuideIntroductionDocPage } from './GuideIntroductionDocPage'
import { GuideInstallationDocPage } from './GuideInstallationDocPage'
import { GuideQuickstartDocPage } from './GuideQuickstartDocPage'
import { GuideThemingDocPage } from './GuideThemingDocPage'
import { GuideLocalLinkingDocPage } from './GuideLocalLinkingDocPage'
import { ButtonDocPage } from './ButtonDocPage'
import { IconDocPage } from './IconDocPage'
import { TagDocPage } from './TagDocPage'
import { CellDocPage } from './CellDocPage'
import { TextDocPage } from './TextDocPage'
import { InputDocPage } from './InputDocPage'
import { TextareaDocPage } from './TextareaDocPage'
import { CheckboxDocPage } from './CheckboxDocPage'
import { RadioDocPage } from './RadioDocPage'
import { SwitchDocPage } from './SwitchDocPage'
import { PickerDocPage } from './PickerDocPage'
import { DialogDocPage } from './DialogDocPage'
import { ToastDocPage } from './ToastDocPage'
import { LoadingDocPage } from './LoadingDocPage'
import { NavbarDocPage } from './NavbarDocPage'

@Component
export struct DocPageDispatch {
  entryId: string = ''
  toast: LhToastController = new LhToastController()

  build() {
    if (this.entryId === 'introduction') {
      GuideIntroductionDocPage({ toast: this.toast })
    } else if (this.entryId === 'installation') {
      GuideInstallationDocPage({ toast: this.toast })
    } else if (this.entryId === 'quickstart') {
      GuideQuickstartDocPage({ toast: this.toast })
    } else if (this.entryId === 'theming') {
      GuideThemingDocPage({ toast: this.toast })
    } else if (this.entryId === 'local-linking') {
      GuideLocalLinkingDocPage({ toast: this.toast })
    } else if (this.entryId === 'button') {
      ButtonDocPage({ toast: this.toast })
    } else if (this.entryId === 'icon') {
      IconDocPage({ toast: this.toast })
    } else if (this.entryId === 'tag') {
      TagDocPage({ toast: this.toast })
    } else if (this.entryId === 'cell') {
      CellDocPage({ toast: this.toast })
    } else if (this.entryId === 'text') {
      TextDocPage({ toast: this.toast })
    } else if (this.entryId === 'input') {
      InputDocPage({ toast: this.toast })
    } else if (this.entryId === 'textarea') {
      TextareaDocPage({ toast: this.toast })
    } else if (this.entryId === 'checkbox') {
      CheckboxDocPage({ toast: this.toast })
    } else if (this.entryId === 'radio') {
      RadioDocPage({ toast: this.toast })
    } else if (this.entryId === 'switch') {
      SwitchDocPage({ toast: this.toast })
    } else if (this.entryId === 'picker') {
      PickerDocPage({ toast: this.toast })
    } else if (this.entryId === 'dialog') {
      DialogDocPage({ toast: this.toast })
    } else if (this.entryId === 'toast') {
      ToastDocPage({ toast: this.toast })
    } else if (this.entryId === 'loading') {
      LoadingDocPage({ toast: this.toast })
    } else if (this.entryId === 'navbar') {
      NavbarDocPage({ toast: this.toast })
    } else {
      DocProse({ text: '未知文档页：' + this.entryId, secondary: true })
    }
  }
}
