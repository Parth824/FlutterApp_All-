import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentapp/components/social_circle.dart';
import 'package:rentapp/constants.dart';
import 'package:rentapp/size_config.dart';

import '../../../../components/default_button.dart';
import '../sign_up/sign_up_screen.dart';
import 'select_category_controller.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({super.key});

  static String routeName = '/select_category';

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {

  Select_Cat_Controller select_cat_controller = Get.put(Select_Cat_Controller());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Select Category"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            select_cat_controller.updateIsDoctor(k: true);
                          },
                          child: Obx(
                            () {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(10),
                                ),
                                padding: EdgeInsets.all(
                                  getProportionateScreenWidth(20),
                                ),
                                height: getProportionateScreenHeight(120),
                                width: getProportionateScreenWidth(120),
                                decoration: BoxDecoration(
                                  color: (select_cat_controller.isDoctor.value)? Colors.blue.shade100:Colors.grey.shade100,
                                  border: Border.all(color: (select_cat_controller.isDoctor.value)?Colors.black:Colors.transparent),
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  'assets/images/doctor.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            }
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Text(
                          "Doctor",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenHeight(20),
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            select_cat_controller.updateIsDoctor(k: false);
                          },
                          child: Obx(
                             () {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(10),
                                ),
                                padding: EdgeInsets.all(
                                  getProportionateScreenWidth(20),
                                ),
                                height: getProportionateScreenHeight(120),
                                width: getProportionateScreenWidth(120),
                                decoration: BoxDecoration(
                                  color: (select_cat_controller.isDoctor.value == false)? Colors.blue.shade100:Colors.grey.shade100,
                                  border: Border.all(color: (select_cat_controller.isDoctor.value == false)?Colors.black:Colors.transparent),
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  'assets/images/employee.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            }
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Text(
                          "Employee",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenHeight(20),
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(43)),
                  child: DefaultButton(
                      text: "Continue",
                      press: () {
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
