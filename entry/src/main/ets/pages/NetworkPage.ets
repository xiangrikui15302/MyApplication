import http from '@ohos.net.http'
import url from '@ohos.url'
import axios from '@ohos/axios'
@Entry
@Component
struct NetworkPage {
  @State message: string = 'Hello World'

  aboutToAppear(){
    this.getData()
      .then((data:string[])=>{
      console.log(data.toString())
    }).catch(message=>{
      console.log(message)
    })
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }

  getData(): Promise<string[]>{
    return new Promise((resolve, reject)=>{
      let httpRequest = http.createHttp()
      httpRequest.request(
        "url",
        {
          method:http.RequestMethod.GET,
          extraData:{"param1": "value1", "param2":"value2"}
        }
      ).then((res: http.HttpResponse)=>{

        if(res.responseCode === 200){

          resolve(JSON.parse(res.result.toString()))
          console.log("返回成功")
        }else {
          reject("返回失败")
        }
      }).catch((error: Error)=>{
        console.log("返回失败")
        reject("返回失败")
      })
    })

  }


  getDataUseAxios():Promise<string[]> {
    return new Promise((resolve,reject)=>{
      axios.get(
        "url",
        {
          params:{"param1": "value1"},
          // data:{"param1": "value1"}  // post时的参数
        }
      ).then(resp=>{
        if(resp.status === 200){

          resolve(JSON.parse(resp.data.toString()))
          console.log("返回成功")
        }else {
          reject("返回失败")
        }
      }).catch(error=>{
        console.log(JSON.stringify(error))
        reject("返回失败")
      })
    })
  }
}