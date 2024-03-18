import { Header } from './Header'
import {DownloadCard} from '../views/DownloadCard'
import notificationManager from '@ohos.notificationManager'
import image from '@ohos.multimedia.image'
import systemDateTime from '@ohos.systemDateTime'
import { WantAgent } from '@ohos.wantAgent'
import wantAgent from '@ohos.app.ability.wantAgent'
@Entry
@Component
struct NotificationPage {
  @State message: string = 'Hello World'
  wantAgentInstance: WantAgent
  build() {
    Row(){
      Column({space:10}) {
        Header({title:"通知功能"})
        Button('发送nomalTest通知')
          .fontSize(20)
          .onClick(()=>{
            this.publicNormalTextNotification()
          })
        Button('发送longTest通知')
          .fontSize(20)
          .onClick(()=>{
            this.publicLongTextNotification()
          })
        Button('发送multiLine通知')
          .fontSize(20)
          .onClick(()=>{
            this.publiMultiLineNotification()
          })
        Button('发送Picture通知')
          .fontSize(20)
          .onClick(()=>{
            this.publicPictureNotification()
          })
        DownloadCard()
          .backgroundColor(Color.White)
          .margin(10)
          .borderRadius(10)
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor("#CCC")
    .alignItems(VerticalAlign.Top)
  }

  getWantInfo():Promise<WantAgent> {
    let wantInfo :wantAgent.WantAgentInfo = {
      wants: [
        {
          bundleName:'com.yuzhaopan.myapplication',
          abilityName:'Entry'
        }
      ],
      requestCode: 0,
      operationType: wantAgent.OperationType.START_ABILITY,
      wantAgentFlags: [wantAgent.WantAgentFlags.CONSTANT_FLAG]
    }
    return wantAgent.getWantAgent(wantInfo)
  }

  async publicNormalTextNotification(){
    await this.getWantInfo()
      .then(wantAgentInstance=>{
      let request : notificationManager.NotificationRequest = {
        id:0,
        showDeliveryTime: true,
        deliveryTime: new Date().getTime(),// 通知发送的时间
        slotType: notificationManager.SlotType.SOCIAL_COMMUNICATION,
        wantAgent:wantAgentInstance,
        content:{
          contentType:notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title:'通知标题',
            text: "通知的内容",
            additionalText: '通知附加内容'
          }
        }
      }
      this.publishRequest(request)
    })

  }

  publicLongTextNotification(){
    let request: notificationManager.NotificationRequest = {
      id: 1,
      content: {
        contentType:notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
        longText: {
          title:'通知标题',
          text:'通知内容详情',
          longText:'通知中的长文本，我很长，我很长，我很长',
          additionalText:'通知附加内容',
          briefText: '通知概要和总结',
          expandedTitle:'通知展开时的标题'
        }
      }
    }
    this.publishRequest(request)
  }

  publiMultiLineNotification(){
    let request: notificationManager.NotificationRequest = {
      id: 2,
      content: {
        contentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
        multiLine: {
          title:'通知标题',
          text:'通知内容',
          briefText:'通知概要和总结',
          additionalText:'附加内容',
          longTitle:'展开时的标题',
          lines:[
            '第一行',
            '第二行',
            '第三行']
        }
      }
    }
    this.publishRequest(request)

  }

  async getImagePixl():Promise<PixelMap>{
    let rm = getContext(this).resourceManager
    let file = await rm.getMediaContent($r('app.media.icon'))
    return image.createImageSource(file.buffer).createPixelMap()

  }

  async publicPictureNotification(){

    await this.getImagePixl()
    .then(value => {
      let request:notificationManager.NotificationRequest = {
        id:3,
        content: {
          contentType: notificationManager.ContentType.NOTIFICATION_CONTENT_PICTURE,
          picture: {
            title:'',
            text:'',
            additionalText:'',
            briefText:'',
            expandedTitle:'',
            picture:value
          }
        }
      }
      this.publishRequest(request)
    })
      .catch(error => {
    })
  }

  publishRequest(request: notificationManager.NotificationRequest){
    notificationManager.publish(request,this.publishCallback)
  }

  //publish回调
  publishCallback(err) {
    if (err) {
      console.info("publish failed " + JSON.stringify(err));
    } else {
      console.info("publish success");
    }
  }
}