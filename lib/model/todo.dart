// class todo {
//   String? id;
//   String? todotext;
//   bool isdone;
//   todo({
//     required this.id,
//     required this.todotext,
//     this.isdone = false,
//   });
//   static List<todo> todolist() {
//     return [
//       todo(id: '1', todotext: 'welcome to TODOS'),
//     ];
//   }
// }
import 'package:floor/floor.dart';

@Entity(tableName: 'todos')
class todo {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'todotext')
  String? todotext;

  @ColumnInfo(name: 'isdone')
  bool? isdone;

  void toggleIsDone() {
    isdone = !isdone!;
  }

  todo({this.id, required this.todotext, this.isdone = false});
}
