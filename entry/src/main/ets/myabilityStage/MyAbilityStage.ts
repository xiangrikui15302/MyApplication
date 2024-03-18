import AbilityStage from '@ohos.app.ability.AbilityStage';
import Want from '@ohos.app.ability.Want';
export default class MyAbilityStage extends AbilityStage {
  onAcceptWant(want:Want):string {
    if(want.abilityName === 'DocumentAbility') {
      return 'DocumentAbility' + want.parameters.instanceKey
    }
    return ''
  }
  // 注：还需要去.json5设置entry的srcEntry
}