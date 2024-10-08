import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'todo_dao.dart';
import 'package:todo/model/todo.dart';
part 'todo_database.g.dart';

@Database(version: 1, entities: [todo])
abstract class TodoDatabase extends FloorDatabase {
  TodoDao get todoDao;
}
