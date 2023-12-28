@Entry
@Component
struct SubWindow {
  build() {
    Column() {
      Text('我是子窗口')
        .fontSize(30)
        .fontColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.Black)
  }
}