import 'package:flutter/material.dart';
import 'package:rentapp/size_config.dart';


class InformationDoctor extends StatefulWidget {
  const InformationDoctor({super.key});

  @override
  State<InformationDoctor> createState() => _InformationDoctorState();
}

class _InformationDoctorState extends State<InformationDoctor> {
   @override
  Widget build(BuildContext context) {
    Map<String, dynamic> detail =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.all(SizeConfig.screenWidth * 0.0233),
      // color: Colors.grey,
      child: Column(
        children: [
          Container(
            // alignment: Alignment.center,
            height: SizeConfig.screenHeight * 0.38,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.all(SizeConfig.screenWidth * 0.0233),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.0233),
                color: Colors.blue.shade100),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Text(
              //     "Hospital Name",
              //     style: TextStyle(
              //         fontSize: width * 0.037,
              //         color: Colors.grey.shade600,
              //         fontWeight: FontWeight.w600),
              //   ),
              //   Divider(),
              //   Text(
              //     detail["hospital"],
              //     style: TextStyle(
              //         fontSize: width * 0.042,
              //         color: Colors.black,
              //         fontWeight: FontWeight.w600),
              //   ),

              Row(
                  children: [
                    Container(
                      height: SizeConfig.screenWidth * 0.07,
                      width: SizeConfig.screenWidth * 0.07,
                      child: Image.asset("assets/images/hospital.png"),
                    ),
                    Text(
                      " ${detail["hospital"]}",
                      style: TextStyle(
                          fontSize: SizeConfig.screenWidth * 0.042, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: width * 0.00456,
                // ),
                Divider(),
                Row(
                children: [
                  Container(
                    height: SizeConfig.screenWidth * 0.07,
                    width: SizeConfig.screenWidth * 0.07,
                    child: Image.asset("assets/images/doctor.png"),
                  ),
                  SizedBox(width: SizeConfig.screenWidth *0.02,),
                  Text(
                    "${detail["dr.name"]}",
                    style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 0.042,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    height: SizeConfig.screenWidth * 0.07,
                    width: SizeConfig.screenWidth * 0.07,
                    child: Image.asset("assets/images/mobile.png"),
                  ),
                  Text(
                    " ${detail["contact"]}",
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.042, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    height: SizeConfig.screenWidth * 0.07,
                    width: SizeConfig.screenWidth * 0.07,
                    child: Image.asset("assets/images/location.png"),
                  ),
                  Text(
                    " ${detail["address"]}",
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.042, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(children: [
                SizedBox(width: SizeConfig.screenWidth *0.08,),
                Text(detail["city"],
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.042, fontWeight: FontWeight.w600),
                  ),
                Text(detail["state"],
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.042, fontWeight: FontWeight.w600),
                  ),
              ],),
              Divider(),
              Row(
                children: [
                  Container(
                    height: SizeConfig.screenWidth * 0.07,
                    width: SizeConfig.screenWidth * 0.07,
                    child: Image.asset("assets/images/paper.png"),
                  ),
                  Text(
                    " ${detail["paper type"]}",
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.037, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    height: SizeConfig.screenWidth * 0.07,
                    width: SizeConfig.screenWidth * 0.07,
                    child: Image.asset("assets/images/rupee.png"),
                  ),
                  Text(
                    " ${detail["paper price"]} INR",
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.037, fontWeight: FontWeight.w500),
                  ),
                ],
              )

              // Text(
              //   "Hospital Name ",
              //   style: TextStyle(
              //       fontSize: width * 0.0325,
              //       color: Colors.grey.shade700,
              //       fontWeight: FontWeight.w600),
              // ),
              // SizedBox(height: width*0.00456,),
              // Text(
              //   detail["hospital"],
              //   style: TextStyle(
              //       fontSize: width * 0.042,
              //       color: Colors.black,
              //       fontWeight: FontWeight.w500),
              // )
            ]),
          ),
        ],
      ),
    );
  }
}