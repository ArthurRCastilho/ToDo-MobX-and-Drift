import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:to_do_list_mob_x/data/local/app_database_local.dart';
import 'package:to_do_list_mob_x/data/local/task_dao.dart';
import 'package:to_do_list_mob_x/data/repositories/task_repository.dart';
import 'package:to_do_list_mob_x/presentation/home/viewmodels/home_viewmodel.dart';
import 'package:to_do_list_mob_x/presentation/home/views/home_view.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(AppDatabaseLocal.new);
    i.addLazySingleton(TaskDao.new);

    i.addLazySingleton(TaskRepository.new);

    i.addLazySingleton(HomeViewModel.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) {
        try {
          return HomeView();
        } catch (e, st) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Text('FALHA MANUAL\n$e\n$st'),
            ),
          );
        }
      },
    );
  }
}
