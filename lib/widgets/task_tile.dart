import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/widgets/my_popup_menu.dart';

import '../blocs/bloc_exports.dart';
import '../models/task_model.dart';
import '../screens/edit_task_screen.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final TaskModel task;

  void _removeOrDeleteTask(BuildContext ctx, TaskModel task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTaskEvent(task: task))
        : ctx.read<TasksBloc>().add(RemoveTaskEvent(task: task));
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // So keyboard won't cover showModalBottomSheet
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              // viewInsets is for the keyboard
              // viewInsets represents areas fully obscured by the system
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: EditTaskScreen(oldTask: task),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('date: ${task.date}');
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavorite == false
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.0,
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      Text(
                        DateFormat()
                            .add_yMMMd()
                            .add_Hms()
                            .format(DateTime.parse(task.date)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted! == false
                    ? (value) {
                        context
                            .read<TasksBloc>()
                            .add(UpdateTaskEvent(task: task));
                      }
                    : null,
              ),
              MyPopupMenu(
                task: task,
                cancelOrDeleteCallback: () =>
                    _removeOrDeleteTask(context, task),
                likeOrDislikeCallback: () {
                  context.read<TasksBloc>().add(
                        MarkFavoriteOrUnFavoriteTaskEvent(task: task),
                      );
                },
                editTaskCallback: () {
                  Navigator.of(context).pop();
                  _editTask(context);
                },
                restoreTaskCallback: () {
                  context.read<TasksBloc>().add(RestoreTaskEvent(task: task));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
