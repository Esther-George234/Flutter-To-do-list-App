import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleComplete;
  final bool showButtons; // show/hide flag

  const TodoCard({
    super.key,
    required this.todo,
    this.onEdit,
    this.onDelete,
    this.onToggleComplete,
    this.showButtons = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          todo.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,  //strike the task
          ),
        ),
        subtitle: Text(todo.detail),
        trailing: showButtons
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: onToggleComplete,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.teal, width: 2),
                      ),
                      child: todo.isDone
                          ? const Icon(Icons.check, color: Colors.teal, size: 14)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (onEdit != null)
                    IconButton(icon: const Icon(Icons.edit, color: Colors.teal), onPressed: onEdit),
                  if (onDelete != null)
                    IconButton(icon: const Icon(Icons.delete, color: Colors.teal), onPressed: onDelete),
                ],
              )
            : null,
      ),
    );
  }
}

