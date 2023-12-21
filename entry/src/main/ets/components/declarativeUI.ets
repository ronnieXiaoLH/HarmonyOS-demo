@Component
export struct DeclarativeUiComponent {
  @State message: string = 'Hello, World!';

  // clickHandler(): void {
  //   this.message = 'Hello, ArkUI!'
  // }

  // clickHandler = () => {
  //   this.message = 'Hello, ArkUI!'
  // }

  build() {
    Row() {
      Text(this.message)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        // 属性值为表达式
        .fontColor(1 > 2 ? 'black' : 'red')
        .onClick(() => {
          // 状态变量message的改变驱动UI刷新，UI从'Hello, World!'刷新为'Hello, ArkUI!'
          this.message = 'Hello, ArkUI!'
        })
        // 事件处理方法不是箭头函数需要绑定 this
        // .onClick(this.clickHandler.bind(this))
        // 事件处理方法是箭头函数不需要绑定 this
        // .onClick(this.clickHandler)
    }
  }
}