import {IndexFontPanel} from '../views/IndexFontPanel'
import router from '@ohos.router'
import preferenceTool from '../common/PreferenceTool'
import common from '@ohos.app.ability.common'
class RouterInfo{
  name:string
  url:string
  constructor(name:string,url:string) {
    this.name = name
    this.url = url
  }
}


@Entry
@Component
struct Index {

  @Provide fontSize:number = 20

  @State isShowSetting:boolean = false

  private context = getContext(this) as common.UIAbilityContext
  prefercesName:string = 'test'

  routers:RouterInfo[] = [
    new RouterInfo('图片展示页面','pages/ImageModule'),
    new RouterInfo('任务列表页面','pages/StateManager'),
    new RouterInfo('动画','pages/AnimationPage'),
    new RouterInfo('生命周期','pages/LifeCirclePage'),
    new RouterInfo('生命周期','pages/LifeCirclePage2'),
    new RouterInfo('UIAbility启动模式案例','pages/DocumentListPage'),
    new RouterInfo('网络加载','pages/NetworkPage'),
    new RouterInfo('通知','pages/NotificationPage')
  ]

  tag: string = "Index Page"

  async aboutToAppear(){
    this.fontSize = await preferenceTool
      .getPreferenceValue(this.context, this.prefercesName, "fontSize", 20) as number
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
      Column({space:10}) {
        Row(){
          Row(){
            Text('页面列表')
              .fontSize(30)
              .fontWeight(FontWeight.Bold)
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          Image($r('app.media.setting'))
            .width(40)
            .onClick(()=>{
              animateTo({ duration:1000 },
                ()=>{
                  this.isShowSetting = !this.isShowSetting
                })

            })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('90%')

        List({space:10}){
          ForEach(
            this.routers,
            (item:RouterInfo,index)=>{
              ListItem(){
                RouterItem({index:index,item:item})
                  .onClick(()=>{
                    router.pushUrl({
                      url:item.url,
                      params:{title:item.name}
                    })
                  })
              }
            }
          )
        }
        .alignListItem(ListItemAlign.Center)
        if (this.isShowSetting) {

          IndexFontPanel()
            .transition({
              translate:{y:215}
            })
        }

      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .padding({top:30})


  }
}


@Component
struct RouterItem {
  @Consume fontSize:number
  index:number
  item:RouterInfo
  build() {
    Row(){
      Text(''+ (this.index+1))
        .fontColor(Color.White)
      Blank()
      Text(this.item.name)
        .fontSize(this.fontSize)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#36D')
    .width('90%')
    .padding(10)
    .borderRadius(10)
  }
}