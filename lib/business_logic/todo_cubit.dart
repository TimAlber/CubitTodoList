import 'package:bloc/bloc.dart';
import 'package:cubit_todo_list/business_logic/todo_state.dart';
import 'package:cubit_todo_list/model/todo.dart';
import 'package:cubit_todo_list/todo_store.dart';

class TodoCubit extends Cubit<TodoState> {

  TodoCubit() : super(const TodoState()){
    getTodos();
  }

  void getTodos() async {
    emit(
      const TodoState(),
    );

    final todos = await TodoStore().getTodos();

    if(todos != null){
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
}
