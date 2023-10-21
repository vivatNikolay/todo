import 'package:flutter/material.dart';

import '../models/task.dart';

class TasksProvider extends ChangeNotifier {

  List<Task> _tasks = [
    Task(id: '123', text: '34t5yhrt', completed: false),
    Task(id: '1234', text: '34t5yhkfjnrt', completed: false),
    Task(id: '1235', text: 'kiwbefa', completed: true),
    Task(id: '1236', text: '0809245', completed: false),
  ];

  List<Task> get tasks => _tasks;

  Future<bool> addTask(Task task) async {

    notifyListeners();
    return true;
  }

  Future<bool> putTask(Task task) async {

    notifyListeners();
    return true;
  }

  Future<bool> deleteTask(Task task) async {

    notifyListeners();
    return true;
  }
}
