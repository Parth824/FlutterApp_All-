import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';
import 'package:sidebar_menu/bar_method.dart';

class SidebarPage extends StatefulWidget {
  const SidebarPage({super.key});

  @override
  State<SidebarPage> createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Color(0xff17203A),
        child: SafeArea(
          child: Column(
            children: [
              bar_method(name: "Parth Dhameliya", profession: "Develper"),
              ListTile(
                leading: SizedBox(
                  height: 34,
                  width: 34,
                  child: RiveAnimation.asset(""),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
