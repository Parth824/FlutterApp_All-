import 'package:flutter/material.dart';

import '../../../../size_config.dart';

List DateData = [
  {
    'day': 23,
    'month': 6,
    'year': 2023,
    'attendance': "A",
  },
  {
    'day': 22,
    'month': 6,
    'year': 2023,
    'attendance': "P",
  },
  {
    'day': 21,
    'month': 6,
    'year': 2023,
    'attendance': "P",
  },
  {
    'day': 20,
    'month': 6,
    'year': 2023,
    'attendance': "A",
  },
];

class InforPage extends StatefulWidget {
  const InforPage({super.key});

  @override
  State<InforPage> createState() => _InforPageState();
}

class _InforPageState extends State<InforPage> {
  DateTime date = DateTime.now();
  bool changeColor = true;

  @override
  Widget build(BuildContext context) {
    dynamic detail = ModalRoute.of(context)!.settings.arguments as dynamic;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          detail['name'],
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        // elevation: 0,
      ),
      body: (DateData.isNotEmpty)
          ? Column(
              children: [
                ...DateData.map((e) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: (e['attendance'] == "P")
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Text(
                              "${e['day']} / ${e['month']} / ${e['year']}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19),
                            ),
                            Spacer(),
                            Text(
                              "${e['attendance']}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  "assets/images/no-data.png",
                  height: 70,
                )),
                Text("No Data Found...")
              ],
            ),
    );
  }
}
