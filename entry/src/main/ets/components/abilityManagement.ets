import common from '@ohos.app.ability.common';

@Component
export struct AbilityManagement {
  callUIAbility() {
    const wantInfo = {
      deviceId: '', // deviceId为空表示本设备
      bundleName: 'com.example.myapplication',
      abilityName: 'SecondAbility',
      moduleName: 'entry', // moduleName非必选
      parameters: { // 自定义信息
        info: '来自EntryAbility Index页面',
      },
    }
    const context = getContext(this) as common.UIAbilityContext
    context.startAbility(wantInfo)
  }

  build() {
    Column() {
      Button('打开其他UIAbility')
        .onClick(() => {
          this.callUIAbility()
        })
    }
  }
}