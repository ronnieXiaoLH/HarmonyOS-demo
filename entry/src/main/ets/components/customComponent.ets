// @Extend 扩展组件样式
@Extend(Text) function  textFontSize (fontSize = 16) {
  .fontSize(fontSize)
}

@Extend(Text) function textFontStyle (options: { fontSize?: number, fontWeight: number, color: Color }) {
  // 封装和预定义相同组件的 @Extend 方法
  .textFontSize(options.fontSize)
  .fontStyle(FontStyle.Italic)
  .fontWeight(options.fontWeight)
  .fontColor(options.color)
}

// 全局 @styles 样式
@Styles function globalStyles() {
  .backgroundColor(Color.Pink)
  .padding(10)
}

@Component
struct MyChildComponet {
  @BuilderParam buildSlot: () => void

  @State fontSize: number = 16

  build() {
    Column() {
      Text('子组件自己的内容')
        .textFontStyle({ fontSize: this.fontSize, fontWeight: 600, color: Color.Yellow })
        .onClick(() => {
          this.fontSize += 4
        })
      this.buildSlot()
    }
  }
}

@Component
export struct MyCustomComponent {
  private count: number = 0
  @State marginNum: number = 0

  @Builder buildName(name: string) {
    Text(`姓名：${name}`)
  }

  @Builder buildAge(age: number) {
    Text(`年龄：${age}`)
  }

  @Builder buildPersonInfo($$: { name: string, age: number }) {
    this.buildName($$.name)
    this.buildAge($$.age)
    Text(`组件内部的数据：${this.count}`)
  }

  @Builder buildSlot() {
    Text('父组件传递的内容')
  }

  @Styles scopedStyles() {
    .margin({ bottom: this.marginNum })
    .onClick(() => {
      this.marginNum = this.marginNum + 10
    })
  }

  build() {
    Column({ space: 10 }) {
      Text('自定义组件')
        .fontSize(30)
        .scopedStyles()
        .textFontStyle({ fontSize: 30, fontWeight: 700, color: Color.Red })
      this.buildPersonInfo({ name: '张三', age: 18 })
      MyChildComponet({ buildSlot: this.buildSlot })
        .margin({ top: 20 })
    }
    .globalStyles()
  }
}