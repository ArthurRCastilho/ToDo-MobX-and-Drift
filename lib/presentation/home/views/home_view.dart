import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_modular/flutter_modular.dart';
import 'package:to_do_list_mob_x/presentation/home/viewmodels/home_viewmodel.dart';
import 'package:to_do_list_mob_x/shared/widgets/modal_new_task.dart';
import 'package:to_do_list_mob_x/shared/widgets/to_do_item_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _titlerController = TextEditingController();
  final TextEditingController _descriptionController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Modular.get<HomeViewModel>();
  }

  @override
  void dispose() {
    _titlerController.dispose();
    _descriptionController.dispose();
    // viewModel.dispose();
    super.dispose();
  }

  void _showAddTaskDialog() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ModalNewTask(
          viewModel: viewModel,
          formKey: _formKey,
          titleController: _titlerController,
          descriptionController: _descriptionController,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To Do List with MobX')),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Observer(
              builder: (_) {
                if (viewModel.tasks.isEmpty) {
                  return const Center(child: Text('Lista Vazia'));
                }
                return ListView.builder(
                  itemCount: viewModel.tasks.length,
                  itemBuilder: (context, index) {
                    final task = viewModel.tasks[index];
                    return ToDoItemWidget(
                      task: task,
                      onDelete: () => viewModel.removeTask(task.id),
                      onToggle: () => viewModel.toggleTaskCompleted(task),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
