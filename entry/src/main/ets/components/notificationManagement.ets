import NotificationManager from '@ohos.notificationManager';
import image from '@ohos.multimedia.image';
import wantAgent from '@ohos.app.ability.wantAgent';

function generateId(): number {
  return Math.random() * 10000 | 0
}

@Component
export struct NotificationManagement {
  build() {
    Tabs() {
      TabContent() {
        BasicNotification()
      }
      .tabBar('基础类型')

      TabContent() {
        ProgressNotification()
      }
      .tabBar('进度条')

      TabContent() {
        GroupNotification()
      }
      .tabBar('通知组')

      TabContent() {
        ActionNotification()
      }
      .tabBar('行为')
    }
  }
}

@Component
struct BasicNotification {
  private idList: number[] = []

  async normalText(): Promise<void> {
    try {
      console.log('normal text notification')
      const id = generateId()
      this.idList.push(id)
      const notificationRequest = {
        id,
        content: {
          contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT, // 普通文本类型通知
          normal: {
            title: '普本文本通知标题',
            text: '通知内容',
            additionalText: '附加信息',
          }
        }
      }
      await NotificationManager.publish(notificationRequest)
    } catch (err) {
      console.error(`normal text notification [ANS] failed to publish, error[${err}]`);
      return;
    }
    console.log(`normal text notification [ANS] publish success`);
  }

  async longText(): Promise<void> {
    try {
      console.log('long text notification')
      const id = generateId()
      this.idList.push(id)
      const notificationRequest = {
        id,
        content: {
          contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT, // 普通文本类型通知
          longText: {
            title: '长文本通知标题',
            text: '通知内容',
            additionalText: '附加信息',
            longText: '展开后通知内容',
            briefText: '内容概要',
            expandedTitle: '展开后标题',
          }
        }
      }
      await NotificationManager.publish(notificationRequest)
    } catch (err) {
      console.error(`long text notification [ANS] failed to publish, error[${err}]`);
      return;
    }
    console.log(`long text notification [ANS] publish success`);
  }

  async multilineText(): Promise<void> {
    try {
      console.log('multilineText text notification')
      const id = generateId()
      this.idList.push(id)
      const notificationRequest = {
        id,
        content: {
          contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE, // 普通文本类型通知
          multiLine: {
            title: '多行文本通知标题',
            text: '通知内容',
            longText: '展开后通知内容',
            briefText: '内容概要',
            longTitle: '展开后标题',
            lines: ['第一行内容', '第二行内容', '第三行内容']
          }
        }
      }
      await NotificationManager.publish(notificationRequest)
    } catch (err) {
      console.error(`multilineText text notification [ANS] failed to publish, error[${err}]`);
      return;
    }
    console.log(`multilineText text notification [ANS] publish success`);
  }

  async pictureNotification(): Promise<void> {
    try {
      console.log('picture notification')
      // 构造图片
      const resourceManager = getContext(this).resourceManager
      const imageArr = await resourceManager.getMediaContent($r('app.media.1').id)
      const imageResource = image.createImageSource(imageArr.buffer)
      const pixelMap = await imageResource.createPixelMap()
      const id = generateId()
      this.idList.push(id)
      const notificationRequest = {
        id,
        content: {
          contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_PICTURE, // 普通文本类型通知
          picture: {
            title: '图片类型通知标题',
            text: '通知内容',
            additionalText: '附加信息',
            picture: pixelMap,
            briefText: '内容概要',
            expandedTitle: '展开后标题',
          }
        }
      }
      await NotificationManager.publish(notificationRequest)
    } catch (err) {
      console.error(`picture notification [ANS] failed to publish, error[${err}]`);
      return;
    }
    console.log(`picture notification [ANS] publish success`);
  }

  cancelNotification(id: number): void {
    id && NotificationManager.cancel(id)
  }

  cancelAllNotification(): void {
    NotificationManager.cancelAll()
  }

  build() {
    Column({ space: 10 }) {
      Button('普通文本通知')
        .onClick(() => {
          this.normalText()
        })
      Button('长文本通知')
        .onClick(() => {
          this.longText()
        })
      Button('多行文本通知')
        .onClick(() => {
          this.multilineText()
        })
      Button('图片类型通知')
        .onClick(() => {
          this.pictureNotification()
        })
      Button('取消最早一个通知')
        .onClick(() => {
          const id = this.idList.shift()
          this.cancelNotification(id)
        })
      Button('取消所有通知')
        .onClick(this.cancelAllNotification)
    }
  }
}

