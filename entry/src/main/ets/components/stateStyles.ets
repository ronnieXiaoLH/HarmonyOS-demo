@Component
export struct StateStylesComponent {
  @State pressedColor: Color = Color.Yellow
  private normalColor: Color = Color.Blue

  build() {
    Column() {
      Button('Click me')
        .stateStyles({
          focused: {
            .backgroundColor(Color.Pink)
          },
          pressed: {
            .backgroundColor(this.pressedColor)
          },
          normal: {
            .backgroundColor(this.normalColor)
          }
        })
        .onClick(() => {
          if (this.pressedColor === Color.Yellow) {
            this.pressedColor = Color.Green
          } else {
            this.pressedColor = Color.Yellow
          }
        })
    }
  }
}