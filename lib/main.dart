import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      home: ToDoApp(),
    );
  }
}

class ToDo {
  String title;
  bool isDone;

  ToDo({
    required this.title,
    this.isDone = false,
  });
}

class ToDoApp extends StatefulWidget {
  @override
  _ToDoAppState createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  List<ToDo> _todos = [];
  final TextEditingController _todoController = TextEditingController();

  // Adding a new ToDo
  void _addToDo(String task) {
    setState(() {
      _todos.add(ToDo(title: task));
    });
    _todoController.clear(); // Clear input field after adding
  }

  // Toggle the task as complete or incomplete
  void _toggleComplete(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  // Delete a task
  void _deleteToDo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 221, 221),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232, 221, 221),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: tdBlack,
              size: 30,
            ),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset("assets/bg.png")),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search and Add Section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        prefixIcon: Icon(
                          Icons.search,
                          color: tdBlack,
                          size: 20,
                        ),
                        border: InputBorder.none,
                        hintText: "Search or add new task",
                        hintStyle: TextStyle(color: tdGary),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: tdBlack),
                    onPressed: () {
                      if (_todoController.text.isNotEmpty) {
                        _addToDo(_todoController.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          // ToDo List Section
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: todo.isDone
                        ? const Color.fromARGB(
                            255, 200, 230, 201) // Green for completed tasks
                        : const Color.fromARGB(
                            255, 255, 255, 255), // White for pending tasks
                    leading: Checkbox(
                      value: todo.isDone,
                      onChanged: (bool? value) {
                        _toggleComplete(index);
                      },
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        fontSize: 18,
                        decoration: todo.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: tdRed),
                      onPressed: () => _deleteToDo(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
