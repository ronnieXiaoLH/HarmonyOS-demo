import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';

let storage = new LocalStorage({ num: 100 })

let _windowStage: null | window.WindowStage = null
let subWindowClass: null | window.Window = null

// 创建子窗口
export function showSubWindow() {
  // 1. 创建应用子窗口
  _windowStage.createSubWindow('mySubWindow', async (err, data) => {
    if (err.code) {
      console.error('Failed to create the subwindow. Cause: ' + JSON.stringify(err));
      return;
    }
    subWindowClass = data
    // 设置子窗口的位置、大小等属性
    try {
      await subWindowClass.moveWindowTo(300, 300)
      await subWindowClass.resize(500, 500)
    } catch (err) {
      return console.error(JSON.stringify(err));
    }
    // 3. 设置子窗口加载的目标页面
    subWindowClass.setUIContent('pages/SubWindow', (err) => {
      if (err.code) {
        console.error('Failed to load the content. Cause:' + JSON.stringify(err));
        return;
      }
      // 4. 显示子窗口
      subWindowClass.showWindow((err) => {
        if (err.code) {
          console.error('Failed to show the window. Cause: ' + JSON.stringify(err));
          return;
        }
        console.info('Succeeded in showing the window.');
      })
    })
  })
}

// 销毁子窗口
export function destroySubWindow() {
  subWindowClass.destroyWindow((err) => {
    if (err.code) {
      console.error('Failed to destroy the window. Cause: ' + JSON.stringify(err));
      return;
    }
    console.info('Succeeded in destroying the window.');
  })
}

export default class EntryAbility extends UIAbility {
  public storage: LocalStorage = storage

  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    _windowStage = windowStage
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // 获取应用主窗口
    let windowClass: null | window.Window = null;
    windowStage.getMainWindow((err, data: window.Window) => {
      if (err.code) {
        console.error('Failed to obtain the main window. Cause: ' + JSON.stringify(err));
        return;
      }
      windowClass = data
      // 设置状态栏、导航栏是否显示
      // windowClass.setWindowSystemBarEnable(['status', 'navigation'])
    })

    // 设置主窗口加载的目标页面
    windowStage.loadContent('pages/Index', this.storage)
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
