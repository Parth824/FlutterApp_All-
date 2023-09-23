import 'package:flutter/material.dart';
import 'package:hero_animation_app/model/globes.dart';

import '../scaeen/insr.dart';

class App_com extends StatefulWidget {
  const App_com({super.key});

  @override
  State<App_com> createState() => _App_comState();
}

class _App_comState extends State<App_com> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommended for you",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...data.r.map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => per_view(),
                                  settings: RouteSettings(arguments: e),
                                ),
                              );
                            });
                          },
                          child: Hero(
                            tag: e['t'],
                            child: Container(
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "${e['i']}",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "${e['n']}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${e['s']}⭐",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New & updated apps",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...data.n.map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => per_view(),
                                  settings: RouteSettings(arguments: e),
                                ),
                              );                 
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: e['t'],
                            child: Container(
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "${e['i']}",
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 57,
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${e['n']}",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${e['s']}⭐",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.green.shade800, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      "Ads",
                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Suggested for you",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...data.s.map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => per_view(),
                                  settings: RouteSettings(arguments: e),
                                ),
                              );
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: e['t'],
                            child: Container(
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "${e['i']}",
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 57,
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${e['n']}",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${e['s']}⭐",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
