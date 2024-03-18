import { Header } from './Header'
@Entry
@Component
struct LifeCirclePage {
  @State isShow: boolean = true
  @State dataArr:string[] = []

  tag: string = "LifeCircle Page"

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
    Column({space:20}) {
      Header({title:'生命周期'})
      Button("切换显示")
        .onClick(()=>{
          this.isShow = !(this.isShow)
        })
      if(this.isShow) {
        MyText({title:"Hello World"})
      }
      Button("新增数据")
        .onClick(()=>{
          this.dataArr.push('测试数据'+ this.dataArr.length)
        })

      ForEach(
        this.dataArr,
        (item:string,index)=>{
          MyText({title:item})
            .onClick(()=>{
              console.log(""+index)
              this.dataArr.splice(index,1)
            })
        }
      )
    }
    .width('100%')
  }
}

@Component
struct MyText {
  title:string
  tag: string = "MyText"

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
    Row(){
      Text(this.title)
    }
  }
}