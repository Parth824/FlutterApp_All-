import 'package:flutter/material.dart';

class per_view extends StatefulWidget {
  const per_view({super.key});

  @override
  State<per_view> createState() => _per_viewState();
}

class _per_viewState extends State<per_view> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> v =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
          SizedBox(
            width: 5,
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    tag: v['t'],
                    child: Container(
                      height: 75,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "${v['i']}",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${v['n']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Nodlecake Studios inc",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Contains ads * In app purahses",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${v['s']} ⭐",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "90M reviews",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 25,
                  width: 1.5,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${v['d']}+",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Downlods",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 25,
                  width: 1.5,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "E",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Everyone",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green.shade800,
                ),
                child: Center(
                  child: Text("Install"),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    height: 200,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "${v['i1']}",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    height: 200,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "${v['i2']}",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    height: 200,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "${v['i3']}",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    height: 200,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "${v['i4']}",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "About this game",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.1,
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Discover the endless desert",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(width: 0.5, color: Colors.black),
                            ),
                            child: Center(
                              child: Text(
                                "Action",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 150,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(width: 0.5, color: Colors.black),
                            ),
                            child: Center(
                              child: Text(
                                "Editors choise",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    "Rating & reviews",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Icon(
                    Icons.info_outline_rounded,
                    size: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "${v['s']}",
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star_half,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "5",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 12.5,
                                width: 175,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              Container(
                                height: 12.5,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Text(
                            "4",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 12.5,
                                width: 175,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              Container(
                                height: 12.5,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Text(
                            "3",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 12.5,
                                width: 175,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              Container(
                                height: 12.5,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Text(
                            "2",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 12.5,
                                width: 175,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              Container(
                                height: 12.5,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Text(
                            "1",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 12.5,
                                width: 175,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              Container(
                                height: 12.5,
                                width: 15,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
