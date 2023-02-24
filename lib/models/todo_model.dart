import 'package:intl/intl.dart';

class TodoModel {
  int? id;
  String task;
  bool done;
  String createdBy;
  DateTime expireDate;
  List<String> remarks;
  DateTime? createdAt;
  DateTime? updatedAt;

  TodoModel({
    this.id,
    required this.task,
    this.done = false,
    required this.createdBy,
    required this.expireDate,
    required this.remarks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    this.createdAt = createdAt ?? DateTime.now();
    this.updatedAt = updatedAt ?? DateTime.now();
  }

  factory TodoModel.fromJson(Map<String, dynamic> data) {
    return TodoModel(
      id: data['id'],
      task: data['task'],
      done: data['done'] == 1 ? true : false,
      createdBy: data['created_by'],
      expireDate: DateFormat.yMd().parse(data['expire_date']),
      remarks: data['remarks'].split(',').cast<String>(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at'].split('T').first),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task': task,
      'done': done ? 1 : 0,
      'created_by': createdBy,
      'expire_date': DateFormat.yMd().format(expireDate),
      'remarks': remarks.join(','),
      'created_at': createdAt!.millisecondsSinceEpoch,
      'updated_at': updatedAt!.toIso8601String(),
    };
  }
}
