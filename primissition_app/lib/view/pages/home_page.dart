import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

class Permission_app extends StatefulWidget {
  const Permission_app({super.key});

  @override
  State<Permission_app> createState() => _Permission_appState();
}

class _Permission_appState extends State<Permission_app> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Permissions"),
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
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.camera_alt),
            ),
            onTap: () {},
            title: Text("Mic Permission"),
            subtitle: Text("Ststus of Permission: "),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.mic),
            ),
            onTap: () {},
            title: Text("Camera Permission"),
            subtitle: Text("Ststus of Permission: "),
          ),
        ],
      ),
    );
  }
}
