@Component
export struct ComponentStateManagement {
  build() {
    Tabs() {
      TabContent() {
        StateComponent()
      }
      .tabBar('@State')

      TabContent() {
        PropAndLinkComponent()
      }
      .tabBar('@Prop / @Link')

      TabContent() {
        ProvideAndConsumeComponent()
      }
      .tabBar('@Provide & @Consume')

      TabContent() {
        ObserverAndObjectLinkComponent()
      }
      .tabBar('@Observer & @ObjectLink')
    }
  }
}

// @State
@Component
export struct StateComponent {
  @State count: number = 0
  @State arr: Array<{username: string}> = [{ username: '张三' }]
  @State obj: { [key in string]: any } = { a: { b: 1 } }

  @Builder buildList() {
    List() {
      ForEach(this.arr, (item, index) => {
        ListItem() {
          Text('姓名：' + item.username)
            .width('100%')
            .textAlign(TextAlign.Center)
            .onClick(() => {
              // 数组项中的属性赋值观察不到
              // this.arr[index].username += '!'
              this.arr[index] = { username: this.arr[index].username + '！'}
            })
        }
      })
    }
    .margin({top: 20, bottom: 20})
  }

  build() {
    Column({ space: 10 }) {
      Text(`Count：${this.count}`)
        .onClick(() => {
          this.count++
        })
      this.buildList()
      Button('新增')
        .onClick(() => {
          this.arr.push({ username: '李四' })
        })
      Text('对象的属性值：' + this.obj.a.b)
        .onClick(() => {
          // 对象嵌套属性赋值观察不到
          // this.obj.a.b = this.obj.a.b + 1
          this.obj.a = {
            b: this.obj.a.b + 1
          }
        })
    }
  }
}

// @Prop & @Link
@Component
struct ChildComponentA {
  // 可以有默认值
  @Prop count: number = 100
  // 不能有默认值
  @Link list: Array<number>

  @Builder buildList() {
    List() {
      ForEach(this.list, (item) => {
        ListItem() {
          Text(`Item：${item}`)
            .width('100%')
            .textAlign(TextAlign.Center)
        }
      })
    }
  }

  build() {
    Column() {
      Text('子组件中 count 的值：' + this.count)
        .onClick(() => {
          this.count += 10
        })
      this.buildList()
      Button('子组件中添加')
        .onClick(() => {
          this.list.push(this.list.length + 1)
        })
    }
  }
}

@Component
export struct PropAndLinkComponent {
  @State count: number = 0
  @State list: number[] = [1, 2, 3]

  build() {
    Column({ space: 10 }) {
      Text('父组件中 count 的值：' + this.count)
        .onClick(() => {
          this.count++
        })
      // @Link 的数据使用 `$` 传递
      ChildComponentA({ count: this.count, list: $list })
      Button('父组件中添加')
        .onClick(() => {
          this.list.push(this.list.length + 1)
        })
    }
  }
}

// @Provide & @Consume
@Component
export struct ProvideAndConsumeComponent {
  @Provide count: number = 0
  @State list: number[] = [1, 2, 3]

  build() {
    Column({ space: 10 }) {
      Text('祖先组件：' + this.count)
        .onClick(() => {
          this.count++
        })
      CompA()
      CompB()
    }
  }
}

@Component
struct CompA {
  @Consume count: number

  build() {
    Text('CompA:'+ this.count)
      .onClick(() => {
        this.count++
      })
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
  @Consume count: number

  build() {
    Text('CompC:'+ this.count)
      .onClick(() => {
        this.count++
      })
  }
}

// @Observed & @ObjectLink
@Observed
class ClassObj {
  public a: number
  public b: ClassObjB

  constructor(a: number, b: ClassObjB) {
    this.a = a
    this.b = b
  }
}

@Observed
class ClassObjB {
  public c: number

  constructor(c: number) {
    this.c = c
  }
}

@Component
struct ChildComponent {
  @ObjectLink obj: ClassObj
  @ObjectLink b: ClassObjB
  // @Consume obj: ClassObj
  // @Consume b: ClassObjB

  build() {
    Column({ space: 10 }) {
      Text('子组件中obj.a的值：' + this.obj.a)
      Text('子组件中obj.b.c的值：' + this.obj.b.c)
      Text('父组件中b.c的值：' + this.b.c)
    }
  }
}


@Component
export struct ObserverAndObjectLinkComponent {
  @State b: ClassObjB = new ClassObjB(1)
  @State obj: ClassObj = new ClassObj(1, this.b)
  // @Provide b: ClassObjB = new ClassObjB(1)
  // @Provide obj: ClassObj = new ClassObj(1, this.b)

  build() {
    Column({ space: 10 }) {
      Text('父组件中obj.a的值：' + this.obj.a)
      Text('父组件中obj.b.c的值：' + this.obj.b.c)
      Text('父组件中b.c的值：' + this.b.c)
      Button('this.obj.a += 1')
        .onClick(() => {
          this.obj.a += 1
          console.log('父组件click...', this.obj.a)
        })
      Button('this.obj.b.c += 1')
        .onClick(() => {
          this.obj.b.c += 1
          console.log('父组件click...', this.obj.b.c)
        })
      Button('this.b.c += 1')
        .onClick(() => {
          this.b.c += 1
          console.log('父组件click...', this.obj.b.c)
        })
      ChildComponent({ obj: this.obj, b: this.b })
      // ChildComponent()
    }
  }
}
