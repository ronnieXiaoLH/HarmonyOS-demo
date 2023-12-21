@Component
export struct RenderController {
  build() {
    Tabs() {
      TabContent() {
        IfController()
      }
      .tabBar('条件渲染')

      TabContent() {
        ForEachController()
      }
      .tabBar('循环渲染')
    }
  }
}

// 条件渲染
@Component
struct IfController {
  @State count: number = 1
  @State flag: boolean = true

  build() {
    Column({ space: 10 }) {
      Text(`Count: ${this.count}`)
      if (this.flag) {
        if (this.count % 2 === 1) {
          Text(`Count 是基数`)
            .fontColor(Color.Blue)
        } else {
          Text(`Count 是偶数`)
            .fontColor(Color.Green)
        }
      }
      Button('Count + 1')
        .onClick(() => {
          this.count++
        })
      Button(`${this.flag ? '隐藏' : '显示'}文本`)
        .onClick(() => {
          this.flag = !this.flag
        })
    }
  }
}

// 循环渲染
@Component
struct ForEachController {
  @State list: string[] = ['One', 'Two', 'Two', 'Three']

  build() {
    Column() {
      Text('默认键值的列表：')
        .fontSize(30)
      List() {
        ForEach(
          this.list,
          (item: string) => {
            ListItem() {
              Text(item)
                .width('100%')
                .margin({ bottom: 20 })
                .textAlign(TextAlign.Center)
            }
          }
        )
      }
      Text('自定义键值的列表：')
        .fontSize(30)
      List() {
        ForEach(
          this.list,
          (item: string) => {
            ListItem() {
              Text(item)
                .width('100%')
                .margin({ bottom: 20 })
                .textAlign(TextAlign.Center)
            }
          },
          (item: string, index: number) => {
            return item
          }
        )
      }
    }
  }
}