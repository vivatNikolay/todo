import 'dart:convert';

import 'package:http/http.dart';

import '../models/task.dart';

const _url = 'todobackend-go-kit.fly.dev';

class TaskHttpService {

  Future<List<Task>> getTasks() async {
    final uri = Uri.https(_url, '/todos');
    Response res = await get(uri);
    if (res.statusCode == 200) {
      final tasks = (jsonDecode(res.body) as List)
          .map((i) => Task.fromJson(i))
          .toList();
      return tasks;
    } else {
      throw "get tasks failed";
    }
  }

  Future<String> postTask(Task task) async {
    var headers = {
      'Content-Type': 'text/plain'
    };
    final uri = Uri.https(_url, '/todos');
    Response res = await post(uri, body: jsonEncode(task.toJson()), headers: headers);
    if (res.statusCode == 201) {
      return jsonDecode(res.body)['id'];
    } else {
      print(res.statusCode);
      throw "post task failed";
    }
  }

  Future<String> patchTask(Task task) async {
    var headers = {
      'Content-Type': 'text/plain'
    };
    final uri = Uri.https(_url, '/todos/${task.id ?? ''}');
    Response res = await patch(uri, body: jsonEncode(task.toJson()), headers: headers);
    if (res.statusCode == 200) {
      return jsonDecode(res.body)['id'];
    } else {
      print(res.statusCode);
      throw "patch task failed";
    }
  }

  Future<bool> deleteTask(Task task) async {
    final uri = Uri.https(_url, '/todos/${task.id ?? ''}');
    Response res = await delete(uri);
    if (res.statusCode == 204) {
      return true;
    } else {
      print(res.statusCode);
      throw "delete task failed";
    }
  }
}