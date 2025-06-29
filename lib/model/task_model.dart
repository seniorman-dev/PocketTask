import 'package:hive/hive.dart';




@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String title;
  
  @HiveField(1)
  final String note;

  @HiveField(2)
  final String status; // "pending" or "completed"

  @HiveField(3)
  final DateTime createdAt;

  Task({
    required this.title,
    required this.note,
    required this.status,
    required this.createdAt,
  });

  // Convert JSON to Task object
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'] ?? '',
      note: json['note'] ?? '',
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
    );
  }

  // Convert Task object to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'note': note,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Optional: Add copyWith method for easy modifications
  Task copyWith({
    String? title,
    String? note,
    String? status,
    DateTime? createdAt,
  }) {
    return Task(
      title: title ?? this.title,
      note: note ?? this.note,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}



class TaskAdapter extends TypeAdapter<Task> {
  @override
  final typeId = 0;

  @override
  Task read(BinaryReader reader) {
    return Task(title: reader.read(), note: reader.read(), status: reader.read(), createdAt: reader.read());
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer.write(obj.title);
    writer.write(obj.note);
    writer.write(obj.status);
    writer.write(obj.createdAt);
  }
}