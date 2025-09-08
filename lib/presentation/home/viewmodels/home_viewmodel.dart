import 'package:mobx/mobx.dart';
import 'package:to_do_list_mob_x/data/repositories/task_repository.dart';
import 'package:to_do_list_mob_x/models/task.dart';

import 'package:uuid/uuid.dart';

part 'home_viewmodel.g.dart';

// ignore: library_private_types_in_public_api
class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  final TaskRepository _taskRepository;

  _HomeViewModelBase(this._taskRepository) {
    _loadTasks();
  }

  @observable
  ObservableList<Task> tasks = ObservableList<Task>();

  void _loadTasks() {
    _taskRepository.watchAllTasks().listen((data) {
      tasks = ObservableList.of(data);
    });
  }

  @action
  Future<void> addTask(
    String title, {
    String? description,
    DateTime? expireIn,
  }) async {
    final newTask = Task(
      id: const Uuid().v4(),
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
}
