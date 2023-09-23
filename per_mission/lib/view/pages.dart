import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Permission"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.mic),
            ),
            onTap: () async {
              PermissionStatus  mic = await Permission.microphone.request();
            },
            title: Text("Mic Permission"),
            subtitle: Text("Ststus of Permission: "),
            
          ),
        ],
      ),
    );
  }
}