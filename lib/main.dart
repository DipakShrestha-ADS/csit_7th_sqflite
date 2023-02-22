import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:sec_b_sqflite/screens/home_page.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite/sqlite_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///getting path of documents directory
  final docPath = await pathProvider.getApplicationDocumentsDirectory();
  print('doc path: ${docPath.path}');

  ///defining database file name
  final dbFile = 'todos.db';

  ///joining documents directory path and database file name
  final dbFilePath = path.join(docPath.path, dbFile);
  print('db file path: $dbFilePath');
  final db = await sqflite.openDatabase(
    dbFilePath,
    version: 1,
    onCreate: (database, version) {
      database.execute(
        'Create Table todos(id Integer Primary key, task Text, done int, '
        'created_at int, updated_at Text, created_by Text, '
        'remarks Text, expire_date Text)',
      );
    },
  );
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sqflite',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(
        db: db,
      ),
    );
  }
}
