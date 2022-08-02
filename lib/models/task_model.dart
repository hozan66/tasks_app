import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String title;
  final String description;
  final String id;
  final String date;
  final bool? isDone;
  final bool? isDeleted;
  final bool? isFavorite;

  const TaskModel({
    required this.title,
    required this.description,
    required this.id,
    required this.date,
    this.isDone = false,
    this.isDeleted = false,
    this.isFavorite = false,
  });
  // {
  // Default values
  // ?? means is it null
  // isDone = isDone ?? false;
  // isDeleted = isDeleted ?? false;
  // }

  TaskModel copyWith({
    String? title,
    String? description,
    String? id,
    String? date,
    bool? isDone,
    bool? isDeleted,
    bool? isFavorite,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'id': id,
      'date': date,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isFavorite': isFavorite,
    };
  }

  // We use the factory keyword to implement constructors
  // that do not produce new instances of an existing class.
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      id: map['id'] ?? '',
      date: map['date'] ?? '10-10-2000 10:10:10',
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
      isFavorite: map['isFavorite'],
    );
  }

  @override
  // So we can compare two objects or instances
  List<Object?> get props =>
      [title, description, id, date, isDone, isDeleted, isFavorite];
}
