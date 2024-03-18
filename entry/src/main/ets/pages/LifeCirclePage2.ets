import { Header } from './Header'
@Entry
@Component
struct LifeCirclePage2 {
  @State message: string = 'Hello World'

  tag: string = "LifeCircle Page2"

  aboutToAppear(){
    console.log(this.tag,'aboutToAppear')
  }

  onPageShow(){
    console.log(this.tag,'onPageShow')
  }

  onPageHide(){
    console.log(this.tag,'onPageHide')
  }

  onBackPress(){
    console.log(this.tag,'onBackPress')
  }

  aboutToDisappear(){
    console.log(this.tag,'aboutToDisappear')
  }

  build() {
    Row() {
      Column() {
        Header({title:"生命周期2"})
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }

  }
}