/**
 * 演示应用首页（等价 dev 沙箱）：15 个 P0 组件的全形态演示。
 *
 * 消费方式：从 ohpm 包名 `top.lhgb.ui.harmony` 聚合导入（entry 模块以 file:../ 依赖仓根库，
 * 不再有跨模块边界的相对路径引用）。明暗切换：右上角 LhNavbar 的右侧文字；LhTheme.apply
 * 写入 AppStorage 后，所有 Lh 组件的 @StorageProp 变化 → @Watch → 重算外观，整页热重绘。
 * 浮层（dialog / picker / toast）作为外层 Stack 的最后子节点挂载，靠 zIndex 分层。
 */
import {
  LhButton, LhButtonType, LhButtonSize,
  LhIcon, LhIconSize, LhIconTone,
  LhTag, LhTagType, LhTagSize,
  LhCell,
  LhText, LhTextLevel, LhTextWeight, LhTextTone, LhTextAlign,
  LhInput, LhInputType, LhInputSize,
  LhTextarea,
  LhCheckbox, LhCheckboxSize,
  LhRadio, LhRadioSize,
  LhSwitch, LhSwitchSize,
  LhLoading, LhLoadingSize, LhLoadingTone,
  LhDialog, LhDialogType,
  LhToast, LhToastType, LhToastPosition, LhToastController,
  LhPicker,
  LhNavbar,
  LhTheme, LhColors, LightLhColors, LH_COLORS_KEY,
  LhTokens,
} from 'top.lhgb.ui.harmony'

@Entry
@Component
struct LhDemoIndex {
  @State isDark: boolean = false
  @State bgColor: ResourceColor = LhTokens.Color.Background.page
  @StorageProp(LH_COLORS_KEY) @Watch('recompute') colorsJson: string = ''

  // 表单态
  @State inputText: string = ''
  @State textareaText: string = ''
  @State checkboxChecked: boolean = true
  @State radioValue: string = 'a'
  @State switchChecked: boolean = false
  // 浮层态
  @State dialogVisible: boolean = false
  @State pickerVisible: boolean = false
  @State pickerIndex: number = 0

  // toast 指令式句柄（ArkUI 不提供子组件实例引用，由控制器代为转发 show/hide）
  private toastTop: LhToastController = new LhToastController()
  private toastCenter: LhToastController = new LhToastController()
  private toastBottom: LhToastController = new LhToastController()

  private colors: LhColors = LightLhColors()
  private pickerOptions: string[] = ['选项一', '选项二', '选项三', '选项四', '选项五']

  aboutToAppear(): void {
    LhTheme.apply(this.isDark)
  }

  private recompute(): void {
    let colors = LightLhColors()
    if (this.colorsJson !== '') {
      colors = JSON.parse(this.colorsJson) as LhColors
    }
    this.colors = colors
    this.bgColor = colors.backgroundPage
  }

  private toggleTheme(): void {
    this.isDark = !this.isDark
    LhTheme.apply(this.isDark)
  }

  @Builder
  sectionTitle(title: string) {
    Text(title)
      .fontSize(LhTokens.Typography.FontSize.medium)
      .fontWeight(LhTokens.Typography.FontWeight.bold)
      .fontColor(this.colors.textPrimary)
      .width('100%')
      .margin({ top: LhTokens.Spacing.lg })
  }

  @Builder
  sectionHint(hint: string) {
    Text(hint)
      .fontSize(LhTokens.Typography.FontSize.small)
      .fontColor(this.colors.textSecondary)
      .width('100%')
      .margin({ top: LhTokens.Spacing.xs })
  }

