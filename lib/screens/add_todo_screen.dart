import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sec_b_sqflite/models/todo_model.dart';
import 'package:sec_b_sqflite/services/sqflite_service.dart';
import 'package:sec_b_sqflite/widgets/todo_form.dart';
import 'package:sqflite/sqflite.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key, required this.db}) : super(key: key);
  final Database db;

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController createdByController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final TextEditingController expireDateController = TextEditingController();
  bool done = false;
  DateTime? pickedDateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Your Todo',
        ),
      ),
      body: TodoForm(
        formKey: formKey,
        taskController: taskController,
        createdByController: createdByController,
        remarksController: remarksController,
        expireDateController: expireDateController,
        done: done,
        onDone: (val) {
          done = val ?? false;
          setState(() {});
        },
        onTapExpireDate: () async {
          print('expire date clicked');
          /*final dateTime = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2080),
          );*/
          final dateTime = await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: SizedBox(
                  height: 250,
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (dateTime) {
                      print('date time: $dateTime');
                      pickedDateTime = dateTime;
                      print('picked date time: $pickedDateTime');
                    },
                    mode: CupertinoDatePickerMode.date,
                  ),
                ),
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context, pickedDateTime);
                    },
                    child: const Text(
                      'Ok',
                    ),
                  ),
                ],
              );
            },
          );
          print('expire date: $dateTime');
          if (dateTime != null) {
            final dateString = DateFormat.yMd().format(dateTime);
            print('date string : $dateString');
            expireDateController.text = dateString;
            setState(() {});
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'test',
        onPressed: () async {
          formKey.currentState?.save();
          /*if(formKey.currentState!.validate()){

          }*/
          final task = taskController.text;
          final createdBy = createdByController.text;
          final remarks = remarksController.text;
          final expireData = expireDateController.text;
          TodoModel todoModel = TodoModel(
            task: task,
            createdBy: createdBy,
            expireDate: DateFormat.yMd().parse(expireData),
            remarks: remarks.split(','),
            done: done,
          );
          final insertedId = await SqfliteService().createTodo(
            todoModel,
            db: widget.db,
          );
          print('todo inserted id: $insertedId');
          final todoList = await SqfliteService().getAllTodos(db: widget.db);
          Navigator.pop(context, todoList);
        },
        label: Text(
          'Add Your Todo',
        ),
      ),
    );
  }
}
