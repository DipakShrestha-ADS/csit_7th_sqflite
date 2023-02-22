import 'package:flutter/material.dart';

class TodoForm extends StatelessWidget {
  const TodoForm({
    Key? key,
    this.formKey,
    required this.taskController,
    required this.createdByController,
    required this.remarksController,
    required this.expireDateController,
    this.done = false,
    this.onDone,
  }) : super(key: key);
  final GlobalKey<FormState>? formKey;
  final TextEditingController taskController;
  final TextEditingController createdByController;
  final TextEditingController remarksController;
  final TextEditingController expireDateController;
  final bool done;
  final void Function(bool?)? onDone;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Task',
                hintText: 'Enter your todo task',
              ),
            ),
            TextFormField(
              controller: createdByController,
              decoration: InputDecoration(
                labelText: 'Created By',
                hintText: 'Enter your name',
              ),
            ),
            TextFormField(
              controller: remarksController,
              decoration: InputDecoration(
                labelText: 'Remarks',
                hintText: 'Add remarks',
              ),
            ),
            TextFormField(
              controller: expireDateController,
              decoration: InputDecoration(
                labelText: 'Expire Date',
                hintText: 'Enter date of expire',
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: done,
                  onChanged: onDone,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
