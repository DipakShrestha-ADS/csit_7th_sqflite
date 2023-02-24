import 'package:flutter/material.dart';
import 'package:sec_b_sqflite/services/sqflite_service.dart';
import 'package:sqflite/sqflite.dart';

class ViewTodoScreen extends StatefulWidget {
  const ViewTodoScreen({Key? key, required this.db}) : super(key: key);
  final Database db;
  @override
  State<ViewTodoScreen> createState() => _ViewTodoScreenState();
}

class _ViewTodoScreenState extends State<ViewTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SqfliteService().getAllTodos(db: widget.db),
      builder: (ctx, dataSnap) {
        if (dataSnap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurpleAccent,
            ),
          );
        }
        if (dataSnap.hasError) {
          return Center(
            child: Text(
              '${dataSnap.error}',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          );
        }
        if (dataSnap.hasData) {
          final data = dataSnap.data;
          if (data != null) {
            return ListView.separated(
              itemCount: data.length,
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 20,
                );
              },
              itemBuilder: (ctx, index) {
                final todo = data[index];
                print('todd: ${todo.done}');
                return Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: Text(
                      '${todo.id ?? 'N/A'}',
                    ),
                    trailing: Checkbox(
                      value: todo.done,
                      onChanged: (val) {},
                    ),
                    title: Text(
                      '${todo.task} [${todo.createdBy}]',
                    ),
                    subtitle: Text(
                      '${todo.expireDate} \n${todo.remarks.join(' | ')}',
                    ),
                  ),
                );
              },
            );
          }
        }
        return const Center(
          child: Text(
            'No Data!',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }
}
