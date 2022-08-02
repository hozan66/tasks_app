import 'package:flutter/material.dart';
import 'package:tasks_app/widgets/task_tile.dart';

import '../models/task_model.dart';
import '../services/constants.dart';

class TasksList extends StatelessWidget {
  final List<TaskModel> tasksList;

  const TasksList({
    Key? key,
    required this.tasksList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // We need Expanded() because we can't wrap ListView.builder() with Column() immediately
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ExpansionPanelList.radio(
          children: tasksList
              .map(
                (task) => ExpansionPanelRadio(
                  value: uuid.v1(), // We need unique ID here
                  headerBuilder: (context, isOpen) => TaskTile(task: task),
                  // It will be copyable and selectable
                  body: ListTile(
                    title: SelectableText.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Text Title\n',
                            style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: task.title,
                          ),
                          const TextSpan(
                            text: '\n\nDescription\n',
                            style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: task.description,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
