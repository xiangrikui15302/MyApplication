import { Header } from './Header'
@Entry
@Component
struct AnimationPage {
  build() {
    Column({space:50}){
      Header({title:"动画"})
      // 属性动画
      PropAnimation()
      // 显式动画
      ToAnimation()
      // 转场动画
      TransitionAnimation()
    }

  }
}

@Component
struct PropAnimation {

  @State rotateAngle: number = 0
  build() {
    Column() {
      Button('点我开始属性动画')
        .onClick(()=>{
          this.rotateAngle = this.rotateAngle == 0 ? 360:0

        })
      Text('Hello World')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .rotate({
          angle:this.rotateAngle,
          centerX:'50%',
          centerY:'50%'
        })
        .animation({
          duration:1000,
          curve:Curve.EaseInOut
        })

    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}


@Component
struct ToAnimation {
  @State positionY:number = 0
  build() {
    Column({space:20}){
      Divider()
        .width("90%")
      Button('点我开始显式动画')
        .backgroundColor(Color.Orange)
        .onClick(()=>{
          animateTo(
            { duration:500 },
            ()=>{
              this.positionY = 50
            })

        })
      Text('我是显式动画')
        .margin({top:this.positionY})
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
    }
  }
}

@Component
struct TransitionAnimation {
  @State isShow:boolean = false
  build() {
    Column({space:20}){
      Divider()
        .width("90%")
      Button('点我开始转场动画')
        .backgroundColor(Color.Orange)
        .onClick(()=>{
          animateTo({ duration:1000 },
            ()=>{
              this.isShow = true
            })

        })
      if(this.isShow){
        Text('我是转场动画')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .transition({
            opacity:0,
            rotate:{
              angle:90,
              centerX:'50%',
              centerY:'50'
            }
          })
      }

    }
  }
}