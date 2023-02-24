import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:sec_b_sqflite/models/todo_model.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteService {
  static const String tableName = 'todos';
  Future<Database> establishDatabaseConnection() async {
    ///getting path of documents directory
    final docPath = await pathProvider.getApplicationDocumentsDirectory();
    print('doc path: ${docPath.path}');

    ///defining database file name
    final dbFile = 'todos.db';

    ///joining documents directory path and database file name
    final dbFilePath = path.join(docPath.path, dbFile);
    print('db file path: $dbFilePath');
    final db = await openDatabase(
      dbFilePath,
      version: 1,
      onCreate: (database, version) {
        database.execute(
          'Create Table $tableName(id Integer Primary key, task Text, done Integer, '
          'created_at Integer, updated_at Text, created_by Text, '
          'remarks Text, expire_date Text)',
        );
      },
    );
    return db;
  }

  Future<int> createTodo(TodoModel todoModel, {required Database db}) async {
    final insertedId = db.insert(tableName, todoModel.toJson());
    return insertedId;
  }

  Future<List<TodoModel>> getAllTodos({required Database db}) async {
    final todos = await db.query(tableName);
    // final todos = db.rawQuery('Select * from $tableName');
    final todoList = todos.map((e) {
      return TodoModel.fromJson(e);
    }).toList();
    return todoList;
  }

  Future<TodoModel?> getTodoWithId({required Database db, required int todoId}) async {
    final todo = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [todoId],
    );
    if (todo.isNotEmpty) {
      final requiredTodo = todo.first;
      final todoModel = TodoModel.fromJson(requiredTodo);
      return todoModel;
    }
    return null;
  }

  Future<List<TodoModel>> getTodosWithDone({required Database db, required bool done}) async {
    final todos = await db.query(
      tableName,
      where: 'done = ?',
      whereArgs: [done ? 1 : 0],
    );
    final todoList = todos.map((e) {
      return TodoModel.fromJson(e);
    }).toList();
    return todoList;
  }

  Future<int> updateTodoWithId({
    required Database db,
    required int id,
    required TodoModel todoModel,
  }) async {
    final noOfUpdatedRow = await db.update(
      tableName,
      todoModel.toJson(),
      where: 'id = ?',
      whereArgs: [id],
    );
    return noOfUpdatedRow;
  }

  Future<int> deleteTodoWithId({required Database db, required int id}) async {
    final noOfDeletedRow = await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return noOfDeletedRow;
  }
}
