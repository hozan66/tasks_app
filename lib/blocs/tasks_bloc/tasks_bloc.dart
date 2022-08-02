import 'package:equatable/equatable.dart';

import '../../models/task_model.dart';
import '../bloc_exports.dart';

// You want to have multiple files inside
// your library ("part & part of" approach)
part 'tasks_events.dart';

part 'tasks_states.dart';

// Convert events to states

// HydratedBloc store state automatically
class TasksBloc extends HydratedBloc<TasksEvents, TasksStates> {
  TasksBloc() : super(const TasksStates()) {
    // Receive or listen to the  events
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<RemoveTaskEvent>(_onRemoveTask);
    on<MarkFavoriteOrUnFavoriteTaskEvent>(_onMarkFavoriteOrUnFavoriteTask);
    on<EditTaskEvent>(_onEditTask);
    on<RestoreTaskEvent>(_onRestoreTask);
    on<DeleteAllTasksEvent>(_onDeleteAllTasks);
  }

  // List.from() Create list from another list
  // without changing the old list

  void _onAddTask(AddTaskEvent event, Emitter<TasksStates> emit) {
    final state = this.state;
    emit(TasksStates(
      pendingTasks: List.from(state.pendingTasks)
        ..add(event.task), // Adding model to the list
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TasksStates> emit) {
    final state = this.state;
    final task = event.task;

    List<TaskModel> pendingTasks = state.pendingTasks;
    List<TaskModel> completedTasks = state.completedTasks;
    List<TaskModel> favoriteTasks = state.favoriteTasks;

    if (task.isDone == false) {
      if (task.isFavorite == false) {
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks.insert(0, task.copyWith(isDone: true));
      } else {
        int taskIndex = favoriteTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks.insert(0, task.copyWith(isDone: true));
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: true));
      }
    } else {
      if (task.isFavorite == false) {
        completedTasks = List.from(pendingTasks)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
      } else {
        int taskIndex = favoriteTasks.indexOf(task);
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: false));
      }
    }

    // task.isDone == false
    //     ? {
    //         pendingTasks = List.from(pendingTasks)..remove(task),
    //         completedTasks = List.from(completedTasks)
    //           ..insert(0, task.copyWith(isDone: true))
    //       }
    //     : {
    //         completedTasks = List.from(completedTasks)..remove(task),
    //         pendingTasks = List.from(pendingTasks)
    //           ..insert(0, task.copyWith(isDone: false))
    //       };

    emit(TasksStates(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TasksStates> emit) {
    final state = this.state;
    emit(TasksStates(
      pendingTasks: state.pendingTasks,
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: List.from(state.removedTasks)..remove(event.task),
    ));
  }

  void _onRemoveTask(RemoveTaskEvent event, Emitter<TasksStates> emit) {
    final state = this.state;
    emit(TasksStates(
      pendingTasks: List.from(state.pendingTasks)..remove(event.task),
      completedTasks: List.from(state.completedTasks)..remove(event.task),
      favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
      removedTasks: List.from(state.removedTasks)
        ..add(event.task.copyWith(isDeleted: true)),
    ));
  }

  void _onMarkFavoriteOrUnFavoriteTask(
      MarkFavoriteOrUnFavoriteTaskEvent event, Emitter<TasksStates> emit) {
    final state = this.state;

    List<TaskModel> pendingTasks = state.pendingTasks;
    List<TaskModel> completedTasks = state.completedTasks;
    List<TaskModel> favoriteTasks = state.favoriteTasks;

    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        int taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        int taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFavorite == false) {
        int taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        int taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }

    emit(TasksStates(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onEditTask(EditTaskEvent event, Emitter<TasksStates> emit) {
    final state = this.state;
    List<TaskModel> favoriteTasks = state.favoriteTasks;

    if (event.oldTask.isFavorite == true) {
      favoriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }

    emit(TasksStates(
      pendingTasks: List.from(state.pendingTasks)
        ..remove(event.oldTask)
        ..insert(0, event.newTask),
      completedTasks: List.from(state.completedTasks)..remove(event.oldTask),
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onRestoreTask(RestoreTaskEvent event, Emitter<TasksStates> emit) {
    final state = this.state;

    emit(TasksStates(
      removedTasks: List.from(state.removedTasks)..remove(event.task),
      pendingTasks: List.from(state.pendingTasks)
        ..insert(
            0,
            event.task.copyWith(
              isDeleted: false,
              isDone: false,
              isFavorite: false,
            )),
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
    ));
  }

  void _onDeleteAllTasks(DeleteAllTasksEvent event, Emitter<TasksStates> emit) {
    final state = this.state;

    emit(TasksStates(
      removedTasks: List.from(state.removedTasks)..clear(),
      pendingTasks: state.pendingTasks,
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
    ));
  }

  @override
  // Called every time the app needs stored data

  // To Retrieve Data
  TasksStates? fromJson(Map<String, dynamic> json) {
    return TasksStates.fromMap(json);
  }

  @override
  // Called for every state

  // To Save Data
  Map<String, dynamic>? toJson(TasksStates state) {
    return state.toMap();
  }
}
