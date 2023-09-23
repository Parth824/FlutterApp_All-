import 'package:flutter/material.dart';

class sholk extends StatefulWidget {
  const sholk({super.key});

  @override
  State<sholk> createState() => _sholkState();
}

class _sholkState extends State<sholk> {
  @override
  Widget build(BuildContext context) {
    var k = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      body: Center(
        child: Card(
          child: ListTile(
            title: Row(
              children: [
                Text(
                  "${k['text']}",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
