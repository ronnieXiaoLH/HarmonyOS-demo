import common from '@ohos.app.ability.common';

@Entry
@Component
struct SecondAbility {
  private context = getContext(this) as common.UIAbilityContext

  stop() {
    this.context.terminateSelf()
  }

  build() {
    Column({ space: 10 }) {
      Text('第二个Ability的页面')
      Button('停止')
        .onClick(() => {
          this.stop()
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}