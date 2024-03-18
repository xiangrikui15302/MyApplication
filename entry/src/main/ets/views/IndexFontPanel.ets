import {PreferenceTool} from '../common/PreferenceTool'
import preferenceTool from '../common/PreferenceTool'
import common from '@ohos.app.ability.common'
@Component
export struct IndexFontPanel {
  private context = getContext(this) as common.UIAbilityContext
  @Consume fontSize:number
  fontSizeLabel:object = {
    20:'小',
    25:'标准',
    30:'大',
    35:'更大',
    40:'特大'
  }
  font
  build() {
    Column() {
      Text(this.fontSizeLabel[this.fontSize])
        .fontSize(20)
        .width('100%')
        .textAlign(TextAlign.Center)
      Row({space:10}){
        Text("A")
          .fontSize(20)
        Slider({
          value:this.fontSize,
          min:20,
          max:40,
          step:5
        })
          .layoutWeight(1)
          .onChange((val:number)=>{
            this.fontSize = val
            this.updateFontSize(val)
          })
        Text("A")
          .fontSize(40)
      }
      .width('90%')
    }
    .width('100%')

  }

  async updateFontSize(val:number){
    try {
      await preferenceTool.putPreferenceValue(this.context,"test","fontSize",val)
    }catch (err){

    }
  }

}