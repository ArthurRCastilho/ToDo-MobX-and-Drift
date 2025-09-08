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
    i.addLazySingleton<AppDatabaseLocal>(() => AppDatabaseLocal());
    i.addLazySingleton<TaskDao>((i) => TaskDao(i.get<AppDatabaseLocal>()));
    i.addLazySingleton<TaskRepository>(
      (i) => TaskRepository(i.get<TaskDao>()),
    );

    i.addLazySingleton<HomeViewModel>(
      (i) => HomeViewModel(i.get<TaskRepository>()),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) {
        try {
          // final repository = Modular.get<TaskRepository>();
          // final viewModel = HomeViewModel(repository);
          // return HomeView(viewModel: viewModel);

          // TODO!: Resolver problema de inicialização de app
          final db = AppDatabaseLocal();
          final dao = TaskDao(db);
          final repo = TaskRepository(dao);
          final vm = HomeViewModel(repo);
          return HomeView(viewModel: vm);
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
