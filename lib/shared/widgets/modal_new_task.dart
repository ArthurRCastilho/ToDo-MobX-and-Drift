// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:to_do_list_mob_x/presentation/home/viewmodels/home_viewmodel.dart';
import 'package:to_do_list_mob_x/shared/widgets/more_options_widget.dart';

class ModalNewTask extends StatefulWidget {
  const ModalNewTask({
    super.key,
    required this.viewModel,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
  });

  final HomeViewModel viewModel;
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  State<ModalNewTask> createState() => _ModalNewTaskState();
}

class _ModalNewTaskState extends State<ModalNewTask> {
  @override
  Widget build(BuildContext context) {
    DateTime? expireIn;
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                SizedBox(height: 8),

                // Titulo
                Text(
                  'Criar nova Task',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  spacing: 8,
                  children: [
                    Icon(Icons.title),
                    Expanded(
                      child: TextFormField(
                        controller: widget.titleController,
                        validator: widget.viewModel.titleValidator,
                        decoration: InputDecoration(
                          hintText: 'Titulo da Task',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                Observer(
                  builder: (_) {
                    return AnimatedCrossFade(
                      duration: Duration(milliseconds: 500),
                      crossFadeState: widget.viewModel.moreOptions
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      secondChild: MoreOptionsWidget(widget: widget),
                      firstChild: Column(
                        children: [
                          MoreOptionsWidget(widget: widget),
                          SizedBox(height: 8),

                          Row(
                            spacing: 8,
                            children: [
                              Icon(Icons.description),
                              Expanded(
                                child: TextField(
                                  maxLines: null,
                                  minLines: 3,
                                  controller: widget.descriptionController,
                                  decoration: InputDecoration(
                                    hintText: 'Descrição da Task',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),

                          // Data
                          Row(
                            children: [
                              const Icon(Icons.calendar_today),
                              const SizedBox(width: 8),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    final DateTime? picked =
                                        await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100),
                                        );
                                    if (picked != null) {
                                      setModalState(() {
                                        expireIn = picked;
                                      });
                                    }
                                  },
                                  child: InputDecorator(
                                    decoration: const InputDecoration(
                                      hintText:
                                          "Selecionar validade (opcional)",
                                      border: UnderlineInputBorder(),
                                    ),
                                    child: Text(
                                      expireIn == null
                                          ? "Nenhuma data escolhida"
                                          : "${expireIn!.day}/${expireIn!.month}/${expireIn!.year}",
                                    ),
                                  ),
                                ),
                              ),
                              if (expireIn != null)
                                IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setModalState(() {
                                      expireIn = null;
                                    });
                                  },
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // Descrição
                SizedBox(height: 32),

                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Criar nova Task',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    if (widget.formKey.currentState!.validate()) {
                      widget.viewModel.addTask(
                        widget.titleController.text,
                        description:
                            widget.descriptionController.text.isEmpty
                            ? null
                            : widget.descriptionController.text,
                        expireIn: expireIn,
                      );
                      widget.titleController.clear();
                      widget.descriptionController.clear();
                      expireIn = null;
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
