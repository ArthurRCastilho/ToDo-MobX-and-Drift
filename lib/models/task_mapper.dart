import 'package:drift/drift.dart';
import 'package:to_do_list_mob_x/data/local/app_database_local.dart';
import 'package:to_do_list_mob_x/models/task.dart';

extension TaskTableMapper on TaskTable {
  Task toDomain() {
    return Task(
      id: id,
      title: title,
      description: description,
      createdAt: createdAt,
      expiredIn: expireIn,
      completed: completed,
    );
  }
}

extension TaskMapper on Task {
  TasksCompanion toCompanion() {
    return TasksCompanion.insert(
      id: id,
      title: title,
      description: Value(description),
      createdAt: Value(createdAt),
      expireIn: Value(expiredIn),
      completed: Value(completed),
    );
  }
}
