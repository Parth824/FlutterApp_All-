import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Game."),
        centerTitle: true,
      ),
      body: Center(
        child: Draggable(
          feedback: Material(
            child: Container(
              height: 100,
              width: 100,
              alignment: Alignment.center,
              child: Text("Dragged"),
              color: Colors.green,
            ),
          ),
          child: Container(
            height: 100,
            width: 100,
            color: Colors.purple,
            alignment: Alignment.center,
            child: Text(
              "Drag Me",
            ),
          ),
        ),
      ),
    );
  }
}
