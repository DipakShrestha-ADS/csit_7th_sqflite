import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sec_b_sqflite/services/sqflite_service.dart';
import 'package:sec_b_sqflite/stateManagement/bloc/todo_event.dart';
import 'package:sec_b_sqflite/stateManagement/bloc/todo_state.dart';
import 'package:sqflite/sqflite.dart' as sq;

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final sq.Database database;
  TodoBloc(this.database) : super(EmptyState()) {
    on<GetAllTodo>((event, emit) async {
      emit(LoadingState());
      try {
        final todoList = await SqfliteService().getAllTodos(
          db: database,
        );
        emit(SuccessState(todoList: todoList));
      } catch (e) {
        print('error: $e');
        emit(
          ErrorState(
            errorMsg: 'Something went wrong on getting all todos',
          ),
        );
      }
    });
  }
}
