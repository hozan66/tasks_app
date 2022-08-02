import 'package:flutter/material.dart';
import 'package:tasks_app/blocs/bloc_exports.dart';
import 'package:tasks_app/screens/my_drawer.dart';

import '../widgets/tasks_list.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Delete all Tasks'),
                    ),
                    onTap: () {
                      context.read<TasksBloc>().add(DeleteAllTasksEvent());
                    },
                  ),
                ],
              ),
            ],
          ),
          drawer: const MyDrawer(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text('${state.removedTasks.length} Tasks'),
                ),
              ),
              TasksList(tasksList: state.removedTasks),
            ],
          ),
        );
      },
    );
  }
}
