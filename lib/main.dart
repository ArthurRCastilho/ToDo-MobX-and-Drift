import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_mob_x/app.dart';
import 'package:to_do_list_mob_x/data/local/app_database_local.dart';
import 'package:to_do_list_mob_x/data/local/task_dao.dart';
import 'package:to_do_list_mob_x/data/repositories/task_repository.dart';
import 'package:to_do_list_mob_x/presentation/home/viewmodels/home_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabaseLocal();
  final taskDao = TaskDao(db);
  final repository = TaskRepository(taskDao);

  runApp(
    Provider<HomeViewModel>(
      create: (_) => HomeViewModel(repository),
      child: MyApp(taskDao: taskDao),
    ),
  );
}
