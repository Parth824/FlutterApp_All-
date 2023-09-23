import 'package:admin_panel/helpers/responsiveness.dart';
import 'package:admin_panel/widgets/large_screen.dart';
import 'package:admin_panel/widgets/small_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'widgets/top_nao.dart';

class SiteLayout extends StatelessWidget {
  
 final GlobalKey<ScaffoldState> Scaffoldkey = GlobalKey();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topNavigationBar(context, Scaffoldkey),
      body: ResponsivenessWidget(
        largeScreen: LargeScreen(),
        samllScreen: SmallScreen(),
      ),
    );
  }
}
