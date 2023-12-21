import router from '@ohos.router';
import { DeclarativeUiComponent } from '../components/declarativeUi'
import { MyCustomComponent } from '../components/customComponent'
import { StateStylesComponent } from '../components/stateStyles'
import { ComponentStateManagement } from '../components/componentStateManagement'
import { AppStateManagement } from '../components/appStateManagement'
import { OtherStateManagement } from '../components/otherStateManagement'
import { RenderController } from '../components/renderController'
import { PageRouter } from '../components/pageRouter'
import { GraphComponent } from '../components/graphComponent'
import { AnimateComponent } from '../components/animateComponent'

@Entry
@Component
struct Index {
  build() {
    Tabs({ index: 8 }) {
      TabContent() {
        DeclarativeUiComponent()
      }
      .tabBar('声明式UI')
      .tabIndex(0)

      TabContent() {
        MyCustomComponent()
      }
      .tabBar('自定义组件')
      .tabIndex(1)

      TabContent() {
        StateStylesComponent()
      }
      .tabBar('多态样式')
      .tabIndex(2)

      TabContent() {
        ComponentStateManagement()
      }
      .tabBar("组件状态管理")
      .tabIndex(3)

      TabContent() {
        OtherStateManagement()
      }
      .tabBar("其他状态管理")
      .tabIndex(4)

      TabContent() {
        RenderController()
      }
      .tabBar("渲染控制")
      .tabIndex(5)

      TabContent() {
        PageRouter()
      }
      .tabBar("页面路由")
      .tabIndex(6)

      TabContent() {
        GraphComponent()
      }
      .tabBar("显示图形")
      .tabIndex(7)

      TabContent() {
        AnimateComponent()
      }
      .tabBar("动画")
      .tabIndex(8)
    }
    .vertical(true)
    .barWidth(100)
    .barHeight(300)
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

// let storage = new LocalStorage({
//   num: 1,
// })

// let storage = LocalStorage.GetShared()
//
// // 一定是先 PersistentStorage 初始化属性，然后 AppStorage 再访问
// PersistentStorage.PersistProp('count', 1000)
//
// // AppStorage.SetOrCreate('count', 10)
//
// @Entry(storage)
// @Component
// struct Index {
//   @LocalStorageLink('num') num: number = 0
//   @StorageLink('count') count: number = 0
//
//   build() {
//     Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
//       Text('根组件 LocalStorage num：' + this.num)
//       // 获取到的是常规变量，常规变量的更新不会引起视图的更新
//       Text('根组件 LocalStorage num：' + storage.get('num'))
//       Button('根组件 LocalStorage：num + 1')
//         .onClick(() => {
//           this.num += 1
//           storage.set<number>('num', 1 + storage.get<number>('num'))
//           const linkNum = storage.link<number>('num')
//           linkNum.set(linkNum.get() + 1)
//         })
//       Text('根组件 AppStorage count：' + this.count)
//       // 获取到的是常规变量，常规变量的更新不会引起视图的更新
//       Text('根组件 AppStorage count：' + AppStorage.Get('count'))
//       Button('根组件 AppStorage：count + 1')
//         .onClick(() => {
//           this.count += 1
//           AppStorage.Set<number>('count', 1 + AppStorage.Get<number>('count'))
//           const linkCount = AppStorage.Link('count')
//           linkCount.set(linkCount.get() + 1)
//         })
//       AppStateManagement()
//         .margin({ top: 20 })
//       Button('跳转到第二个页面')
//         .onClick(() => {
//           router.pushUrl({ url: 'pages/Second' })
//         })
//         .margin({ top: 20 })
//     }
//     .width('100%')
//     .height('100%')
//   }
// }
