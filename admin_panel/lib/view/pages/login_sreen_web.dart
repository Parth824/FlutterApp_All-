import 'package:admin_panel/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class WedScreenLayout extends StatelessWidget {
  const WedScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: (MediaQuery.of(context).size.width < 900)
            ? Container(
                height: 40.h,
                width: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.5, 0.5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      "YUVAANO",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 50,
                      width: 30.h,
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter Your Email",
                          border: InputBorder.none,
                          icon: Icon(Icons.email),
                          iconColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      height: 50,
                      width: 30.h,
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter Your Password",
                          border: InputBorder.none,
                          icon: Icon(Icons.lock),
                          iconColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(
                          SiteLayout(),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 30.h,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: 50.h,
                width: 70.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(1, 1),
                    ),
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "YUVAANO",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 50,
                      width: 40.h,
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter Your Email",
                          border: InputBorder.none,
                          icon: Icon(Icons.email),
                          iconColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      height: 50,
                      width: 40.h,
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter Your Password",
                          border: InputBorder.none,
                          icon: Icon(Icons.lock),
                          iconColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(
                          SiteLayout(),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 40.h,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
