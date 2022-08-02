import 'package:flutter/material.dart';
import 'package:tasks_app/models/task_model.dart';

import '../blocs/bloc_exports.dart';
import '../widgets/tasks_list.dart';

class FavoriteTasksScreen extends StatelessWidget {
  const FavoriteTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksStates>(
      builder: (context, state) {
        List<TaskModel> favoriteTasksList = state.favoriteTasks;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text('${favoriteTasksList.length} Favorite Tasks'),
              ),
            ),
            TasksList(tasksList: favoriteTasksList),
          ],
        );
      },
    );
  }
}
