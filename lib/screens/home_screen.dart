import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks_provider.dart';

import '../models/task.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('ToDo')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        itemCount: tasksProvider.tasks.length,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              title: Text(tasksProvider.tasks[index].text),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {

                    },
                    icon: Icon(Icons.check_circle_outline),
                  ),
                  IconButton(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
