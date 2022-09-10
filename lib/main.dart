import 'package:cubit_todo_list/business_logic/todo_cubit.dart';
import 'package:cubit_todo_list/ui/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cubit_todo_list/model/todo.dart';
//import 'package:vaira_flutter_test/ui/todo_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize hive and all necessary adapters
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(TodoAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vaira Flutter Test',
      theme: ThemeData(
        primaryColor: Colors.orange,
        primarySwatch: Colors.orange,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.orange),
        ),
      ),
      home: BlocProvider(
        create: (BuildContext context) => TodoCubit(),
        child: const TodoPage(),
      ),
    );
  }
}