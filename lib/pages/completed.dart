import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/todo_card.dart';

class CompletedPage extends StatelessWidget {
  final List<Todo> completedTodos;

  const CompletedPage({super.key, required this.completedTodos});

  @override
  Widget build(BuildContext context) {
    return completedTodos.isEmpty
        ? const Center(child: Text("No completed tasks"))
        : ListView.builder(
            itemCount: completedTodos.length,
            itemBuilder: (context, index) {
              return TodoCard(
                    todo: completedTodos[index],
                    showButtons: false, // hide buttons here
                );

            },
          );
  }
}
