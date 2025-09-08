// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:to_do_list_mob_x/presentation/home/viewmodels/home_viewmodel.dart';

class ModalNewTask extends StatelessWidget {
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
  Widget build(BuildContext context) {
    DateTime? expireIn;
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
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
                        controller: titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Título é obrigatório';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Titulo da Task',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Descrição
                Row(
                  spacing: 8,
                  children: [
                    Icon(Icons.description),
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        minLines: 3,
                        controller: descriptionController,
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
                          final DateTime? picked = await showDatePicker(
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
                            hintText: "Selecionar validade (opcional)",
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
                        icon: const Icon(Icons.clear, color: Colors.red),
                        onPressed: () {
                          setModalState(() {
                            expireIn = null;
                          });
                        },
                      ),
                  ],
                ),

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
                    if (formKey.currentState!.validate()) {
                      viewModel.addTask(
                        titleController.text,
                        description: descriptionController.text.isEmpty
                            ? null
                            : descriptionController.text,
                        expireIn: expireIn,
                      );
                      titleController.clear();
                      descriptionController.clear();
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
