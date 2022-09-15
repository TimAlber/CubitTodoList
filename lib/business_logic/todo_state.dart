import 'package:equatable/equatable.dart';

import '../model/todo.dart';

class TodoState extends Equatable {
  final String? error;
  final bool loading;
  final List<Todo> todos;

  const TodoState({
    this.error,
    this.loading = true,
    this.todos = const <Todo>[],
  });

  @override
  List<Object?> get props => [
    error,
    loading,
    todos,
  ];


}
