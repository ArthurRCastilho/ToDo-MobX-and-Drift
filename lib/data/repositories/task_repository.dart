import 'package:to_do_list_mob_x/data/local/app_database_local.dart';
import 'package:to_do_list_mob_x/data/local/task_dao.dart';
import 'package:to_do_list_mob_x/models/task.dart';
import 'package:to_do_list_mob_x/models/task_mapper.dart';

class TaskRepository {
  final TaskDao _taskDao;

  TaskRepository(this._taskDao);

  Stream<List<Task>> watchAllTasks() {
    return _taskDao.watchAllTasks().map((taskTableList) {
      return taskTableList
          .map((taskTable) => taskTable.toDomain())
          .toList();
    });
  }

  Future<void> addTask(Task task) {
    return _taskDao.insertTask(task.toCompanion());
  }

  Future<void> removeTask(String id) {
    return _taskDao.deleteTask(id);
  }

  Future<void> updateTask(Task task) {
    // Para atualizar, o Drift precisa do objeto de dados completo (TaskTable)
    // Então, primeiro convertemos para Companion e depois para o objeto de dados.
    final taskTable = TaskTable(
      id: task.id,
      title: task.title,
      description: task.description,
      createdAt: task.createdAt,
      expireIn: task.expiredIn,
      completed: task.completed,
    );
    return _taskDao.updateTask(taskTable);
  }
}
