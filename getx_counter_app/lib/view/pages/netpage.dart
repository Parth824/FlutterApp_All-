import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_counter_app/controler/countercontoraler.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  CounterControler counterControler = Get.find<CounterControler>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Getx State"),
        centerTitle: true,
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
