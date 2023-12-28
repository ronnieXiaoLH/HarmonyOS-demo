import window from '@ohos.window';
import { showSubWindow, destroySubWindow } from '../entryability/EntryAbility'

@Component
export struct WindowManagementComponent {
  private windowClass: null | window.Window = null

  // 展示悬浮窗
  showFloatWindow() {
    let config = {
      name: 'floatWindow', windowType: window.WindowType.TYPE_FLOAT, ctx: getContext(this)
    }
    // 1. 创建悬浮窗
    window.createWindow(config, async (err, data: window.Window) => {
      if (err.code) {
        console.error('Failed to create the floatWindow. Cause: ' + JSON.stringify(err));
        return;
      }
      console.info('Succeeded in creating the floatWindow. Data: ' + JSON.stringify(data));
      this.windowClass = data;
      // 2. 设置悬浮窗位置、大小等属性
      try {
        await this.windowClass.moveWindowTo(300, 300)
        await this.windowClass.resize(200, 200)
      } catch (err) {
        return console.error(JSON.stringify(err));
      }

      // 3. 设置悬浮窗加载的目标页面
      this.windowClass.setUIContent('pages/FloatWindow', (err) => {
        if (err.code) {
          console.error('Failed to load the content. Cause:' + JSON.stringify(err));
          return;
        }
        // 4. 显示悬浮窗
        this.windowClass.showWindow((err) => {
          if (err.code) {
            console.error('Failed to show the window. Cause: ' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in showing the window.');
        })
      })
    })
  }

  // 隐藏悬浮窗
  destroyFloatWindow() {
    this.windowClass.destroyWindow((err) => {
      if (err.code) {
        console.error('Failed to destroy the window. Cause: ' + JSON.stringify(err));
        return;
      }
      console.info('Succeeded in destroying the window.');
    });
  }

  build() {
    Column({ space: 10 }) {
      Button('创建子窗口')
        .onClick(() => {
          console.log('create subWindow')
          showSubWindow()
        })
      Button('销毁子窗口')
        .onClick(() => {
          console.log('destroy subWindow')
          destroySubWindow()
        })
      Button('创建悬浮窗')
        .onClick(() => {
          console.log('create floatWindow')
          this.showFloatWindow()
        })
      Button('销毁悬浮窗')
        .onClick(() => {
          console.log('destroy floatWindow')
          this.destroyFloatWindow()
        })
    }
  }
}