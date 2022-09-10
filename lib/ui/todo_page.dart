import 'package:cubit_todo_list/business_logic/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_todo_list/business_logic/todo_cubit.dart';
import 'package:cubit_todo_list/model/todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joels TODO Liste'),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return _getTodoLists(
            state.todos,
          );
        },
      ),
    );
  }

  Widget _getTodoLists(
      List<Todo> todos,
      ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _getTodoList(
            todos: todos.where((todo) => !todo.finished).toList(),
            onChanged: (value) => {
              setState(() {
                //switchFinishedness(todo);
              }),
            },
          ),
          Divider(),
          _getTodoList(
            todos: todos.where((todo) => todo.finished).toList(),
            onChanged: (value) => {
              setState(() {
                //switchFinishedness(todo);
              }),
            },
          ),
        ],
      ),
    );
  }

  Widget _getTodoList({
    required List<Todo> todos,
    required ValueChanged<bool?>? onChanged,
  }) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: todos.length,
      itemBuilder: (context, index) {
        var todo = todos[index];
        return CheckboxListTile(
          value: todo.finished,
          onChanged: onChanged,
          title: Text(
            todo.value,
            style: TextStyle(
              decoration: todo.finished
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
        );
      },
    );
  }
}