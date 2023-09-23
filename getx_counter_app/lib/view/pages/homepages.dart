import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_counter_app/controler/countercontoraler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CounterControler counterControler = Get.put(
    CounterControler(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Getx State"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/Next");
            },
            icon: Icon(
              Icons.arrow_forward_ios,
            ),
          )
        ],
      ),
      floatingActionButton: GetBuilder<CounterControler>(
        builder: (counterControler) {
          return FloatingActionButton(
            onPressed: () {
              counterControler.add();
            },
            child: Icon(Icons.add),
          );
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder<CounterControler>(
              builder: (counterControler) {
                return Text("${counterControler.count.c}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