  @Builder
  buttonSection() {
    this.sectionTitle('Button 按钮')
    Flex({ wrap: FlexWrap.Wrap }) {
      LhButton({ onClick: () => {}, text: '默认' })
        .margin({ right: LhTokens.Spacing.sm, bottom: LhTokens.Spacing.sm })
      LhButton({ onClick: () => {}, type: LhButtonType.Primary, text: '主要' })
        .margin({ right: LhTokens.Spacing.sm, bottom: LhTokens.Spacing.sm })
      LhButton({ onClick: () => {}, type: LhButtonType.Success, text: '成功' })
        .margin({ right: LhTokens.Spacing.sm, bottom: LhTokens.Spacing.sm })
      LhButton({ onClick: () => {}, type: LhButtonType.Warning, text: '警告' })
        .margin({ right: LhTokens.Spacing.sm, bottom: LhTokens.Spacing.sm })
      LhButton({ onClick: () => {}, type: LhButtonType.Danger, text: '危险' })
        .margin({ right: LhTokens.Spacing.sm, bottom: LhTokens.Spacing.sm })
      LhButton({ onClick: () => {}, size: LhButtonSize.Small, text: '小型' })
        .margin({ right: LhTokens.Spacing.sm, bottom: LhTokens.Spacing.sm })
      LhButton({ onClick: () => {}, size: LhButtonSize.Large, type: LhButtonType.Primary, text: '大型' })
        .margin({ right: LhTokens.Spacing.sm, bottom: LhTokens.Spacing.sm })
      LhButton({ onClick: () => {}, type: LhButtonType.Primary, disabled: true, text: '禁用' })
        .margin({ right: LhTokens.Spacing.sm, bottom: LhTokens.Spacing.sm })
      LhButton({ onClick: () => {}, type: LhButtonType.Primary, loading: true, text: '加载中' })
        .margin({ right: LhTokens.Spacing.sm, bottom: LhTokens.Spacing.sm })
      LhButton({ onClick: () => {}, type: LhButtonType.Primary, icon: 'search', text: '搜索' })
        .margin({ right: LhTokens.Spacing.sm, bottom: LhTokens.Spacing.sm })
      LhButton({ onClick: () => {}, type: LhButtonType.Primary, bgPattern: true, text: '花纹底' })
        .margin({ right: LhTokens.Spacing.sm, bottom: LhTokens.Spacing.sm })
    }
    .width('100%')
  }

  @Builder
  iconSection() {
    this.sectionTitle('Icon 图标')
    Row({ space: LhTokens.Spacing.base }) {
      LhIcon({ name: 'search' })
      LhIcon({ name: 'check', tone: LhIconTone.Success })
      LhIcon({ name: 'close', tone: LhIconTone.Danger })
      LhIcon({ name: 'warning', tone: LhIconTone.Warning })
      LhIcon({ name: 'info', tone: LhIconTone.Info })
      LhIcon({ name: 'star', tone: LhIconTone.Primary })
      LhIcon({ name: 'back' })
      LhIcon({ name: 'edit' })
      LhIcon({ name: 'delete' })
      LhIcon({ name: 'plus', size: LhIconSize.Large, tone: LhIconTone.Primary })
    }
    .width('100%')
    this.sectionHint('本地字形体系（unicode 占位），生产环境应换矢量资产')
  }

  @Builder
  tagSection() {
    this.sectionTitle('Tag 标签')
    Row({ space: LhTokens.Spacing.sm }) {
      LhTag({ text: '默认' })
      LhTag({ text: '主要', type: LhTagType.Primary })
      LhTag({ text: '成功', type: LhTagType.Success })
      LhTag({ text: '警告', type: LhTagType.Warning })
    }
    .width('100%')
    Row({ space: LhTokens.Spacing.sm }) {
      LhTag({ text: '危险', type: LhTagType.Danger })
      LhTag({ text: '信息', type: LhTagType.Info })
      LhTag({ text: '描边', type: LhTagType.Primary, plain: true })
      LhTag({ text: '圆角', type: LhTagType.Success, round: true })
    }
    .width('100%')
    .margin({ top: LhTokens.Spacing.sm })
    Row({ space: LhTokens.Spacing.sm }) {
      LhTag({ text: '小', size: LhTagSize.Small })
      LhTag({ text: '中' })
      LhTag({ text: '大', size: LhTagSize.Large })
      LhTag({ text: '可关闭', type: LhTagType.Primary, closable: true, onClose: () => {} })
    }
    .width('100%')
    .margin({ top: LhTokens.Spacing.sm })
  }

  @Builder
  cellSection() {
    this.sectionTitle('Cell 单元格')
    Column() {
      LhCell({ title: '标题文字', value: '右侧值', label: '说明文字', clickable: true, onClick: () => {} })
      LhCell({ title: '必填项', required: true })
      LhCell({ title: '带图标', icon: 'search', value: '可点击', clickable: true, onClick: () => {} })
      LhCell({ title: '无分隔线', value: '末行', bordered: false })
    }
    .width('100%')
    .borderRadius(LhTokens.Radius.base)
    .backgroundColor(this.colors.backgroundDefault)
  }

