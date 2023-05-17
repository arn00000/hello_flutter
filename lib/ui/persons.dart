import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/model/task.dart';

class Persons extends StatefulWidget {
  const Persons({Key? key}) : super(key: key);

  @override
  State<Persons> createState() => _PersonsState();
}

class _PersonsState extends State<Persons> {
  final _persons = [
    // const Task(
    //     firstName: "Abc", lastName: "def", age: 20, title: "qwe", priority: 0,userId: 1),
    // const Task(
    //     firstName: "Abc", lastName: "def", age: 20, title: "qwe", priority: 0,userId: 1),
    // const Task(
    //     firstName: "Abc", lastName: "def", age: 20, title: "qwe", priority: 0,userId: 1),
    // const Task(
    //     firstName: "Abc", lastName: "def", age: 20, title: "qwe", priority: 0,userId: 1)
  ];

  _onClickBack() {
    context.pop("Hello pop");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Person"),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                  color: Colors.orange,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: _persons.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text("Current index is $index"),
                          Text(
                              "Name: ${_persons[index].firstName} ${_persons[index].lastName}"),
                          Text("Age: ${_persons[index].age}"),
                          Text("Title: ${_persons[index].title}"),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      );
                    },
                    // children: const [
                    //   Align(
                    //     alignment: Alignment.center,
                    //     child: CustomText(),
                    //   ),
                    //   SizedBox(height: 100,),
                    //   Align(
                    //     alignment: Alignment.centerRight,
                    //     child: CustomText(),
                    //   ),
                    //   CustomText(),
                    //   Spacer(),
                    //   CustomText(),
                    //   Spacer(),
                    //   SizedBox(height: 100,),
                    //   CustomText()
                    // ],
                  ))),
          ElevatedButton(onPressed: _onClickBack(), child: const Text("Back"))
          // Expanded(
          //     flex: 1,
          //     child: Container(
          //       color: Colors.red,
          //       width: double.infinity,
          //       child: const Text("Expanded Widget"),
          //     ))
        ],
      ),
    );
  }
}
