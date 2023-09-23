import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rentapp/views/screens/Doctor/order/order_controller.dart';
import 'package:rentapp/views/screens/Doctor/order/printer_details_screen.dart';

import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../../size_config.dart';
import 'rent_controller.dart';

class Order_Page extends StatefulWidget {
  const Order_Page({super.key});

  static String routeName = "/orderpage";

  @override
  State<Order_Page> createState() => _Order_PageState();
}

class _Order_PageState extends State<Order_Page> {
  List Data = [
    AssetImage("assets/images/xray1.jpg"),
    AssetImage("assets/images/xray2.jpg"),
    AssetImage("assets/images/xray3.jpg"),
    AssetImage("assets/images/xray4.jpg"),
  ];

  final CarouselController carouselController = CarouselController();
  RentController rentController = Get.put(RentController());
  int currenIndex = 0;
  OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Order Page",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * .01,
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: SizeConfig.screenHeight * .28,
                    scrollPhysics: BouncingScrollPhysics(),
                    autoPlay: true,
                    aspectRatio: 2,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      orderController.setIndex(k: index);
                    },
                  ),
                  items: Data.map(
                    (e) => Container(
                      // margin: EdgeInsets.all(MediaQuery.of(context).size.height*.02),
                      margin: EdgeInsets.all(getProportionateScreenHeight(10)),
                      height: SizeConfig.screenHeight * .2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            SizeConfig.screenHeight * .027),
                        image: DecorationImage(image: e),
                      ),
                    ),
                  ).toList(),
                  carouselController: carouselController,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight * .015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: Data.asMap().entries.map((e) {
                return Obx(
                  () => Container(
                    width: orderController.currenIndex == e.key
                        ? SizeConfig.screenHeight * .02
                        : SizeConfig.screenHeight * .01,
                    height: SizeConfig.screenHeight * .01,
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenHeight(10)),
                      color: orderController.currenIndex == e.key
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * .015,
            ),
            FutureBuilder(
              future: orderController
                  .getData(k: {"Id": '${sharedPreferences.getString("Id")}'}),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  return Obx(
                    () => Padding(
                      padding: EdgeInsets.all(getProportionateScreenHeight(12)),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: getProportionateScreenHeight(10),
                            mainAxisExtent: SizeConfig.screenHeight * .3,
                            mainAxisSpacing: getProportionateScreenHeight(10)),
                        itemCount: orderController.Data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                             
                              int j = int.parse(orderController.Data1[0]['Paper_Price']);
                              rentController.Paper.value = 300;
                              rentController.Ink.value = [];
                              rentController.Jally.value = [];
                              rentController.X_raw.value = [];
                              rentController.ink.value =
                                  int.parse(orderController.Data1[0]['Ink_Price']);
                              rentController.jally.value =
                                  int.parse(orderController.Data1[0]['Jelly_Price']);
                              rentController.flims.value =
                                  int.parse(orderController.Data1[0]['Flims_Price']);
                              rentController.setreat(k: j);
                              Navigator.pushNamed(
                                  context, PrinterDetails.routeName,
                                  arguments: orderController.Data[index]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 3),
                                    color: Colors.black38,
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  )
                                ],
                                color: Colors.blue.shade400,
                                borderRadius: BorderRadius.circular(
                                    getProportionateScreenHeight(15)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (orderController.Data[index]['Paper_Photo'] !=
                                          "")
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                getProportionateScreenHeight(
                                                    15)),
                                            topRight: Radius.circular(
                                                getProportionateScreenHeight(
                                                    15)),
                                          ),
                                          child: Image.network(
                                            "https://udservice.shop//Upload/${orderController.Data[index]['Paper_Photo']}",
                                            height:
                                                SizeConfig.screenHeight * .23,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: getProportionateScreenHeight(5),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                          getProportionateScreenHeight(8)),
                                      child: Container(
                                        height: SizeConfig.screenHeight * .07,
                                        child: Center(
                                          child: Text(
                                            orderController.Data[index]['Name'],
                                            style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      16),
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
