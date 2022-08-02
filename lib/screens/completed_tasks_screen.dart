import 'package:flutter/material.dart';
import 'package:tasks_app/models/task_model.dart';

import '../blocs/bloc_exports.dart';
import '../widgets/tasks_list.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksStates>(
      builder: (context, state) {
        List<TaskModel> completedTasksList = state.completedTasks;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text('${completedTasksList.length} Completed Tasks'),
              ),
            ),
            TasksList(tasksList: completedTasksList),
          ],
        );
      },
    );
  }
}
