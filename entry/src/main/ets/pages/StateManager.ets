// import {TaskItem} from "../pages/TaskItem"
import {StaticInfo, Task} from '../viewmodel/Task'
import {Header} from '../pages/Header'
import router from '@ohos.router'
import taskModel from '../model/TaskModel'
import common from '@ohos.app.ability.common'

@Styles function cardStyle(){
  .width('90%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({radius:6,color:'#1f000000',offsetX:2,offsetY:4})
}

@Extend(Text) function finishedTask(){
  .fontColor('#B1B2B1')
  .decoration({type:TextDecorationType.LineThrough})
}

@Component
struct staticPage {
  @Link staticInfo:StaticInfo
  build() {
    Row(){
      Text('任务进度')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      Stack(){
        Progress({
          value:this.staticInfo.finishCount,
          total:this.staticInfo.totalCount,
          type:ProgressType.Ring
        })
          .width(120)
        Row(){
          Text(this.staticInfo.finishCount.toFixed())
            .fontSize(30)
          Text(' / '+this.staticInfo.totalCount.toFixed())
            .fontSize(30)
        }
      }

    }
    .cardStyle()
    .height(150)
    .margin({top:20})
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct  TaskList{
  // @Link tasks:Array<Task>
  @Link staticInfo : StaticInfo
  @Consume tasks:Array<Task>

  build() {
    Column({space:10}){
      Button('新增任务')
        .fontSize(20)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .onClick(()=>{
          let task = new Task(this.tasks.length)
          this.tasks.push(task)
          taskModel.addTask(task.name)
          this.handleTaskChange()
        })
        .width(180)
        .padding(10)
      List({space:10}){
        ForEach(
          this.tasks,
          (item:Task,index)=>{
            ListItem(){

              TaskListItem({item:item,handleTask:this.handleTaskChange.bind(this)})
            }
            .swipeAction({end:this.DeleteAction(index)})
          }
        )
      }
      .alignListItem(ListItemAlign.Center)
    }

  }

  @Builder DeleteAction(index:number) {
    Text('删除')
      .onClick(()=>{
        console.log('index:'+index)
        taskModel.deleteTask(this.tasks[index].taskId)
        this.tasks.splice(index,1)
        this.handleTaskChange()
      })
      .margin(10)
  }

  handleTaskChange(){
    this.staticInfo.totalCount = this.tasks.length
    this.staticInfo.finishCount = this.tasks.filter(task =>
    task.isFinish == true
    ).length
  }
}


@Component
struct  TaskListItem{
  @ObjectLink item:Task
  handleTask:()=>void
  build() {
    Row(){
      if(this.item.isFinish) {
        Text(this.item.name)
          .decoration({type:TextDecorationType.LineThrough})
          .fontColor('#ccc')
      } else {
        Text(this.item.name)
      }
      Checkbox()
        .select(this.item.isFinish)
        .onChange(val=>{
          this.item.isFinish = val
          taskModel.updateTaskState(this.item.taskId,val)
          this.handleTask()
        })
    }
    .cardStyle()
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Entry
@Component
struct statePage {
  //
  @State staticInfo :StaticInfo = new StaticInfo(0,0)
  @Provide tasks:Array<Task> = []

  aboutToAppear(){
     // taskModel.initTaskDB(getContext(this) as common.UIAbilityContext)
    taskModel.getTaskList(getContext(this) as common.UIAbilityContext)
      .then(tasks=>{
        this.tasks = tasks
        this.handleTaskChange()
      })
      .catch(error=>{
        console.log('taskTest','getTaskList error')
      })

  }
  build() {
    Column({space:10}){
      Header({title:router.getParams()['title']})
      staticPage({staticInfo:$staticInfo})

      TaskList({staticInfo:$staticInfo})
        .layoutWeight(1)
        .width('100%')

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')
  }

  handleTaskChange(){
    let finishCount = this.tasks.filter(task =>
      task.isFinish == true
    ).length
    this.staticInfo = new StaticInfo(finishCount,this.tasks.length)
  }

}