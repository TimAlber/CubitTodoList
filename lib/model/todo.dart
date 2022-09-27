import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String uid;

  @HiveField(1)
  String value;

  @HiveField(2)
  bool finished;

  @HiveField(3)
  DateTime checkedOff;

  Todo({
    required this.uid,
    required this.value,
    required this.finished,
    required this.checkedOff,
  });
}
