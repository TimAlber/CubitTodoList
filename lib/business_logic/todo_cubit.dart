import 'package:bloc/bloc.dart';
import 'package:cubit_todo_list/business_logic/todo_state.dart';
import 'package:cubit_todo_list/model/todo.dart';
import 'package:cubit_todo_list/todo_store.dart';
import 'package:uuid/uuid.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoState()) {
    getTodos();
  }

  void getTodos() async {
    emit(
      const TodoState(),
    );

    final todos = await TodoStore().getTodos();

    if (todos != null) {
      emit(
        TodoState(
          todos: todos,
          loading: false,
          error: null,
        ),
      );
    } else {
      emit(
        const TodoState(
          todos: <Todo>[],
          loading: false,
          error: 'no-todos-found',
        ),
      );
    }
  }

  // void addTodo(String newTodoName) async {
  //   emit(
  //     const TodoState(),
  //   );
  //   final theTodo = Todo(
  //     uid: const Uuid().v4(),
  //     value: newTodoName,
  //     finished: false,
  //     checkedOff: DateTime.now(),
  //   );
  //
  //   final worked = await TodoStore().addTodo(theTodo);
  //
  //   if(worked){
  //     emit(
  //       TodoState(
  //         todos: state.todos,
  //         loading: false,
  //         error: null,
  //       ),
  //     );
  //   } else {
  //     emit(
  //       TodoState(
  //         todos: state.todos,
  //         loading: false,
  //         error: 'adding-todo-failed',
  //       ),
  //     );
  //   }
  // }
}
