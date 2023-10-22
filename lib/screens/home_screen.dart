import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks_provider.dart';

import '../models/task.dart';
import '../providers/auth_provider.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final tasksProvider = Provider.of<TasksProvider>(context);
    final tasks = tasksProvider.tasks;
    final filter = tasksProvider.filter;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
        actions: [
          IconButton(
            onPressed: () {
              tasksProvider.changeFilter();
            },
            icon: filter.icon,
          ),
          IconButton(
            onPressed: () {
              authProvider.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTask()));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        itemCount: tasks.length,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              title: Text(tasks[index].text),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      tasks[index].completed = !tasks[index].completed;
                      tasksProvider.putTask(tasks[index]);
                    },
                    icon: Icon(tasks[index].completed
                        ? Icons.check_circle
                        : Icons.check_circle_outline),
                  ),
                  IconButton(
                    onPressed: () {
                      tasksProvider.deleteTask(tasks[index]);
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