  @Builder
  textSection() {
    this.sectionTitle('Text 文本')
    LhText({ content: '正文标题（extraLarge 大号）', level: LhTextLevel.ExtraLarge })
    LhText({ content: '大标题（large）', level: LhTextLevel.Large })
      .margin({ top: LhTokens.Spacing.xs })
    LhText({ content: '默认正文（base，primary 色调）' })
      .margin({ top: LhTokens.Spacing.xs })
    LhText({ content: '常规说明（regular 色调）', tone: LhTextTone.Regular })
      .margin({ top: LhTokens.Spacing.xs })
    LhText({ content: '次要说明（secondary 色调）', tone: LhTextTone.Secondary })
      .margin({ top: LhTokens.Spacing.xs })
    LhText({ content: '占位提示（placeholder 色调）', tone: LhTextTone.Placeholder })
      .margin({ top: LhTokens.Spacing.xs })
    LhText({ content: '选中态文字（selected 色调）', tone: LhTextTone.Selected })
      .margin({ top: LhTokens.Spacing.xs })
    LhText({ content: '加粗正文（bold 字重）', weight: LhTextWeight.Bold })
      .margin({ top: LhTokens.Spacing.xs })
    LhText({ content: '右对齐（align=end）', align: LhTextAlign.End })
      .width('100%')
      .margin({ top: LhTokens.Spacing.xs })
  }

  @Builder
  inputSection() {
    this.sectionTitle('Input 输入框')
    LhInput({
      value: this.inputText,
      placeholder: '请输入内容',
      clearable: true,
      maxlength: 20,
      onValueChange: (value: string) => { this.inputText = value },
    })
    LhInput({
      placeholder: '密码框',
      type: LhInputType.Password,
      onValueChange: (value: string) => {},
    })
      .margin({ top: LhTokens.Spacing.sm })
    LhInput({
      placeholder: '小型输入框',
      size: LhInputSize.Small,
      onValueChange: (value: string) => {},
    })
      .margin({ top: LhTokens.Spacing.sm })
    LhInput({
      placeholder: '禁用态',
      disabled: true,
      onValueChange: (value: string) => {},
    })
      .margin({ top: LhTokens.Spacing.sm })
  }

  @Builder
  textareaSection() {
    this.sectionTitle('Textarea 多行输入')
    LhTextarea({
      value: this.textareaText,
      placeholder: '请输入备注（最多 50 字）',
      rows: 3,
      showCount: true,
      maxlength: 50,
      onValueChange: (value: string) => { this.textareaText = value },
    })
  }

