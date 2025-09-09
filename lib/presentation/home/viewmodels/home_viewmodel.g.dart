// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  late final _$moreOptionsAtom = Atom(
    name: '_HomeViewModelBase.moreOptions',
    context: context,
  );

  @override
  bool get moreOptions {
    _$moreOptionsAtom.reportRead();
    return super.moreOptions;
  }

  @override
  set moreOptions(bool value) {
    _$moreOptionsAtom.reportWrite(value, super.moreOptions, () {
      super.moreOptions = value;
    });
  }

  late final _$tasksAtom = Atom(
    name: '_HomeViewModelBase.tasks',
    context: context,
  );

  @override
  ObservableList<Task> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<Task> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$addTaskAsyncAction = AsyncAction(
    '_HomeViewModelBase.addTask',
    context: context,
  );

  @override
  Future<void> addTask(
    String title, {
    String? description,
    DateTime? expireIn,
  }) {
    return _$addTaskAsyncAction.run(
      () => super.addTask(title, description: description, expireIn: expireIn),
    );
  }

  late final _$removeTaskAsyncAction = AsyncAction(
    '_HomeViewModelBase.removeTask',
    context: context,
  );

  @override
  Future<void> removeTask(String id) {
    return _$removeTaskAsyncAction.run(() => super.removeTask(id));
  }

  late final _$toggleTaskCompletedAsyncAction = AsyncAction(
    '_HomeViewModelBase.toggleTaskCompleted',
    context: context,
  );

  @override
  Future<void> toggleTaskCompleted(Task task) {
    return _$toggleTaskCompletedAsyncAction.run(
      () => super.toggleTaskCompleted(task),
    );
  }

  late final _$_HomeViewModelBaseActionController = ActionController(
    name: '_HomeViewModelBase',
    context: context,
  );

  @override
  void expandedMoreOptions() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
      name: '_HomeViewModelBase.expandedMoreOptions',
    );
    try {
      return super.expandedMoreOptions();
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
moreOptions: ${moreOptions},
tasks: ${tasks}
    ''';
  }
}
