import router from '@ohos.router'
@Component
export struct Header {
  @Prop title:string
  build() {
    Row(){
      Image($r('app.media.back_gray'))
        .width(30)
        .onClick(()=>{
          router.back()
        })
      Text(this.title)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      Image($r('app.media.refresh'))
        .width(30)

    }
    .width('100%')
    .padding(20)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}