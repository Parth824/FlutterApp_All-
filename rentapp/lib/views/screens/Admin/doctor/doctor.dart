import 'package:flutter/material.dart';
import 'package:rentapp/size_config.dart';
import 'package:rentapp/views/screens/Admin/doctor/info_page.dart';

import '../../../../globals.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  static String routeName = '/doctor';

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.only(
            left: SizeConfig.screenWidth * 0.0233,
            right: SizeConfig.screenWidth * 0.0233,
            top: SizeConfig.screenWidth * 0.00456,
            bottom: SizeConfig.screenWidth * 0.00456),
        child: SingleChildScrollView(
          child: Column(children: [
            ...Doctors.map((e) => GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Infor_Page(),
                          settings: RouteSettings(arguments: e),
                        ),
                      );
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.screenWidth * 0.0233),
                    margin:
                        EdgeInsets.only(top: SizeConfig.screenWidth * 0.0233),
                    height: SizeConfig.screenHeight * 0.13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenWidth * 0.0233),
                      color: Colors.blue.shade100,
                    ),
                    width: SizeConfig.screenWidth,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: SizeConfig.screenWidth * 0.07,
                                      width: SizeConfig.screenWidth * 0.07,
                                      child: Image.asset(
                                          "assets/images/hospital.png"),
                                    ),
                                    Text(
                                      " ${e["hospital"]}",
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.screenWidth * 0.042,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.screenWidth * 0.00456,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: SizeConfig.screenWidth * 0.07,
                                      width: SizeConfig.screenWidth * 0.07,
                                      child: Image.asset(
                                          "assets/images/doctor.png"),
                                    ),
                                    Text(
                                      "${e["dr.name"]}",
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenWidth * 0.037,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.screenWidth * 0.00456,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: SizeConfig.screenWidth * 0.07,
                                      width: SizeConfig.screenWidth * 0.07,
                                      child: Image.asset(
                                          "assets/images/mobile.png"),
                                    ),
                                    Text(
                                      " ${e["contact"]}",
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.screenWidth * 0.037,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: SizeConfig.screenWidth * 0.07,
                                    width: SizeConfig.screenWidth * 0.07,
                                    child:
                                        Image.asset("assets/images/paper.png"),
                                  ),
                                  Text(
                                    " ${e["paper type"]}",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenWidth * 0.037,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: SizeConfig.screenWidth * 0.07,
                                    width: SizeConfig.screenWidth * 0.07,
                                    child:
                                        Image.asset("assets/images/rupee.png"),
                                  ),
                                  Text(
                                    " ${e["paper price"]}",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenWidth * 0.037,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
