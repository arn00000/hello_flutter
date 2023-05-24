import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FifthTab extends StatefulWidget {
  const FifthTab({Key? key}) : super(key: key);

  @override
  State<FifthTab> createState() => _FifthTabState();
}

class _FifthTabState extends State<FifthTab>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  var _angle = 0.0;
  var _scale = 0.0;
  var _color = Colors.transparent;

  @override
  void initState() {
    super.initState();
    var colorTween = ColorTween(begin: Colors.transparent, end: Colors.blue);
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    var colorTweenAnimation = colorTween.animate(controller);

    colorTweenAnimation.addListener(() {
      setState(() {
       _color = colorTweenAnimation.value ?? Colors.transparent;
      });
    });

    controller.addListener(() {
      setState(() {
        _angle = 20 * controller.value;
        _scale = 3 * controller.value;
      });
      // debugPrint("Value: ${controller.value.toString()}");
    });
  }

  void _startAnimation() {
    controller.reset();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
          flex: 2,
          child: Container(
            color: Colors.cyan,
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                Transform.rotate(
                  angle: _angle,
                  origin: const Offset(10.0, 10.0),
                  child: const Icon(
                    Icons.sports_basketball,
                    size: 65,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Transform.scale(
                  scale: _scale,
                  origin: const Offset(10.0, 10.0),
                  child: const Icon(
                    Icons.sports_basketball,
                    size: 65,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Transform(
                  transform: Matrix4.identity()..translate(_angle),
                  child:  Icon(
                    Icons.animation,
                    size: 65,
                    // color: _color,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                    onPressed: () => _startAnimation(),
                    child: const Text("Start"))
              ],
            ),
          ))
    ]));
  }
}

mixin Human {}

class Person {}

class Student with Human {}
