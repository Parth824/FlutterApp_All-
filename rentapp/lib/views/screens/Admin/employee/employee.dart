import 'package:flutter/material.dart';
import 'package:rentapp/views/screens/Admin/employee/info_employee.dart';

import '../../../../size_config.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  static String routeName = '/employee';

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  List Data = [
    {
      'name': 'Zeel',
      'contact': '12345678987',
      'address': 'punagam, surat1',
      'salary': '25000',
    },
    {
      'name': 'Harshil',
      'contact': '456123789852',
      'address': 'punagam, surat2',
      'salary': '30000',
    },
    {
      'name': 'Parth',
      'contact': '8621596348',
      'address': 'punagam, surat3',
      'salary': '20000',
    },
    {
      'name': 'Akash',
      'contact': '4521456538',
      'address':
          'punagam, surat4 sdfe dfdvffv fvrfvrf fefrfvr fedazavfv fbgnjyjrsc',
      'salary': '15000',
    },
    {
      'name': 'Shubham',
      'contact': '8523699632',
      'address': 'punagam, surat5',
      'salary': '75000',
    },
    {
      'name': 'Ronak',
      'contact': '8521597536',
      'address': 'punagam, surat6',
      'salary': '50000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
          itemCount: Data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
              child: Container(
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                                Container(
                                  width: SizeConfig.screenWidth * .73,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "${Data[index]['name']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 19,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => InforPage(),settings: RouteSettings(arguments: Data[index])));
                                      });
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.green,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Colors.blue,
                                ),
                                Container(
                                  width: SizeConfig.screenWidth * .75,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "${Data[index]['contact']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 19,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.blue,
                                ),
                                Container(
                                  width: SizeConfig.screenWidth * .75,
                                  // height: MediaQuery.of(context).size.height * 0.03,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "${Data[index]['address']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 19,
                                          letterSpacing: 1,
                                          overflow: TextOverflow.clip),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  color: Colors.blue,
                                ),
                                Container(
                                  width: SizeConfig.screenWidth * .75,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "${Data[index]['salary']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              getProportionateScreenHeight(18),
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            );
          }),
    );
  }
}
