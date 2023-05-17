import 'package:flutter/cupertino.dart';
import 'package:hello_flutter/data/model/task.dart';
import 'package:hello_flutter/data/repository/tasks_repo.dart';

import '../database/db.dart';

class TasksRepoImpl extends TaskRepo {
  static final TasksRepoImpl _instance = TasksRepoImpl._internal();

  factory TasksRepoImpl() {
    return _instance;
  }

  TasksRepoImpl._internal();

  var counter = 2;
  // final _tasks = {
  //   1: const Task(
  //       id: 1,
  //       firstName: "abc",
  //       lastName: "def",
  //       age: 15,
  //       title: "Student",),
  //   2: const Task(
  //       id: 2,
  //       firstName: "ert",
  //       lastName: "def",
  //       age: 15,
  //       title: "Student",)
  // };

  @override
  Future<List<Task>> getTasks() async {
    // return _tasks.entries.map((e) => e.value).toList();
    final res = await TasksDatabase.getTasks();
    return res.map((e) => Task.fromMap(e)).toList();
  }


  @override
  Future<bool> createTask(Task task) async {
    // _tasks[++counter] = task.copy(id: counter);
    // debugPrint(_tasks.length.toString());
    // return true;
    await TasksDatabase.createTask(task);
    return true;
  }

  @override
  Future<Task?> getTask(int id) async {
    final res = await TasksDatabase.getTask(id);
    if (res.isEmpty) {
      return null;
    }
    return Task.fromMap(res[0]);
  }

  @override
  Future<bool> updateTask(Task task) async{
    await TasksDatabase.updateTask(task);
    return true;
  }

  @override
  Future<bool> deleteTask(int id) async {
    await TasksDatabase.deleteTask(id);
    return true;
  }

  @override
  Future<List<Task>> getTasksByUserId(int userId) async {
    final res = await TasksDatabase.getTaskByUserId(userId);
    return res.map((e)=> Task.fromMap(e)).toList();
  }

}
