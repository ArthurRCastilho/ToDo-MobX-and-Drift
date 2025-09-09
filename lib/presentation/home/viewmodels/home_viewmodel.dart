import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:to_do_list_mob_x/data/repositories/task_repository.dart';
import 'package:to_do_list_mob_x/models/task.dart';
import 'package:uuid/uuid.dart';

part 'home_viewmodel.g.dart';

// ignore: library_private_types_in_public_api
class HomeViewModel extends _HomeViewModelBase with _$HomeViewModel {
  HomeViewModel();
}

abstract class _HomeViewModelBase with Store {
  final TaskRepository _taskRepository = Modular.get<TaskRepository>();
  StreamSubscription<List<Task>>? _sub;

  _HomeViewModelBase() {
    _loadTasks();
  }

  @observable
  ObservableList<Task> tasks = ObservableList<Task>();

  void _loadTasks() {
    _sub = _taskRepository.watchAllTasks().listen(
      (data) {
        runInAction(() {
          tasks = ObservableList.of(data);
          // ou: tasks..clear()..addAll(data);
        });
      },
      onError: (e, st) {
        // log opcional
      },
    );
  }

  @action
  Future<void> addTask(
    String title, {
    String? description,
    DateTime? expireIn,
  }) async {
    final newTask = Task(
      id: Uuid().v4(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
      expiredIn: expireIn,
    );
    await _taskRepository.addTask(newTask);
  }

  @action
  Future<void> removeTask(String id) async {
    await _taskRepository.removeTask(id);
  }

  @action
  Future<void> toggleTaskCompleted(Task task) async {
    task.toggleCompleted();
    await _taskRepository.updateTask(task);
  }

  void dispose() {
    _sub?.cancel();
    _sub = null;
  }
}
