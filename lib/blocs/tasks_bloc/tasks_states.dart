part of 'tasks_bloc.dart';

// Why is Equatable with BLoC?
// In Bloc , we have to extend Equatable to States and Events classes
// to use this functionality. This helps us when it comes to stream
// as we need to decide state updating based on it.
// LoginState will not make duplicate calls and will not going to rebuild
// the widget if the same state occurs

class TasksStates extends Equatable {
  final List<TaskModel> pendingTasks;
  final List<TaskModel> completedTasks;
  final List<TaskModel> favoriteTasks;
  final List<TaskModel> removedTasks;

  const TasksStates({
    this.pendingTasks = const [],
    this.completedTasks = const [],
    this.favoriteTasks = const [],
    this.removedTasks = const [],
  });

  @override
  List<Object?> get props => [
        pendingTasks,
        completedTasks,
        favoriteTasks,
        removedTasks,
      ];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result
        .addAll({'pendingTasks': pendingTasks.map((x) => x.toMap()).toList()});
    result.addAll(
        {'completedTasks': completedTasks.map((x) => x.toMap()).toList()});
    result.addAll(
        {'favoriteTasks': favoriteTasks.map((x) => x.toMap()).toList()});
    result
        .addAll({'removedTasks': removedTasks.map((x) => x.toMap()).toList()});

    return result;
  }

  factory TasksStates.fromMap(Map<String, dynamic> map) {
    return TasksStates(
      pendingTasks: List<TaskModel>.from(
          map['pendingTasks']?.map((x) => TaskModel.fromMap(x))),
      completedTasks: List<TaskModel>.from(
          map['completedTasks']?.map((x) => TaskModel.fromMap(x))),
      favoriteTasks: List<TaskModel>.from(
          map['favoriteTasks']?.map((x) => TaskModel.fromMap(x))),
      removedTasks: List<TaskModel>.from(
          map['removedTasks']?.map((x) => TaskModel.fromMap(x))),
    );
  }
}
