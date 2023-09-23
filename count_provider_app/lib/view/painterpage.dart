import 'package:flutter/material.dart';

class Custer_Page extends StatefulWidget {
  const Custer_Page({super.key});

  @override
  State<Custer_Page> createState() => _Custer_PageState();
}

class _Custer_PageState extends State<Custer_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("CustomPainter"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          width: 300,
          height: 300,
          child: CustomPaint(
            foregroundPainter: PaintCu(),
          ),
        ),
      ),
    );
  }
}

class PaintCu extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.blue;
    paint.strokeWidth = 10;
    paint.style = PaintingStyle.fill;
    paint.strokeCap = StrokeCap.square;

    // Offset a = Offset(size.width * 0.8, size.height * 0.8);
    // Offset b = Offset(size.width * 0.2, size.height * 0.2);
    // final rect = Rect.fromPoints(a, b);
    // Radius radius = Radius.circular(30);
    // canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paint);
    final c = Offset(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(c, size.width*0.4, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
