import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/task_model.dart';
import '../services/constants.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({
    Key? key,
  }) : super(key: key);

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'Add Task',
            style: TextStyle(fontSize: 24.0),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextField(
              autofocus: true,
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                TaskModel task = TaskModel(
                  title: titleController.text,
                  description: descriptionController.text,
                  // Every time we call this function, it we generate unique ID
                  id: uuid.v1(),
                  date: DateTime.now().toString(),
                );

                context.read<TasksBloc>().add(AddTaskEvent(task: task));
                // titleController.clear();
                Navigator.pop(context);
              },
            ),
          ),
          TextField(
            autofocus: true,
            controller: descriptionController,
            minLines: 3,
            maxLines: 6,
            decoration: const InputDecoration(
              label: Text('Description'),
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              TaskModel task = TaskModel(
                title: titleController.text,
                description: descriptionController.text,
                // Every time we call this function, it we generate unique ID
                id: uuid.v1(),
                date: DateTime.now().toString(),
              );

              context.read<TasksBloc>().add(AddTaskEvent(task: task));
              // titleController.clear();
              Navigator.pop(context);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  TaskModel task = TaskModel(
                    title: titleController.text,
                    description: descriptionController.text,
                    // Every time we call this function, it we generate unique ID
                    id: uuid.v1(),
                    date: DateTime.now().toString(),
                  );

                  context.read<TasksBloc>().add(AddTaskEvent(task: task));
                  // titleController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
