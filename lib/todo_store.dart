import 'package:cubit_todo_list/model/todo.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

class TodoStore {
  final String _boxName = 'todos';

  Future<List<Todo>?> getTodos() async {
    try {
      var box = await Hive.openBox(_boxName);
      var values = box.values.map((element) => element as Todo).toList();

      await box.close();
      return values;
    } catch (e) {
      Logger().e(e);
    }
    return null;
  }

  Future<bool> addTodo(Todo newTodo) async {
    try {
      var box = await Hive.openBox(_boxName);
      box.add(newTodo);
      await box.close();
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  Future<bool> saveSwitchedTodo(Todo myTodo) async {
    try {
      var box = await Hive.openBox('todos');
      if (myTodo.isInBox) {
        box.put(
          myTodo.key,
          Todo(
              uid: myTodo.uid,
              finished: myTodo.finished,
              value: myTodo.value,
              checkedOff: myTodo.checkedOff),
        );
      }
      await box.close();
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  Future<bool> deleteTodo(myTodo) async {
    try {
      var box = await Hive.openBox('todos');
      if (myTodo.isInBox) {
        box.delete(myTodo.key);
      }
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }
}
