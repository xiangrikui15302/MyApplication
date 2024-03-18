import relationalStore from '@ohos.data.relationalStore';
import {Task} from '../viewmodel/Task'
class TaskModel{

  private rdbStore:relationalStore.RdbStore
  private tableName:string = 'TASK'
  /**
   * 初始化任务列表
   */
  initTaskDB(context){
  // rdb配置
    const config = {
      name:"myApplication.db",
      securityLevel:relationalStore.SecurityLevel.S1
    }
    // SQL
    const sql = "CREATE TABLE IF NOT EXISTS TASK (" +
    "ID INTEGER PRIMARY KEY AUTOINCREMENT," +
    "NAME TEXT NOT NULL," +
    "FINISHED BIT)"
    // 获取rdb
    relationalStore.getRdbStore(context, config, (err,rdbStore)=>{
      if(err){
        console.log('taskTest','getRdbStore error')
        return
      }
      rdbStore.executeSql(sql)
      this.rdbStore = rdbStore
      console.log('taskTest','getRdbStore success')
    })
  }

  /**
   * 查询任务列表
   */
  async getTaskList(context){
    // 构建查询条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    var resultArr :Task[] = []

    try {
      let  result = await this.rdbStore.query(predicates,['ID','NAME','FINISHED'])
      // 解析查询结果
      while (!result.isAtLastRow) {
        result.goToNextRow()
        var id = result.getLong(result.getColumnIndex('ID'))
        var name = result.getString(result.getColumnIndex('NAME'))
        var finished = result.getLong(result.getColumnIndex('FINISHED'))
        resultArr.push({
          taskId:id,
          name,
          isFinish:!!finished
        })

      }
      console.log('taskTest','getTaskList success')

    }catch (err){
      console.log('taskTest','getTaskList error:'+JSON.stringify(err))
    }

    return resultArr
  }

  /**
   * 添加一个新的任务
   * @param name 任务名称
   */
  addTask(name:string) :Promise<number>{
    return this.rdbStore.insert(this.tableName,{name,finished:false})
  }

  /**
   * 根据id更新任务状态
   * @param id 任务id
   * @param finished  任务状态
   */
  updateTaskState(id:number,finished:boolean): Promise<number>{
    // 构建条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo("ID",id)
    return this.rdbStore.update({finished},predicates)

  }

  /**
   * 根据id删除任务
   * @param id
   */
  deleteTask(id:number): Promise<number> {
    // 构建条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo("ID",id)
    return this.rdbStore.delete(predicates)
  }

}

const taskModel = new TaskModel()
export default taskModel as TaskModel