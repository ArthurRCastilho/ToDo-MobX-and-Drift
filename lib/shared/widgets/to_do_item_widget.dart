import 'package:flutter/material.dart';
import 'package:to_do_list_mob_x/models/task.dart';

class ToDoItemWidget extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const ToDoItemWidget({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: Checkbox(
          activeColor: Colors.green,
          checkColor: Colors.black,
          value: task.completed,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.completed ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        children: [
          // Descrição
          if (task.description != null)
            Row(
              children: [
                const Icon(Icons.description, size: 18),
                const SizedBox(width: 8),
                Expanded(child: Text(task.description!)),
              ],
            ),

          const SizedBox(height: 4),

          // Data de criação
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 18),
              const SizedBox(width: 8),
              Text(
                "Criada em: ${task.createdAt.day}/${task.createdAt.month}/${task.createdAt.year}",
              ),
            ],
          ),

          const SizedBox(height: 4),

          // Vencimento
          if (task.expiredIn != null) ...[
            const SizedBox(width: 16),
            Row(
              children: [
                const Icon(Icons.event, size: 18),
                const SizedBox(width: 8),
                Text(
                  "Vence em: ${task.expiredIn!.day}/${task.expiredIn!.month}/${task.expiredIn!.year}",
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