@Component
struct ProgressNotification {
  async handleProgressNotification(): Promise<void> {
    try {
      // 判断是否支持某种类型的模板类通知
      const res = await NotificationManager.isSupportTemplate('downloadTemplate')
      if (!res) {
        return
      }

      let template = {
        name: 'downloadTemplate',
        data: {
          title: '标题：',
          fileName: 'music.mp4',
          progressValue: 30,
          progressMaxValue: 100,
        }
      }
      //构造 NotificationRequest对象
      let notificationRequest = {
        id: 1,
        slotType: NotificationManager.SlotType.OTHER_TYPES,
        template: template,
        content: {
          contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: template.data.title + template.data.fileName,
            text: "sendTemplate",
            additionalText: "30%"
          }
        },
        deliveryTime: new Date().getTime(),
        showDeliveryTime: true
      }
      await NotificationManager.publish(notificationRequest)
    } catch (err) {
      console.error(`[ANS] failed to publish, error[${err}]`)
    }
    console.info(`[ANS] publish success`)
  }

  initNotificationRequest(progressValue): NotificationManager.NotificationRequest {
    let template = {
      name: 'downloadTemplate',
      data: {
        title: '文件下载',
        fileName: 'music.mp4',
        progressValue,
        progressMaxValue: 100,
      }
    }
    //构造 NotificationRequest对象
    let notificationRequest = {
      id: 2,
      slotType: NotificationManager.SlotType.OTHER_TYPES,
      template: template,
      content: {
        contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: template.data.title + template.data.fileName,
          text: "sendTemplate",
          additionalText: `${progressValue}%`
        }
      },
      deliveryTime: new Date().getTime(),
      showDeliveryTime: true
    }
    return notificationRequest
  }

  async imitateProgressNotification(): Promise<void> {
    try {
      // 判断是否支持某种类型的模板类通知
      const res = await NotificationManager.isSupportTemplate('downloadTemplate')
      if (!res) {
        return
      }
      let progressValue = 0
      let timer = setInterval(async () => {
        if (progressValue >= 100) {
          clearInterval(timer)
        }
        const notificationRequest = this.initNotificationRequest(progressValue)
        await NotificationManager.publish(notificationRequest)
        progressValue += Math.random() * 10 | 0
        progressValue = Math.min(100, progressValue)
      }, 1000)
    } catch (err) {
      console.error(`[ANS] failed to publish, error[${err}]`)
    }
    console.info(`[ANS] publish success`)
  }

  build() {
    Column({ space: 10 }) {
      Button('进度条通知')
        .onClick(() => {
          this.handleProgressNotification()
        })
      Button('模拟完整的进度条通知')
        .onClick(() => {
          this.imitateProgressNotification()
        })
    }
  }
}

@Component
struct GroupNotification {
  async sendGroupNotification(): Promise<void> {
    try {
      console.log('group notification')
      const notificationRequest: NotificationManager.NotificationRequest = {
        id: generateId(),
        groupName: 'group',
        content: {
          contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT, // 普通文本类型通知
          normal: {
            title: '张三',
            text: '晚上一起吃饭呀'
          }
        }
      }
      await NotificationManager.publish(notificationRequest)
      const notificationRequest2: NotificationManager.NotificationRequest = {
        id: generateId(),
        groupName: 'group',
        content: {
          contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE, // 普通文本类型通知
          multiLine: {
            title: '李四',
            text: '好啊！',
            longTitle: '在叫上其他人一起吧！',
            briefText: '',
            lines: ['王五', '小六']
          }
        }
      }
      await NotificationManager.publish(notificationRequest2)
      const notificationRequest3: NotificationManager.NotificationRequest = {
        id: generateId(),
        groupName: 'group',
        content: {
          contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT, // 普通文本类型通知
          normal: {
            title: '王五',
            text: '好的'
          }
        }
      }
      await NotificationManager.publish(notificationRequest3)
    } catch (err) {
      console.error(`group notification [ANS] failed to publish, error[${err}]`);
      return;
    }
    console.log(`group notification [ANS] publish success`);
  }

  build() {
    Column() {
      Button('发送一组通知')
        .onClick(this.sendGroupNotification)
      Button('行为意图')
        .onClick(this.sendGroupNotification)
    }
  }
}

@Component
struct ActionNotification {
  async handleActionNotification(): Promise<void> {
    try {
      console.log('action notification')
      const wantAgentInfo = {
        wants: [
          {
            bundleName: "com.example.myapplication",
            abilityName: "SecondAbility"
          }
        ],
        operationType: wantAgent.OperationType.START_ABILITY,
        requestCode: 100
      }
      const wantAgentObj = await wantAgent.getWantAgent(wantAgentInfo)
      const notificationRequest: NotificationManager.NotificationRequest = {
        id: generateId(),
        slotType: NotificationManager.SlotType.SOCIAL_COMMUNICATION,
        content: {
          contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT, // 普通文本类型通知
          normal: {
            title: '通知标题',
            text: '请拉起其他UIAbility'
          }
        },
        actionButtons: [
          {
            title: '拉起UIAbility',
            wantAgent: wantAgentObj
          }
        ]
      }
      await NotificationManager.publish(notificationRequest)
    } catch (err) {
      console.error(`action notification [ANS] failed to publish, error[${err}]`);
      return;
    }
    console.log(`action notification [ANS] publish success`);
  }

  build() {
    Column() {
      Button('拉起其他UIAbility的通知')
        .onClick(() => {
          this.handleActionNotification()
        })
    }
  }
}