@Component
export struct AppStateManagement {
  build() {
    Column({ space: 20 }) {
      CompA()
      CompB()
    }
  }
}

@Component
struct CompA {
  @LocalStorageLink('num') num: number = 1
  @StorageLink('count') count: number = 1

  build() {
    Column() {
      Text('CompA LocalStorage num：' + this.num)
      Button('CompA LocalStorage：num + 1')
        .onClick(() => {
          this.num++
        })
      Text('CompA AppStorage count：' + this.count)
      Button('CompA AppStorage：count + 1')
        .onClick(() => {
          this.count++
        })
    }
  }
}

@Component
struct CompB {
  build() {
    CompC()
  }
}

@Component
struct CompC {
  @LocalStorageLink('num') num: number = 1
  @StorageLink('count') count: number = 1

  build() {
    Column() {
      Text('CompC LocalStorage num：' + this.num)
      Button('CompC LocalStorage：num + 1')
        .onClick(() => {
          this.num++
        })
      Text('CompC AppStorage count：' + this.count)
      Button('CompC AppStorage：count + 1')
        .onClick(() => {
          this.count++
        })
    }
  }
}