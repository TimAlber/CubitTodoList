import 'package:cubit_todo_list/business_logic/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_todo_list/business_logic/todo_cubit.dart';
import 'package:cubit_todo_list/model/todo.dart';
import 'package:intl/intl.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        late Widget body;
        if (state.loading) {
          body = const Center(child: CircularProgressIndicator());
        } else {
          body = _getTodoLists(
            state.todos,
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Most Simple Todo List'),
          ),
          body: body,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => _addNewTodoPopupDialog(context),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
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
            onChangedTodo: (todo) => {
              setState(() {
                BlocProvider.of<TodoCubit>(context).switchFinishedness(todo);
              }),
            },
            longTapCallback: (todo) => {},
          ),
          Divider(),
          _getTodoList(
            todos: todos.where((todo) => todo.finished).toList(),
            onChangedTodo: (todo) => {
              setState(() {
                BlocProvider.of<TodoCubit>(context).switchFinishedness(todo);
              }),
            },
            longTapCallback: (todo) => {
              showDialog(
                context: context,
                builder: (_) => _getDeletePopup(context, todo),
              ),
            },
          ),
        ],
      ),
    );
  }

  Widget _getTodoList({
    required List<Todo> todos,
    required ValueChanged<Todo> onChangedTodo,
    required Function(Todo) longTapCallback,
  }) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: todos.length,
      itemBuilder: (context, index) {
        var todo = todos[index];
        return InkWell(
          onLongPress: () {
            longTapCallback(todo);
          },
          child: CheckboxListTile(
            value: todo.finished,
            onChanged: (value) {
              onChangedTodo(todo);
            },
            title: Text(
              todo.value,
              style: TextStyle(
                decoration: todo.finished
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: todo.finished
                ? Text(
                    DateFormat('dd.MM.yyyy – kk:mm').format(todo.checkedOff),
                    style: const TextStyle(
                        fontSize: 12, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.left,
                  )
                : null,
          ),
        );
      },
    );
  }

  Widget _addNewTodoPopupDialog(BuildContext context) {
    final myNewTodoTextFieldController = TextEditingController();
    return AlertDialog(
      title: const Text('Neues Todo:'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
              controller: myNewTodoTextFieldController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name des neuen Todos',
              ))
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Abbrechen'),
        ),
        TextButton(
          onPressed: () async {
            BlocProvider.of<TodoCubit>(context)
                .addTodo(myNewTodoTextFieldController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Ok'),
        )
      ],
    );
  }

  Widget _getDeletePopup(BuildContext context, Todo todo) {
    return AlertDialog(
      title: const Text('Todo Löschen?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Abbrechen'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          onPressed: () async {
            setState(() {
              BlocProvider.of<TodoCubit>(context).deleteTodo(todo);
            });
            Navigator.of(context).pop();
          },
          child: const Text('Löschen'),
        )
      ],
    );
  }
}
