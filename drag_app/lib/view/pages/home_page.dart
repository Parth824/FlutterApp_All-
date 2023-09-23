import 'package:drag_app/view/componend/goldes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool k = false;
  bool n = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Games..."),
        centerTitle: true,
      ),
      backgroundColor: Colors.white10,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...glodes.k.map(
                    (e) => Column(
                      children: [
                        Draggable(
                          data: e['data'],
                          child: Container(
                            height: 75,
                            child: Image.asset(
                              e['image'],
                            ),
                          ),
                          feedback: Container(
                            height: 75,
                            child: Image.asset(
                              e['image'],
                            ),
                          ),
                          childWhenDragging: Container(
                            height: 75,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ...glodes.ko.map(
                    (e) => Column(
                      children: [
                        DragTarget(
                          onAccept: (data) {
                            if (data == e['data']) {
                             setState(() {
                                e['colors1'] = true;
                             });
                            }
                          },
                          builder: (context, candidateData, rejectedData) {
                            return Container(
                              height: 75,
                              width: 75,
                              color: (e['colors1'])? Colors.green:e['colors'],
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}