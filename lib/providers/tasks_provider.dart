import 'package:flutter/material.dart';
import 'package:todo/models/filter_state.dart';
import 'package:todo/services/task_http_service.dart';

import '../models/task.dart';

class TasksProvider extends ChangeNotifier {
  final TaskHttpService _httpService = TaskHttpService();

  List<Task> _tasks = [];
  FilterState _filter = FilterState.all;

  List<Task> get tasks => _tasks;
  FilterState get filter => _filter;

  TasksProvider() {
    getTasks();
  }

  Future<bool> getTasks() async {
    _tasks = await _httpService.getTasks();
    notifyListeners();
    return true;
  }

  Future<bool> addTask(Task task) async {
    _tasks.add(task);
    _httpService.postTask(task);
    notifyListeners();
    return true;
  }

  void changeFilter() async {
    switch (_filter) {
      case FilterState.all: {
        _filter = FilterState.completed;
        _tasks = (await _httpService.getTasks()).where((t) => t.completed).toList();
        break;
      }
      case FilterState.completed: {
        _filter = FilterState.active;
        _tasks = (await _httpService.getTasks()).where((t) => !t.completed).toList();
        break;
      }
      case FilterState.active: {
        _filter = FilterState.all;
        _tasks = await _httpService.getTasks();
        break;
      }
    }
    notifyListeners();
  }

  Future<bool> putTask(Task task) async {
    _tasks.firstWhere((t) => t.id == task.id)
      ..text = task.text
      ..completed = task.completed;
    _httpService.patchTask(task);
    notifyListeners();
    return true;
  }

  Future<bool> deleteTask(Task task) async {
    _tasks.removeWhere((t) => t.id == task.id);
    _httpService.deleteTask(task);
    notifyListeners();
    return true;
  }
}
