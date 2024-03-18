
import notificationManager from '@ohos.notificationManager'
import promptAction from '@ohos.promptAction'

enum DownloadState {
  NOT_BEGIN = '未开始',
  DOWNLOADING = '下载中',
  PAUSE = '已暂停',
  FINISHED = '已完成',
}


@Component
export struct DownloadCard {
  isSupportDownload: boolean = false
  // 任务状态
  @State state: DownloadState = DownloadState.NOT_BEGIN

  @State progressValue: number = 0
  private maxProgressValue: number = 100

  private taskId:number = -1
  private notificationId: number = 1100

  aboutToAppear() {
    this.isSupportTemp()
  }

  build() {
    Row({space:10}){
      Image($r('app.media.icon'))
        .width(60)
      Column({space:8}){
        Row(){
          Text('海浪.mp3')
          Text(`${ this.progressValue }%`)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        Progress({
          value:this.progressValue,
          total:this.maxProgressValue
        })
        Row(){
          Text(this.progressValue + 'MB')
          Blank()
          if (this.state === DownloadState.NOT_BEGIN) {
            Button('开始').downloadButton()
              .onClick(() => this.download())

          } else if (this.state === DownloadState.DOWNLOADING) {
            Button('取消').downloadButton().backgroundColor('#d1d2d3')
              .onClick(() => this.cancel())

            Button('暂停').downloadButton()
              .onClick(() => this.pause())

          } else if (this.state === DownloadState.PAUSE) {
            Button('取消').downloadButton().backgroundColor('#d1d2d3')
              .onClick(() => this.cancel())

            Button('继续').downloadButton()
              .onClick(() => this.download())
          } else {
            Button('打开').downloadButton()
              .onClick(() => this.open())
          }
        }
        .width('100%')

      }
      .layoutWeight(1)
    }
    .height(100)
    .width('100%')
    .padding(10)
    .alignItems(VerticalAlign.Center)
  }

  isSupportTemp(){

    notificationManager.isSupportTemplate('downloadTemplate')
      .then(value => {
        this.isSupportDownload = value
      })
      .catch(error => {
        console.log("isSupportTemplate出错了")
      })
  }

  download(){
    // 开始定时器发送通知
    this.taskId = setInterval(()=>{
      if(this.progressValue>=this.maxProgressValue) {
        clearInterval(this.taskId)
        this.taskId = -1
        this.state = DownloadState.FINISHED
        this.publicRequest()
        return
      }
      this.progressValue += 5
      this.publicRequest()
    },1000)
    this.state = DownloadState.DOWNLOADING

  }

  cancel(){
    if(this.taskId != -1) {
      clearInterval(this.taskId)
      this.taskId = -1
    }
    this.progressValue = 0

    this.state = DownloadState.NOT_BEGIN
    notificationManager.cancel(this.notificationId)
  }

  pause(){
    if(this.taskId != -1) {
      clearInterval(this.taskId)
      this.taskId = -1
    }
    this.publicRequest()
    this.state = DownloadState.PAUSE
  }

  open(){

  }

  publicRequest(){
    if(!this.isSupportDownload){
      promptAction.showToast({
        message:'当前系统不支持进度条模板',
        duration:2000,//默认1500
        bottom:'100'
      })
      return
    }
    // 2.准备进度条模板的参数
    let template = {
      name: 'downloadTemplate',
      data: {
        progressValue: this.progressValue,
        progressMaxValue: this.maxProgressValue
      }
    }
    let request:notificationManager.NotificationRequest = {
      id:this.notificationId,
      template:template,
      content: {
        contentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title:'通知标题',
          text:'通知内容',
        }
      }
    }
    notificationManager.publish(request)
      .then(()=>{
        console.log("发送成功")
      })
      .catch(error=> {
        console.log("publish失败")
      })
  }
}

@Extend(Button) function downloadButton(){
  .fontColor(Color.White)
}