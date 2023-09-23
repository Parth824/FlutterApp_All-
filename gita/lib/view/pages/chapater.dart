import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gita/view/pages/versese.dart';

class Bhagavat extends StatefulWidget {
  const Bhagavat({super.key});

  @override
  State<Bhagavat> createState() => _BhagavatState();
}

class _BhagavatState extends State<Bhagavat> {
  List bhag = [];

  ToString() async {
    String k = await rootBundle.loadString("assets/joson/bwg.json");

    final data = await json.decode(k);

    setState(() {
      bhag = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ToString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bhagavat Gita"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: bhag.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Verses_gita(),
                    settings: RouteSettings(arguments: bhag[index]["verses"]),
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
                      Text("Chapter ${index + 1}"),
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
