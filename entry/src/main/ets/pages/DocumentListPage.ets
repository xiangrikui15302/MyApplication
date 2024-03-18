import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'
import { Header } from './Header'
@Entry
@Component
struct DocumentListPage {
  private index:number=1
  private context = getContext(this) as common.UIAbilityContext
  @State docs: string[] = []

  build() {
    Column({space:10}) {
      Header({title:"文档列表"})
      Button('新建文档')
        .onClick(()=>{
          this.docs.push("文档"+this.index)
          // 调整到文档编辑页面UIActivity
          // want
          let want :Want= {
            deviceId:'',
            bundleName:'com.yuzhaopan.myapplication',
            moduleName:'entry',
            abilityName:'DocumentAbility',
            parameters:{
              instanceKey:'idx_'+this.index++
            }
          }
          this.context.startAbility(want)
        })
      ForEach(
        this.docs,
        (item:string,index)=>{
          Row(){
            Text(item)
              .onClick(()=>{
                // 调整到文档编辑页面UIActivity
                // want
                let want :Want= {
                  deviceId:'',
                  bundleName:'com.yuzhaopan.myapplication',
                  moduleName:'entry',
                  abilityName:'DocumentAbility',
                  parameters:{
                    instanceKey:'idx_'+index
                  }
                }
                this.context.startAbility(want)
              })
          }.width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
        }
      )
    }
    .width('100%')
  }
}