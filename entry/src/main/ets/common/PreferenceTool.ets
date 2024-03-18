import preferences from '@ohos.data.preferences';
export class PreferenceTool {
   prefMap:Map<string,preferences.Preferences> = new Map()
   async loadPreference(context,name:string){

     try {
       let pref = await preferences.getPreferences(context,name)
       this.prefMap.set(name,pref)
     }catch (err) {
       console.log(JSON.stringify(err))
     }
   }

   async putPreferenceValue(context,name:string,key:string,value:preferences.ValueType) {
     try {
       if (!this.prefMap.has(name)) {
         await this.loadPreference(context, name)
       }
       let prep = this.prefMap.get(name)
       await prep.put(key, value)
       await prep.flush()
     } catch (err){
       console.log(JSON.stringify(err))
     }
   }

   async getPreferenceValue(context,name:string,key:string,defaultValue:preferences.ValueType) {
     try {
       if (!this.prefMap.has(name)) {
         await this.loadPreference(context, name)
       }
       let prep = this.prefMap.get(name)
       return await prep.get(key,defaultValue)
     } catch (err){
       console.log(JSON.stringify(err))
     }
   }

}
const preferenceTool = new PreferenceTool()
export default preferenceTool as PreferenceTool