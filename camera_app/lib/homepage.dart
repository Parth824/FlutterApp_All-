import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  late CameraController cameraController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startCamera();
  }

  void startCamera() async {
    cameraController =
        CameraController(cameras[1], ResolutionPreset.high, enableAudio: false);

    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          (cameraController.value.hasError)?SizedBox(
            height: MediaQuery.of(context).size.height,
          ):CameraPreview(cameraController),
        ],
      ),
    );
  }
}
