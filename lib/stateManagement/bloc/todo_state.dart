import 'package:equatable/equatable.dart';
import 'package:sec_b_sqflite/models/todo_model.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmptyState extends TodoState {}

class LoadingState extends TodoState {}

class ErrorState extends TodoState {
  final String errorMsg;
  ErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

class SuccessState extends TodoState {
  final List<TodoModel> todoList;
  SuccessState({required this.todoList});

  @override
  List<Object?> get props => [todoList];
}
