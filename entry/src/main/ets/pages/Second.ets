import router from '@ohos.router';

let storage = LocalStorage.GetShared()

@Entry(storage)
@Component
struct Second {
  @LocalStorageLink('num') num: number = 0
  build() {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      Text('根组件 num：' + this.num)
      // 获取到的是常规变量，常规变量的更新不会引起视图的更新
      Text('根组件 storage num：' + storage.get('num'))
      Button('根组件：num + 1')
        .onClick(() => {
          this.num += 1
          storage.set<number>('num', 1 + storage.get<number>('num'))
          const linkNum = storage.link<number>('num')
          linkNum.set(linkNum.get() + 1)
        })
      Button('跳转到第一个页面')
        .onClick(() => {
          router.pushUrl({ url: 'pages/Index' })
        })
        .margin({top: 20})
    }
    .width('100%')
    .height('100%')
  }
}