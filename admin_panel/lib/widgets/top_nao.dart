import 'package:admin_panel/helpers/responsiveness.dart';
import 'package:flutter/material.dart';

AppBar topNavigationBar(context, GlobalKey<ScaffoldState> key) => AppBar(
      leading: !ResponsivenessWidget.isSmallScreen(context)
          ? Row()
          : IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_circle_outline_sharp),
            ),
      elevation: 0,
      backgroundColor: Colors.white,
    );
