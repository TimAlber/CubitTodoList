import 'package:cubit_todo_list/model/todo.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

class TodoStore {
  final String _boxName = 'todos';

  Future<List<Todo>?> getTodos() async {
    try {
      // if (!(await Hive.boxExists(_boxName))) {
      //   await _addSomeInitialElements();
      // }

      var box = await Hive.openBox(_boxName);
      var values = box.values.map((element) => element as Todo).toList();

      await box.close();
      return values;
    } catch (e) {
      Logger().e(e);
    }
    return null;
  }
}