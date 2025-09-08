import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database_local.g.dart';

@DataClassName('TaskTable')
class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get expireIn => dateTime().nullable()();
  BoolColumn get completed =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Tasks])
class AppDatabaseLocal extends _$AppDatabaseLocal {
  AppDatabaseLocal() : super(driftDatabase(name: "tasks_db"));

  @override
  int get schemaVersion => 1;
}
