import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/model/todo.dart';

class TodoItems extends StatelessWidget {
  final todo todos;
  final onToDochange;
  final onDeleteItem;
  const TodoItems({
    super.key,
    required this.todos,
    required this.onToDochange,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDochange(todos);
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: const Color.fromARGB(211, 226, 216, 216),
        leading: Icon(
          (todos.isdone ?? false)
              ? Icons.check_box
              : Icons.check_box_outline_blank,
          color: listItemColor,
        ),
        title: Text(
          todos.todotext!,
          style: TextStyle(
            fontSize: 19,
            color: textColor,
            decoration:
                (todos.isdone ?? false) ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 20,
            onPressed: () {
              onDeleteItem(todos);
            },
            icon: const Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
