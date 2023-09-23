import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class bar_method extends StatelessWidget {
  const bar_method({
    super.key, required this.name, required this.profession,
  });

  final String name, profession;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        profession,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}