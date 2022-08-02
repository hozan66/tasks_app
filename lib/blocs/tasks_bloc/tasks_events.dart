part of 'tasks_bloc.dart';

abstract class TasksEvents extends Equatable {
  const TasksEvents();

  @override
  List<Object?> get props => [];
}

class AddTaskEvent extends TasksEvents {
  final TaskModel task;
  const AddTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class UpdateTaskEvent extends TasksEvents {
  final TaskModel task;
  const UpdateTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TasksEvents {
  final TaskModel task;

  const DeleteTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class RemoveTaskEvent extends TasksEvents {
  final TaskModel task;

  const RemoveTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class MarkFavoriteOrUnFavoriteTaskEvent extends TasksEvents {
  final TaskModel task;

  const MarkFavoriteOrUnFavoriteTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class EditTaskEvent extends TasksEvents {
  final TaskModel oldTask;
  final TaskModel newTask;

  const EditTaskEvent({required this.oldTask, required this.newTask});

  @override
  List<Object?> get props => [oldTask, newTask];
}

class RestoreTaskEvent extends TasksEvents {
  final TaskModel task;

  const RestoreTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class DeleteAllTasksEvent extends TasksEvents {}
