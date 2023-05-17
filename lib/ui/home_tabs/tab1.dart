import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hello_flutter/service/auth_service.dart";
import "../../data/model/task.dart";
import "../../data/repository/tasks_repo_impl.dart";

class FirstTab extends StatefulWidget {
  const FirstTab({Key? key}) : super(key: key);

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  var _tasks = <Task>[];

  final repo = TasksRepoImpl();

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() async {
    final user = await AuthService.getUser();
    final res = await repo.getTasksByUserId(user!.id);
    setState(() {
      _tasks = res;
    });
  }

  void _onClickAdd() async {
    final user = await AuthService.getUser();
    if(user != null){
      final task = Task(title: "Superhuman", desc: "superhero", priority: 0, userId: user.id);
      await repo.createTask(task);
      refresh();
    }
  }

  void _deleteTask(int id) async {
    await repo.deleteTask(id);
    refresh();
  }

  Future<bool> _onConfirmDismiss(DismissDirection dir) async {
    if (dir == DismissDirection.endToStart) {
      return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Are you sure?"),
              content: const Text(
                  "The item will deleted and the action can not be undone"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("YES")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text("NO"))
              ],
            );
          });
    } else {
      return false;
    }
  }

  void _updateTask(Task task) async {
    debugPrint("$task");
    task = Task(
        id: task.id,
        title: "Superhuman",
        desc: "super",
        priority: 0,
        userId: 1);
    await repo.updateTask(task);
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                  color: Colors.cyan,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return Card(
                        margin: const EdgeInsets.all(20),
                        elevation: 20,
                        child: Dismissible(
                          key: Key(task.id.toString()),
                          onDismissed: (dir) {
                            _deleteTask(task.id);
                          },
                          secondaryBackground: Container(
                            color: Colors.red.shade600,
                            child: const Center(
                              child: Text(
                                "Deleted",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          confirmDismiss: (dir) async {
                            // if (dir == DismissDirection.endToStart) {
                            //   return true;
                            // }
                            // return false;
                            return _onConfirmDismiss(dir);
                          },
                          background: Container(
                            color: Colors.green,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              // <-- Add a background color to the container
                              color: Colors
                                  .white, // <-- Change the color to a different color from the background color of the Dismissible widget
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("FirstName: ${task.title}"),
                                    Text("Priority: ${task.desc}")
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _updateTask(_tasks[index]);
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _deleteTask(_tasks[index].id);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red.shade700,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_onClickAdd()},
        child: const Icon(Icons.add),
      ),
    );
  }
}
