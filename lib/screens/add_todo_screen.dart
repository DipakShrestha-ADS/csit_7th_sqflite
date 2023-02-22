import 'package:flutter/material.dart';
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
          final insertedId = await widget.db.insert(
            'todos',
            {
              'task': task,
              'created_by': createdBy,
              'remarks': remarks,
              'expire_date': expireData,
              'done': done ? 1 : 0,
              'created_at': DateTime.now().millisecondsSinceEpoch,
              'updated_at': DateTime.now().toIso8601String(),
            },
          );
          print('todo inserted id: $insertedId');
        },
        label: Text(
          'Add Your Todo',
        ),
      ),
    );
  }
}
