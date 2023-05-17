import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/model/task.dart';
import '../data/repository/tasks_repo_impl.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final repo = TasksRepoImpl();

  var _desc = "";
  var _title = "";

  _onDesc(value) {
    setState(() {
      _desc = value;
    });
  }

  _onTitle(value) {
    setState(() {
      _title = value;
    });
  }

  _onClickAdd() {
    var person = Task(
        id: 0,
        desc: _desc,
        title: _title,
        priority: 0,
        userId: 1);
    repo.createTask(person);

    context.pop("true");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              onChanged: (value) => {_onTitle(value)},
              decoration: InputDecoration(
                labelText: "Title",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: const Icon(Icons.title),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              onChanged: (value) => {_onDesc(value)},
              decoration: InputDecoration(
                labelText: "First name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: const Icon(Icons.person),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: ElevatedButton(
              onPressed: () => {_onClickAdd()},
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Add'),
            ),
          ),
        ],
      ),
    );
  }
}
