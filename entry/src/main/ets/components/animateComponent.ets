import router from '@ohos.router';

@Component
export struct AnimateComponent {
  build() {
    Tabs({index: 3}) {
      TabContent() {
        CompA()
      }
      .tabBar('显示/属性')
      .tabIndex(0)

      TabContent() {
        CompB()
      }
      .tabBar('组件转场')
      .tabIndex(1)

      TabContent() {
        CompC()
      }
      .tabBar('共享元素转场')
      .tabIndex(2)

      TabContent() {
        CompD()
      }
      .tabBar('页面转场')
      .tabIndex(3)
    }
  }
}

@Component
struct CompA {
  @State itemAlign: HorizontalAlign = HorizontalAlign.Start
  allAlign: HorizontalAlign[] = [HorizontalAlign.Start, HorizontalAlign.Center, HorizontalAlign.End]
  alignIndex: number = 0

  @State buttonWidth: number = 200
  @State boxColor: Color = Color.Green
  allColors: Color[] = [Color.Brown, Color.Orange, Color.Pink, Color.Yellow]
  colorIndex: number = 0

  build() {
    Column({ space: 20 }) {
      Column() {
        Button('切换竖轴对齐方式')
          .onClick(() => {
            // 显示动画
            animateTo({duration: 1000, curve: Curve.EaseInOut}, () => {
              this.itemAlign = this.allAlign[(++this.alignIndex) % this.allAlign.length]
            })
          })
      }
      .width('100%')
      .alignItems(this.itemAlign)
      Button('改变按钮的大小')
        .width(this.buttonWidth)
        .onClick(() => {
          animateTo({duration: 500, curve: Curve.EaseInOut}, () => {
            this.buttonWidth += 20
          })
        })
      Column() {
        Text('改变容器的背景颜色')
          .fontColor(Color.White)
      }
      .onClick(() => {
        this.boxColor = this.allColors[this.colorIndex++ % this.allColors.length]
      })
      .width('50%')
      .height(100)
      .justifyContent(FlexAlign.Center)
      // .animation({duration: 1000, curve: Curve.EaseInOut})
      .backgroundColor(this.boxColor)
      .animation({duration: 1000, curve: Curve.EaseInOut})
      // .width(this.buttonWidth)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .height('100%')
  }
}

@Component
struct CompB {
  @State flag: boolean = true
  @State list: string[] = ['1', '2', '3']
  startNumber: number = 4

  build() {
    Column({ space: 10 }) {
      Button(`${this.flag ? '隐藏' : '显示'}`)
        .onClick(() => {
          animateTo({ duration: 1000 }, () => {
            // 动画闭包内控制组件的出现和消失
            this.flag = !this.flag;
          })
        })
      if (this.flag) {
        Column() {
          Text('if/esle转场动画')
        }
        .width('50%')
        .height(100)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Color.Pink)
        .transition({ type: TransitionType.Insert, translate: { x: 200, y: -200 } })
        .transition({ type: TransitionType.Delete, opacity: 0, scale: { x: 0, y: 0 } })
      }
      // ForEach 转场动画
      ForEach(this.list, (item) => {
        Text(item)
          .width(240)
          .height(40)
          .fontSize(18)
          .borderWidth(1)
          .backgroundColor(Color.Orange)
          .textAlign(TextAlign.Center)
          .transition({ type: TransitionType.All, translate: { x: 200 }, scale: { x: 0, y: 0 } })
      }, item => item)
      Button('向头部添加元素')
        .fontSize(16)
        .width(160)
        .onClick(() => {
          animateTo({ duration: 1000 }, () => {
            // 往数组头部插入一个元素，导致ForEach在头部增加对应的组件
            this.list.unshift(this.startNumber + '');
            this.startNumber++;
          })
        })
      Button('向尾部添加元素')
        .width(160)
        .fontSize(16)
        .onClick(() => {
          animateTo({ duration: 1000 }, () => {
            // 往数组尾部插入一个元素，导致ForEach在尾部增加对应的组件
            this.list.push(this.startNumber + '');
            this.startNumber++;
          })
        })
      Button('删除头部元素')
        .width(160)
        .fontSize(16)
        .onClick(() => {
          animateTo({ duration: 1000 }, () => {
            // 删除数组的头部元素，导致ForEach删除头部的组件
            this.list.shift();
          })
        })
      Button('删除尾部元素')
        .width(160)
        .fontSize(16)
        .onClick(() => {
          animateTo({ duration: 1000 }, () => {
            // 删除数组的尾部元素，导致ForEach删除尾部的组件
            this.list.pop();
          })
        })
    }
  }
}

@Component
struct CompC {
  build() {
    Column({ space: 10}) {
      Button('Exchange类型共享')
        .width(200)
        .height(100)
        .sharedTransition('sharedButton1', { type: SharedTransitionEffectType.Exchange, duration: 1000 })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/Detail',
            params: {
              type: '2'
            }
          })
        })
      // Text('Static类型共享')
      //   .width('100%')
      //   .height(100)
      //   .textAlign(TextAlign.Center)
      //   .backgroundColor(Color.Pink)
      //   .sharedTransition('sharedText1', { type: SharedTransitionEffectType.Static, duration: 1000 })
      //   .onClick(() => {
      //     router.pushUrl({
      //       url: 'pages/Detail'
      //     })
      //   })
    }
  }
}

@Component
struct CompD {
  build() {
    Column()
      .onClick(() => {
        router.pushUrl({
          url: 'pages/Detail',
          params: {
            type: '1'
          }
        })
      })
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Pink)
  }
}