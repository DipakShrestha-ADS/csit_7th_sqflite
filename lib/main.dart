import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sec_b_sqflite/screens/home_page.dart';
import 'package:sec_b_sqflite/services/sqflite_service.dart';
import 'package:sec_b_sqflite/stateManagement/bloc/cubit/counter_cubit.dart';
import 'package:sec_b_sqflite/stateManagement/bloc/todo_bloc.dart';
import 'package:sqflite/sqlite_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await SqfliteService().establishDatabaseConnection();
  print('db open: ${db.isOpen}');
  runApp(MyApp(
    db: db,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.db});
  final Database db;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => TodoBloc(db),
        ),
        BlocProvider(
          create: (ctx) => CounterCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sqflite',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: HomePage(
          db: db,
        ),
      ),
    );
  }
}
