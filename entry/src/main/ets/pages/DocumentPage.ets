import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'
import { Header } from './Header'
@Entry
@Component
struct DocumentPage {
  private context = getContext(this) as common.UIAbilityContext
  @State title: string = '标题'
  @State isEdit: boolean = true
  @State content: string = ''

  build() {
    Row() {
      Column({space:10}) {
        Row({space:10}) {
          Image($r('app.media.back_gray'))
            .width(30)
            .onClick(()=>{
              // 跳转到文档列表的UIAbility
              let want :Want= {
                deviceId:'',
                bundleName:'com.yuzhaopan.myapplication',
                moduleName:'entry',
                abilityName:'EntryAbility',

              }
              this.context.startAbility(want)
            })
          if(!this.isEdit){
            Text(this.title)
              .fontSize(30)
              .fontWeight(FontWeight.Bold)
          } else {
            TextInput({
              placeholder:'请输入标题'
            })
              .layoutWeight(1)
            Button("确定")
              .onClick(()=>{
                this.isEdit = false

              })
          }
        }
        .justifyContent(FlexAlign.SpaceAround)
        if(!this.isEdit){
          Text(this.content)
            .fontSize(20)
        } else {
          TextInput({
            placeholder:'请输入内容'
          })
        }
      }
      .width('100%')
    }

  }
}