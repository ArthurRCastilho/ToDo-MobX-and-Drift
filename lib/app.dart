import 'package:flutter/material.dart';
import 'package:to_do_list_mob_x/core/theme/app_theme.dart';
import 'package:to_do_list_mob_x/data/local/task_dao.dart';
import 'package:to_do_list_mob_x/presentation/home/views/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.taskDao});

  final TaskDao taskDao;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List with MobX',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeView(),
    );
  }
}
