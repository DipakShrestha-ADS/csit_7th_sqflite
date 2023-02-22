class TodoModel {
  int id;
  String task;
  bool done;
  String createdBy;
  DateTime expireDate;
  List<String> remarks;
  DateTime? createdAt;
  DateTime? updatedAt;

  TodoModel({
    required this.id,
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
      done: data['done'],
      createdBy: data['created_by'],
      expireDate: data['expire_date'],
      remarks: data['remarks'],
      createdAt: data['created_at'],
      updatedAt: data['updated_at'],
    );
  }
}
