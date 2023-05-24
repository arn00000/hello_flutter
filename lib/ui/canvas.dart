import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class MyCanvas extends StatefulWidget {
  const MyCanvas({Key? key}) : super(key: key);

  @override
  State<MyCanvas> createState() => _MyCanvasState();
}

class _MyCanvasState extends State<MyCanvas>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  var _state = 0.0;

  // var _path = Path();
  final _widgetKey = GlobalKey();
  Color _selectedColor = Colors.blue;
  final List<_DrawnPath> _paths = [];

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);

    animationController.addListener(() {
      setState(() {
        _state = animationController.value;
      });
    });
  }

  void _start() {
    animationController.reset();
    animationController.forward();
  }

  void _begin(PointerDownEvent event) {
    final referenceBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox;
    final offset = referenceBox.globalToLocal(event.position);
    setState(() {
      _paths.add(_DrawnPath(path: Path(), color: _selectedColor));
      _paths.last.path.moveTo(offset.dx, offset.dy);
    });
  }

  void _draw(PointerMoveEvent event) {
    final referenceBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox;
    final offset = referenceBox.globalToLocal(event.position);
    setState(() {
      _paths.last.path.lineTo(offset.dx, offset.dy);
    });
  }

  void _reset() {
    setState(() {
      _paths.clear();
    });
  }

  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  _selectedColor = color;
                });
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Canvas"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Listener(
                onPointerDown: (event) => _begin(event),
                onPointerMove: (event) => _draw(event),
                child: ClipRect(
                  child: Container(
                    key: _widgetKey,
                    width: 300,
                    height: 400,
                    color: Colors.black,
                    child: CustomPaint(
                      painter: MyPainter(
                          scale: _state, paths: _paths, color: _selectedColor),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () => _start(), child: const Text("Start")),
              ElevatedButton(
                onPressed: () => _reset(),
                child: const Text("Reset"),
              ),
              ElevatedButton(
                onPressed: () => _openColorPicker(),
                child: const Text("Select Color"),
              ),
            ],
          ),
        ));
  }
}

class MyPainter extends CustomPainter {
  MyPainter({required this.scale, required this.paths, required this.color});

  final double scale;
  // final Path path;
  final Color color;
  final List<_DrawnPath> paths;

  @override
  void paint(Canvas canvas, Size size) {
    var center = size / 2;
    for (var drawnPath in paths) {
      var paint = Paint()
        ..color = drawnPath.color
        ..strokeWidth = 3.0
        ..style = PaintingStyle.stroke;

      var path = drawnPath.path;

      canvas.drawPath(path, paint);
    }
    var paint = Paint()..color = color;
    canvas.drawCircle(Offset(center.width, center.height), 50.0 * scale, paint..color = Colors.orange);

    paint = Paint()
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..color = color;

    var arAngle = 3.2 * scale;


    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(center.width, center.height), radius: 80.0),
        3.1,
        arAngle,
        false,
        paint..color = Colors.red);

    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(center.width, center.height), radius: 90.0),
        3.1,
        arAngle,
        false,
        paint..color = Colors.orange);

    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(center.width, center.height), radius: 100.0),
        3.1,
        arAngle,
        false,
        paint..color = Colors.yellow);

    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(center.width, center.height), radius: 110.0),
        3.1,
        arAngle,
        false,
        paint..color = Colors.green);

    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(center.width, center.height), radius: 120.0),
        3.1,
        arAngle,
        false,
        paint..color = Colors.blue);

    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(center.width, center.height), radius: 130.0),
        3.1,
        arAngle,
        false,
        paint..color = Colors.indigo);
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(center.width, center.height), radius: 140.0),
        3.1,
        arAngle,
        false,
        paint..color = Colors.purple);

    // var path = Path();
    // path.moveTo(100, 100);
    // path.lineTo(120, 110);
    // path.lineTo(140, 170);
    // path.lineTo(100, 160);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _DrawnPath {
  final Path path;
  final Color color;

  _DrawnPath({required this.path, required this.color});
}
