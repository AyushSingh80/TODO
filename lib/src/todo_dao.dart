import 'package:floor/floor.dart';
import 'package:todo/model/todo.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM todos')
  Future<List<todo>> getAllTodos();

  @Query('SELECT * FROM todos WHERE id = :id')
  Future<todo?> getTodoById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTodo(todo tod);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateTodo(todo tod);

  @delete
  Future<void> deleteTodo(todo tod);
}
