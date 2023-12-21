import router from '@ohos.router';

@Component
export struct PageRouter {build() {
    Column({ space: 10 }) {
      Text('Home Page')
        .fontSize(30)
      Button('Jump to Detail')
        .onClick(() => {
          router.pushUrl({
            url: 'pages/Detail',
            // 参数
            params: {
              id: 'home',
              info: {
                title: '我来自 Home 页'
              }
            }
          })
        })
    }
  }
}