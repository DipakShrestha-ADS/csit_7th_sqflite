import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sec_b_sqflite/stateManagement/bloc/todo_bloc.dart';
import 'package:sec_b_sqflite/stateManagement/bloc/todo_state.dart';
import 'package:sqflite/sqflite.dart';

class ViewTodoScreen extends StatefulWidget {
  const ViewTodoScreen({Key? key, required this.db}) : super(key: key);
  final Database db;
  @override
  State<ViewTodoScreen> createState() => _ViewTodoScreenState();
}

class _ViewTodoScreenState extends State<ViewTodoScreen> {
  @override
  void initState() {
    // context.read<TodoBloc>().add(GetAllTodo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('view tood build function called');
    return BlocBuilder<TodoBloc, TodoState>(
      // future: SqfliteService().getAllTodos(db: widget.db),
      builder: (ctx, todoState) {
        print('todo bloc builder called');
        if (todoState is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurpleAccent,
            ),
          );
        }
        if (todoState is ErrorState) {
          return Center(
            child: Text(
              '${todoState.errorMsg}',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          );
        }
        if (todoState is SuccessState) {
          final data = todoState.todoList;
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
