/**
 * top.lhgb.ui.harmony 聚合导出（ohpm 包入口，oh-package.json5 的 main 指向本文件）。
 *
 * 只做聚合，不含任何实现：组件体在 components/<comp>/Index.ets，外观解析在
 * 各 Lh<Comp>Tokens.ets，主题工具在 common/theme/。core codegen 不生成 UI
 * （AGENTS.md 红线 3），这里的每一行都是手写 ArkUI。
 *
 * 血脉隔离（红线 4）：本文件不引入任何 @lh-ui/share / web 血脉符号。
 */

// 基础组件
export { LhButton } from './components/button/Index'
export { LhButtonType, LhButtonSize, LhButtonTokens, LhButtonAppearance } from './components/button/LhButtonTokens'
export { LhIcon } from './components/icon/Index'
export { LhIconSize, LhIconTone, LhIconTokens, LhIconAppearance } from './components/icon/LhIconTokens'
export { LhTag } from './components/tag/Index'
export { LhTagType, LhTagSize, LhTagTokens, LhTagAppearance } from './components/tag/LhTagTokens'
export { LhCell } from './components/cell/Index'
export { LhCellTokens, LhCellAppearance } from './components/cell/LhCellTokens'
export { LhText } from './components/text/Index'
export { LhTextLevel, LhTextWeight, LhTextTone, LhTextAlign, LhTextTokens, LhTextAppearance } from './components/text/LhTextTokens'

// 表单组件
export { LhInput } from './components/input/Index'
export { LhInputType, LhInputSize, LhInputTokens, LhInputAppearance } from './components/input/LhInputTokens'
export { LhTextarea } from './components/textarea/Index'
export { LhTextareaTokens, LhTextareaAppearance } from './components/textarea/LhTextareaTokens'
export { LhCheckbox } from './components/checkbox/Index'
export { LhCheckboxSize, LhCheckboxMark, LhCheckboxTokens, LhCheckboxAppearance } from './components/checkbox/LhCheckboxTokens'
export { LhRadio } from './components/radio/Index'
export { LhRadioSize, LhRadioTokens, LhRadioAppearance } from './components/radio/LhRadioTokens'
export { LhSwitch } from './components/switch/Index'
export { LhSwitchSize, LhSwitchTokens, LhSwitchAppearance } from './components/switch/LhSwitchTokens'
export { LhPicker } from './components/picker/Index'
export { LhPickerTokens, LhPickerAppearance } from './components/picker/LhPickerTokens'

// 反馈组件
export { LhDialog } from './components/dialog/Index'
export { LhDialogType, LhDialogTokens, LhDialogAppearance } from './components/dialog/LhDialogTokens'
export { LhToast } from './components/toast/Index'
export { LhToastType, LhToastPosition, LhToastTokens, LhToastAppearance, LhToastController } from './components/toast/Index'
export { LhLoading } from './components/loading/Index'
export { LhLoadingSize, LhLoadingTone, LhLoadingTokens, LhLoadingAppearance } from './components/loading/LhLoadingTokens'

// 导航组件
export { LhNavbar } from './components/navbar/Index'
export { LhNavbarTokens, LhNavbarAppearance } from './components/navbar/LhNavbarTokens'

// 主题
export { LhTheme } from './common/theme/LhThemeApply'
export { LhColors, LightLhColors, DarkLhColors, LH_COLORS_KEY, LH_IS_DARK_KEY } from './common/theme/LhTheme'
export { lhVp } from './common/LhVp'

// 令牌（core codegen 产物的再导出：唯一外部令牌来源，红线 1/2）
// 暗色令牌是并列对象模型——LhDarkTokens 只含 Color 子类，尺寸/动效/圆角暗色不覆盖（D18）。
// 需要暗色尺寸时取明色对象的值（组件已如此实现，见各 Lh<Comp>Tokens.ets）。
export { LhTokens } from './tokens/LhTokens'
export { LhDarkTokens } from './tokens/LhDarkTokens'
export { LhShadow } from './tokens/LhShadow'

// 原生文档模块（docsui）：md 驱动的真交互文档宿主，照 android `:docsui` 范式。
// pages/ 与 DocRegistry.ets / DocPageDispatch.ets 是生成物（pnpm gen:docs，禁手改）；
// previews/ 手写真交互预览。使用方在自己的页面里嵌入 LhDocs() 即可（见 AGENTS.md「原生文档模块」）。
export { LhDocs } from './docsui/Index'
export { DocGroup, DocEntry, DocSection, DocTable, DocRow } from './docsui/Index'
