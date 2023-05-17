import '../model/task.dart';

abstract class TaskRepo {
  Future <List<Task>> getTasks();

  Future<List<Task>> getTasksByUserId(int userId);

  Future <bool> createTask(Task task);

  Future <Task?> getTask(int id);

  Future <bool> updateTask(Task task);

  Future <bool> deleteTask(int id);
}
