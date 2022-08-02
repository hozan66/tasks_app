import 'package:flutter/material.dart';
import 'package:tasks_app/models/task_model.dart';

import '../blocs/bloc_exports.dart';
import '../widgets/tasks_list.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksStates>(
      builder: (context, state) {
        List<TaskModel> pendingTasksList = state.pendingTasks;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                    '${pendingTasksList.length} Pending | ${state.completedTasks.length} Completed'),
              ),
            ),
            TasksList(tasksList: pendingTasksList),
          ],
        );
      },
    );
  }
}
