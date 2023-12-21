// @Component
// export struct GraphComponent {
//   build() {
//     Column({ space: 10 }) {
//       Text('basic').fontSize(24).fontColor(0xCCCCCC).width(300)
//       // 在Shape的(-2, -2)点绘制一个 300 * 50 带边框的矩形,颜色0x317AF7,边框颜色黑色,边框宽度4,边框间隙20,向左偏移10,线条两端样式为半圆,拐角样式圆角,抗锯齿(默认开启)
//       // 在Shape的(-2, 58)点绘制一个 300 * 50 带边框的椭圆,颜色0x317AF7,边框颜色黑色,边框宽度4,边框间隙20,向左偏移10,线条两端样式为半圆,拐角样式圆角,抗锯齿(默认开启)
//       // 在Shape的(-2, 118)点绘制一个 300 * 10 直线路径,颜色0x317AF7,边框颜色黑色,宽度4,间隙20,向左偏移10,线条两端样式为半圆,拐角样式圆角,抗锯齿(默认开启)
//       Shape() {
//         Rect().width(300).height(50)
//         Ellipse().width(300).height(50).offset({ x: 0, y: 60 })
//         Path().width(300).height(10).commands('M0 0 L900 0').offset({ x: 0, y: 120 })
//       }
//       .viewPort({ x: -2, y: -2, width: 304, height: 130 })
//       .fill(0x317AF7)
//       .stroke(Color.Black)
//       .strokeWidth(4)
//       .strokeDashArray([20])
//       .strokeDashOffset(10)
//       .strokeLineCap(LineCapStyle.Round)
//       .strokeLineJoin(LineJoinStyle.Round)
//       .antiAlias(true)
//       // 分别在Shape的(0, 0)、(-5, -5)点绘制一个 300 * 50 带边框的矩形,可以看出之所以将视口的起始位置坐标设为负值是因为绘制的起点默认为线宽的中点位置，因此要让边框完全显示则需要让视口偏移半个线宽
//       Shape() {
//         Rect().width(300).height(50)
//       }
//       .viewPort({ x: 0, y: 0, width: 320, height: 70 })
//       .fill(0x317AF7)
//       .stroke(Color.Black)
//       .strokeWidth(10)
//
//       Shape() {
//         Rect().width(300).height(50)
//       }
//       .viewPort({ x: -5, y: -5, width: 320, height: 70 })
//       .fill(0x317AF7)
//       .stroke(Color.Black)
//       .strokeWidth(10)
//
//       Text('path').fontSize(11).fontColor(0xCCCCCC).width(320)
//       // 在Shape的(0, -5)点绘制一条直线路径,颜色0xEE8443,线条宽度10,线条间隙20
//       Shape() {
//         Path().width(300).height(10).commands('M0 0 L900 0')
//       }
//       .viewPort({ x: 0, y: -5, width: 300, height: 20 })
//       .stroke(0xEE8443)
//       .strokeWidth(10)
//       .strokeDashArray([20])
//       // 在Shape的(0, -5)点绘制一条直线路径,颜色0xEE8443,线条宽度10,线条间隙20,向左偏移10
//       Shape() {
//         Path().width(300).height(10).commands('M0 0 L900 0')
//       }
//       .viewPort({ x: 0, y: -5, width: 300, height: 20 })
//       .stroke(0xEE8443)
//       .strokeWidth(10)
//       .strokeDashArray([20])
//       .strokeDashOffset(10)
//       // 在Shape的(0, -5)点绘制一条直线路径,颜色0xEE8443,线条宽度10,透明度0.5
//       Shape() {
//         Path().width(300).height(10).commands('M0 0 L900 0')
//       }
//       .viewPort({ x: 0, y: -5, width: 300, height: 20 })
//       .stroke(0xEE8443)
//       .strokeWidth(10)
//       .strokeOpacity(0.5)
//       // 在Shape的(0, -5)点绘制一条直线路径,颜色0xEE8443,线条宽度10,线条间隙20,线条两端样式为半圆
//       Shape() {
//         Path().width(300).height(10).commands('M0 0 L900 0')
//       }
//       .viewPort({ x: 0, y: -5, width: 300, height: 20 })
//       .stroke(0xEE8443)
//       .strokeWidth(10)
//       .strokeDashArray([20])
//       .strokeLineCap(LineCapStyle.Round)
//       // 在Shape的(-80, -5)点绘制一个封闭路径,颜色0x317AF7,线条宽度10,边框颜色0xEE8443,拐角样式锐角（默认值）
//       Shape() {
//         Path().width(200).height(60).commands('M0 0 L400 0 L400 150 Z')
//       }
//       .viewPort({ x: -80, y: -5, width: 310, height: 90 })
//       .fill(0x317AF7)
//       .stroke(0xEE8443)
//       .strokeWidth(10)
//       .strokeLineJoin(LineJoinStyle.Miter)
//       .strokeMiterLimit(5)
//     }.width('100%').margin({ top: 15 })
//   }
// }

@Component
export struct GraphComponent {
  // 用来配置CanvasRenderingContext2D对象的参数，包括是否开启抗锯齿，true表明开启抗锯齿。
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  // 用来创建CanvasRenderingContext2D对象，通过在canvas中调用CanvasRenderingContext2D对象来绘制。
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  // 引入图片
  private img:ImageBitmap = new ImageBitmap("imgs/1.png")

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      // 在canvas中调用CanvasRenderingContext2D对象。
      Canvas(this.context)
        .width('100%')
        .height('100%')
        // .backgroundColor('#F5DC62')
        // Canvas 组件初始化完成
        .onReady(() => {
          // 获取 Canvas 组件的宽度
          const width = this.context.width
          // 可以在这里绘制内容
          //绘制填充类文本
          this.context.font = '100px sans-serif';
          this.context.fillText("Hello World!", 50, 100);
          //绘制描边类文本
          this.context.font = '100px sans-serif';
          this.context.strokeText("Hello World!", 50, 150);
          // 绘制矩形
          this.context.beginPath();
          this.context.rect((width - 100) / 2, 200, 100, 50);
          this.context.stroke();
          // 绘制圆形
          this.context.beginPath();
          this.context.arc(150, 350, 50, 0, 6.28);
          this.context.stroke();
          // 绘制图片
          this.context.drawImage(this.img, (width - 100) / 2, 450, 100, 100)
        })
    }
    .width('100%')
    .height('100%')
  }
}