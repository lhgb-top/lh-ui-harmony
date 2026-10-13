/**
 * Cell 文档页的真交互预览（对应 `docs/components/cell.md` 的 `##` 分节）。
 */
import { LhCell } from '../../components/cell/Index'
import { LhToastController } from '../../components/toast/Index'
import { DocPreviewFrame } from '../widgets/DocWidgets'

/** 基本用法：标题 / 值 / 说明三段式。 */
@Component
export struct CellBasicPreview {
  toast: LhToastController = new LhToastController()

  build() {
    DocPreviewFrame({ title: '标题、值与说明文字（bordered 控制下分隔线）' }) {
      Column() {
        LhCell({ title: '单行标题' })
        LhCell({ title: '标题', value: '右侧值' })
        LhCell({ title: '标题', value: '右侧值', label: '说明文字（label）' })
        LhCell({ title: '无边框', value: 'bordered = false', bordered: false })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}

/** 图标 / 必填 / 可点击：clickable 为 false 时不触发 onClick。 */
@Component
export struct CellIconRequiredAndClickablePreview {
  toast: LhToastController = new LhToastController()

  build() {
    DocPreviewFrame({ title: '图标（icon）/ 必填星号（required）/ 可点击（clickable）' }) {
      Column() {
        LhCell({ title: '带图标', value: 'icon = search', icon: 'search' })
        LhCell({ title: '必填项', value: 'required = true', required: true })
        LhCell({
          title: '可点击',
          value: 'clickable = true',
          clickable: true,
          onClick: () => this.toast.show('onClick：可点击单元格'),
        })
        LhCell({ title: '不可点击', value: 'clickable = false' })
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}
