import 'package:flutter/material.dart';

Future imageSourcePicker(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      actions: <Widget>[
        SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Icon(Icons.camera), Text('Camera')],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, false);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Icon(Icons.file_upload), Text('Files')],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
