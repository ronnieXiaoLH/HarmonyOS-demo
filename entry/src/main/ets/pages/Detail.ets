import router from '@ohos.router';
import Prompt from '@system.prompt';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Detail {
  @State params: { id?: string, info?: { title: string }, type?: string } = {}

  onPageShow() {
    // 接收参数
    this.params = router.getParams()
  }

  handleBack(): void {
    router.back({
      url: 'pages/Index',
      params: {
        msg: '我来自 Detail 页'
      }
    })
  }

  async handlePromptBack() {
    // 系统默认询问框
    // router.showAlertBeforeBackPage({
    //   message: '确认返回吗？'
    // })
    // 自定义询问框
    const res = await promptAction.showDialog({
      message: '确认返回吗？',
      buttons: [
        {
          text: '取消',
          color: '#FF0000'
        },
        {
          text: '确认',
          color: '#0099FF'
        }
      ]
    })

    if (res.index === 0) return

    router.back({
      url: 'pages/Index',
      params: {
        msg: '我来自 Detail 页'
      }
    })
  }

  build() {
    if (this.params.type === '1') {
      Column()
        .onClick(() => {
          router.back()
        })
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Orange)
    } else {
      Column({ space: 10 }) {
        if (this.params.type === '2') {
          Button('Exchange类型共享')
            .width(150)
            .height(50)
            .sharedTransition('sharedButton1', { type: SharedTransitionEffectType.Exchange, duration: 1000 })
            .onClick(() => {
              router.back()
            })
        } else {
          Text('Detail Page')
            .fontSize(30)
          Text('接收到的信息：' + this.params?.info?.title)
          Button('直接Back')
            .onClick(this.handleBack)
          Button('带询问框Back')
            .onClick(this.handlePromptBack)
        }
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
  }

  pageTransition() {
    // 定义页面进入时的效果，从右侧滑入，时长为1000ms，页面栈发生push操作时该效果才生效
    PageTransitionEnter({ type: RouteType.Push, duration: 1000, curve: Curve.Linear })
      .slide(SlideEffect.Right)
    // 定义页面退出时的效果，向左侧滑出，时长为1000ms，页面栈发生push操作时该效果才生效
    PageTransitionExit({ type: RouteType.Push, duration: 1000, curve: Curve.Linear })
      .slide(SlideEffect.Left)
  }
}