  @Builder
  checkboxSection() {
    this.sectionTitle('Checkbox 复选框')
    Column({ space: LhTokens.Spacing.base }) {
      LhCheckbox({
        checked: this.checkboxChecked,
        label: '同意服务条款',
        onChange: (checked: boolean) => { this.checkboxChecked = checked },
      })
      LhCheckbox({ checked: true, indeterminate: true, label: '半选态（不确定）' })
      LhCheckbox({ checked: false, disabled: true, label: '禁用态' })
      Row({ space: LhTokens.Spacing.base }) {
        LhCheckbox({ checked: true, size: LhCheckboxSize.Small, label: '小' })
        LhCheckbox({ checked: true, label: '中' })
        LhCheckbox({ checked: true, size: LhCheckboxSize.Large, label: '大' })
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  radioSection() {
    this.sectionTitle('Radio 单选框')
    Column({ space: LhTokens.Spacing.base }) {
      LhRadio({
        label: '选项一',
        value: 'a',
        checked: this.radioValue === 'a',
        onChange: () => { this.radioValue = 'a' },
      })
      LhRadio({
        label: '选项二',
        value: 'b',
        checked: this.radioValue === 'b',
        onChange: () => { this.radioValue = 'b' },
      })
      LhRadio({ label: '禁用态', value: 'c', disabled: true })
      Row({ space: LhTokens.Spacing.base }) {
        LhRadio({ label: '小', value: 's', size: LhRadioSize.Small, checked: true })
        LhRadio({ label: '中', value: 'm', checked: true })
        LhRadio({ label: '大', value: 'l', size: LhRadioSize.Large, checked: true })
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  switchSection() {
    this.sectionTitle('Switch 开关')
    Row({ space: LhTokens.Spacing.xl }) {
      LhSwitch({
        checked: this.switchChecked,
        onChange: (checked: boolean) => { this.switchChecked = checked },
      })
      LhSwitch({ checked: true })
      LhSwitch({ checked: false, disabled: true })
      LhSwitch({ checked: true, loading: true })
    }
    .width('100%')
    Row({ space: LhTokens.Spacing.xl }) {
      LhSwitch({ checked: true, size: LhSwitchSize.Small })
      LhSwitch({ checked: true })
      LhSwitch({ checked: true, size: LhSwitchSize.Large })
    }
    .width('100%')
    .margin({ top: LhTokens.Spacing.sm })
  }

  @Builder
  loadingSection() {
    this.sectionTitle('Loading 加载')
    Row({ space: LhTokens.Spacing.xl }) {
      LhLoading({ size: LhLoadingSize.Small })
      LhLoading()
      LhLoading({ size: LhLoadingSize.Large })
      LhLoading({ tone: LhLoadingTone.Success })
      LhLoading({ tone: LhLoadingTone.Danger })
    }
    .width('100%')
  }

  @Builder
  dialogSection() {
    this.sectionTitle('Dialog 对话框')
    LhButton({
      text: '打开对话框',
      type: LhButtonType.Primary,
      onClick: () => { this.dialogVisible = true },
    })
    this.sectionHint('确认后自动隐藏并弹出轻提示')
  }

  @Builder
  toastSection() {
    this.sectionTitle('Toast 轻提示')
    Row({ space: LhTokens.Spacing.sm }) {
      LhButton({ text: '顶部', onClick: () => { this.toastTop.show('操作成功') } })
      LhButton({ text: '居中', type: LhButtonType.Primary, onClick: () => { this.toastCenter.show('已保存到本地') } })
      LhButton({ text: '底部', type: LhButtonType.Danger, onClick: () => { this.toastBottom.show('网络连接失败') } })
    }
    .width('100%')
  }

  @Builder
  pickerSection() {
    this.sectionTitle('Picker 选择器')
    LhButton({
      text: '打开选择器',
      type: LhButtonType.Primary,
      onClick: () => { this.pickerVisible = true },
    })
    this.sectionHint(`当前选中：${this.pickerOptions[this.pickerIndex]}`)
  }

  build() {
    Stack() {
      Column() {
        LhNavbar({
          title: 'lh-ui-harmony',
          leftText: '返回',
          leftIcon: 'back',
          rightText: this.isDark ? '切明色' : '切暗色',
          onLeftClick: () => {},
          onRightClick: () => { this.toggleTheme() },
        })

        Scroll() {
          Column({ space: LhTokens.Spacing.base }) {
            this.buttonSection()
            this.iconSection()
            this.tagSection()
            this.cellSection()
            this.textSection()
            this.inputSection()
            this.textareaSection()
            this.checkboxSection()
            this.radioSection()
            this.switchSection()
            this.loadingSection()
            this.dialogSection()
            this.toastSection()
            this.pickerSection()
          }
          .width('100%')
          .padding({
            left: LhTokens.Spacing.base,
            right: LhTokens.Spacing.base,
            bottom: LhTokens.Spacing.xxl,
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')

      // 浮层：须作为 Stack 最后子节点（dialog → picker → toast，层级递增）
      LhDialog({
        visible: this.dialogVisible,
        title: '删除确认',
        content: '删除后不可恢复，确定要删除这条记录吗？',
        type: LhDialogType.Warning,
        closable: true,
        onConfirm: () => { this.toastCenter.show('已删除') },
        onCancel: () => {},
        onClose: () => { this.dialogVisible = false },
      })

      LhPicker({
        visible: this.pickerVisible,
        options: this.pickerOptions,
        value: this.pickerIndex,
        title: '请选择',
        onValueChange: (value: number) => { this.pickerIndex = value },
        onConfirm: (value: number) => { this.pickerIndex = value },
        onCancel: () => {},
        onClose: () => { this.pickerVisible = false },
      })

      LhToast({ type: LhToastType.Success, position: LhToastPosition.Top, controller: this.toastTop })
      LhToast({ type: LhToastType.Default, position: LhToastPosition.Center, controller: this.toastCenter })
      LhToast({ type: LhToastType.Danger, position: LhToastPosition.Bottom, controller: this.toastBottom })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.bgColor)
  }
}
