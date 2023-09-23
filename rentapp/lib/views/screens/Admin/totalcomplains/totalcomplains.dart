import 'package:flutter/material.dart';

import '../../../../size_config.dart';

class TotalComplainsPage extends StatefulWidget {
  const TotalComplainsPage({super.key});

  static String routeName = '/totalcomplains';

  @override
  State<TotalComplainsPage> createState() => _TotalComplainsPageState();
}

class _TotalComplainsPageState extends State<TotalComplainsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 9.0,right: 9,bottom: 9,top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: SizeConfig.screenHeight * .15,
                            width: SizeConfig.screenWidth * .30,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Container(
                        width:SizeConfig.screenWidth * .55,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description : $index",
                              style: TextStyle(fontSize: 20,letterSpacing: 1,color: Colors.black),
                            ),
                          ],
                        ),
                      ),],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
