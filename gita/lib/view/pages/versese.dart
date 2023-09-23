import 'package:flutter/material.dart';
import 'package:gita/view/pages/verse.dart';

class Verses_gita extends StatefulWidget {
  const Verses_gita({super.key});

  @override
  State<Verses_gita> createState() => _Verses_gitaState();
}

class _Verses_gitaState extends State<Verses_gita> {
  @override
  Widget build(BuildContext context) {
    var k = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      body: ListView.builder(
        itemCount: k.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => sholk(),
                    settings: RouteSettings(arguments: k[index]),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  leading: Container(
                    width: 30,
                  ),
                  title: Row(
                    children: [
                      SizedBox(
                        width: 35,
                      ),
                      Text("Vrese ${index + 1}"),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
