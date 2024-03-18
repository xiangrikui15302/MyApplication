import router from '@ohos.router'
import {Header} from '../pages/Header'

@Entry
@Component
struct Index {
  @State imageWidth: number = 150
  build() {
    Column() {
      Header({title:router.getParams()['title']})
      Column(){
        Image($r('app.media.icon'))
          .width(this.imageWidth)
        Row(){
          Text(this.imageWidth.toFixed())
            .fontSize(50)
            .fontWeight(FontWeight.Bold)
            .fontColor("#360")
            .onClick(()=>{
              this.imageWidth=300
            })
          TextInput({text:this.imageWidth.toFixed()})
            .backgroundColor('#360')
            .width(160)
            .fontColor('#FFF')
        }.justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
        .padding({left:14,right:14})
        .margin({left:15,right:15})

        Row(){
          Button("缩小")
            .fontSize(20)
            .onClick(()=>{
              if (this.imageWidth>=10) {
                this.imageWidth -= 10
              }
            })
          Button("放大")
            .fontSize(20)
            .onClick(()=>{
              if (this.imageWidth<=30) {
                this.imageWidth += 10
              }
            })
        }.width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({left:15,right:15})

        Slider({
          min:0,
          max:300
        })
          .blockColor('#360')
          .trackThickness(5)
          .selectedColor('#360')
          .trackColor('#eee')
          .width('90%')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      }

  }
}