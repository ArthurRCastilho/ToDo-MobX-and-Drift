import 'package:drift/drift.dart';
import 'app_database_local.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabaseLocal>
    with _$TaskDaoMixin {
  final AppDatabaseLocal db;

  TaskDao(this.db) : super(db);

  Future<List<TaskTable>> getAllTasks() => select(tasks).get();
  Stream<List<TaskTable>> watchAllTasks() => select(tasks).watch();

  Future<void> insertTask(TasksCompanion task) => into(tasks).insert(task);

  Future<void> updateTask(TaskTable task) => update(tasks).replace(task);

  Future<void> deleteTask(String id) =>
      (delete(tasks)..where((tbl) => tbl.id.equals(id))).go();
}
