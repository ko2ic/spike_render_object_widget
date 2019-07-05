import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo Home Page'),
        ),
        body: Center(child: MyHomePage()),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  double diameter = 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (value) {
            setState(() {
              diameter = double.parse(value);
            });
          },
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: diameter,
        ),
        CircleWidget(diameter),
      ],
    );
  }
}

class CircleWidget extends SingleChildRenderObjectWidget {
  final double diameter;

  CircleWidget(this.diameter);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CircleRenderObject(diameter);
  }

  @override
  void updateRenderObject(BuildContext context, CircleRenderObject renderObject) {
    renderObject..diameter = diameter;
  }
}

class CircleRenderObject extends RenderBox {
  CircleRenderObject(this._diameter);

  double _diameter;

  double get diameter => _diameter;

  set diameter(double value) {
    _diameter = value;
    markNeedsPaint();
//    markNeedsLayout();
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void performLayout() {
    super.size = Size(diameter, diameter);
  }

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {}

  void paint(PaintingContext context, Offset offset) {
    Paint line = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    context.canvas.drawCircle(offset, diameter, line);
  }
}
