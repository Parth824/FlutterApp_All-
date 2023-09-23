import 'package:flutter/material.dart';
import 'package:rentapp/size_config.dart';

import '../../../../components/information_doctor.dart';
import '../../../../components/prnding_transaction_doctor.dart';
import '../../../../components/statement_doctor.dart';


class Infor_Page extends StatefulWidget {
  const Infor_Page({super.key});

  @override
  State<Infor_Page> createState() => _Infor_PageState();
}

class _Infor_PageState extends State<Infor_Page>with SingleTickerProviderStateMixin {
   late TabController tabController;
  PageController pagecontroller = PageController();
  int currentpage = 0;
  int cupertinoindex = 0;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  int initialpage = 0;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> detail =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(title: Text(detail["hospital"]),
      bottom: TabBar(
          indicatorWeight: 3,
          indicatorColor: Colors.white,
          onTap: (val) {
            setState(() {
              currentpage = val;
            });
            pagecontroller.animateToPage(val,
                duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          },
          controller: tabController,
          tabs: [
            Tab(
              child: Text("Information"),
            ),
            Tab(
              child: Text("Pending"),
            ),
            Tab(
              child: Text("Statement"),
            ),
          ],
        ),
      ),
      body:PageView(
        controller: pagecontroller,
        onPageChanged: (val) {
          setState(() {
            currentpage = val;
          });
          tabController.animateTo(val);
        },
        children: [
          InformationDoctor(),
          PendingTransactionDoctor(),
          StatementDoctor(),
        ],
      ),
    );
  }
}