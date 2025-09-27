import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'add_todo_pg.dart';
import 'edit.dart';
import 'completed.dart';
import '../widgets/todo_card.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<Todo> todos = [];
  int _currentIndex = 0;

  void addTodo(Todo todo) {
    setState(() => todos.add(todo));
  }

  void editTodo(int index, Todo newTodo) {
    setState(() => todos[index] = newTodo);
  }

  void deleteTodo(int index) {
    setState(() => todos.removeAt(index));
  }

  void toggleComplete(int index) {
    setState(() => todos[index].isDone = !todos[index].isDone);
  }

  @override
  Widget build(BuildContext context) {
    final allTodos = todos;
    final completedTodos = todos.where((t) => t.isDone).toList();

    final pages = [
      _buildAllTodos(allTodos),
      CompletedPage(completedTodos: completedTodos),
    ];

    return Scaffold(
appBar: AppBar(
  backgroundColor: Theme.of(context).primaryColor,
  centerTitle: true,
  title: Text(
    _currentIndex == 0
        ? "TODO APP"
        : "Completed Tasks",
         style: TextStyle(fontFamily: "Roboto", fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
  ),
  automaticallyImplyLeading: false, // no back arrow on main tabs
),

      body: pages[_currentIndex],
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              shape: const CircleBorder(), 
              child: const Icon(Icons.add),
              onPressed: () async {
                final newTodo = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddTodoPage()),
                );
                if (newTodo != null) addTodo(newTodo);
              },
            )
          : null,
          /***************nav bar part ************/
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "All"),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: "Completed"),
        ],
      ),
    );
  }
//*****List view part********//

  Widget _buildAllTodos(List<Todo> allTodos) {
    return ListView.builder(
      itemCount: allTodos.length,
      itemBuilder: (context, index) {
        return TodoCard(
          todo: allTodos[index],
          onEdit: () async {
            final updatedTodo = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditTodoPage(todo: allTodos[index]), //_ is convention for BuildContext parameter
              ),
            );
            if (updatedTodo != null) editTodo(index, updatedTodo);
          },
          onDelete: () => deleteTodo(index),
          onToggleComplete: () => toggleComplete(index),
        );
      },
    );
  }
}
