import 'package:flutter/material.dart';
import 'todo_database.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/widgets/todo_items.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TodoDatabase _database;
  List<todo> _todos = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDatabase();
    _loadTodos();
  }

  Future<void> _initDatabase() async {
    // Assuming FloorTodoDatabase is the name of your generated class
    _database =
        await $FloorTodoDatabase.databaseBuilder('todo_database.db').build();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await _database.todoDao.getAllTodos();
    setState(() {
      _todos = todos;
    });
  }

  Future<void> _addToDoItem(String text) async {
    final tod = todo(todotext: text, isdone: false);
    await _database.todoDao.insertTodo(tod);
    _loadTodos();
  }

  Future<void> _handletoDochange(todo todo) async {
    todo.toggleIsDone();

    await _database.todoDao.updateTodo(todo);
    _loadTodos();
  }

  Future<void> _deleteToDoItem(todo tod) async {
    await _database.todoDao.deleteTodo(tod);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196F3),
        scaffoldBackgroundColor:
            const Color(0xFFFFFFFF), // Customize the theme color
        fontFamily: 'Roboto', // Use a consistent font
      ),
      home: Scaffold(
        appBar: AppBar(
          title:
              const Text('TODO', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Image.asset('assets/images/image.png'),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              // Allow list to take up available space
              child: Container(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                  itemCount: _todos.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(_todos[index].id.toString()),
                      onDismissed: (direction) {
                        _deleteToDoItem(_todos[index]);
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: TodoItems(
                        // Assuming TodoItems is your custom widget
                        todos: _todos[index],
                        onToDochange: _handletoDochange,
                        onDeleteItem: _deleteToDoItem,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Add new todo',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_todoController.text.isEmpty) {
                        return;
                      }
                      _addToDoItem(_todoController.text);
                      _todoController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
