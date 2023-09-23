import 'dart:async';
import 'package:count_provider_app/control/countprovider.dart';
import 'package:count_provider_app/control/themachnager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // final countProvider = Provider.of<CountProvider>(context, listen: false);
    print("Parth");
    print("Dhameliya");
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider App"),
        actions: [
          Switch(
            value: Provider.of<ThemaProvier>(context).themMode.isDrak,
            onChanged: (val) {
              Provider.of<ThemaProvier>(context,listen: false).ChnageThame();
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "${Provider.of<CountProvider>(context).counter1.counter}",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CountProvider>(context, listen: false).add();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
