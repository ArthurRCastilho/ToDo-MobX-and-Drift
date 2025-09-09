// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:to_do_list_mob_x/shared/widgets/modal_new_task.dart';

class MoreOptionsWidget extends StatelessWidget {
  const MoreOptionsWidget({super.key, required this.widget});

  final ModalNewTask widget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.viewModel.expandedMoreOptions,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Mostrar mais opções',
            style: TextStyle(
              color: widget.viewModel.moreOptions
                  ? Colors.green
                  : Colors.black,
            ),
          ),
          IconButton(
            onPressed: widget.viewModel.expandedMoreOptions,
            icon: widget.viewModel.moreOptions
                ? Icon(Icons.expand_less)
                : Icon(Icons.expand_more),
          ),
        ],
      ),
    );
  }
}
