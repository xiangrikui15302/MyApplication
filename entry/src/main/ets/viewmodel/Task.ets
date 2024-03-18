@Observed
export class Task{
  taskId:number
  name:string
  isFinish:boolean = false

  constructor(taskId:number) {
    this.taskId = taskId
    this.name = '任务' + taskId
  }
}

@Observed
export class StaticInfo{
  finishCount:number
  totalCount:number

  constructor(finishCount:number,totalCount:number) {
    this.totalCount = totalCount
    this.finishCount = finishCount
  }
}