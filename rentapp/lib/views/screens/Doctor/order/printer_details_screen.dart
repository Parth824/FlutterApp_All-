import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:rentapp/views/screens/Doctor/order/rent_controller.dart';
import '../../../../size_config.dart';
import 'payment_order_page.dart';

class PrinterDetails extends StatefulWidget {
  const PrinterDetails({super.key});
  static String routeName = "/printerdetails";
  @override
  State<PrinterDetails> createState() => _PrinterDetailsState();
}

class _PrinterDetailsState extends State<PrinterDetails> {
  List Inki = ["BK", "M", "LM", "C", "LC", "YK"];
  List Jelly = ["250 ml", "1 kg", "5 kg"];
  List X_ray_fimli = [
    "8 X 10",
    "10 X 12",
    "11 X 14",
    "14 X 17",
  ];

  RentController rentController = Get.put(RentController());
  Widget InkData({required List Inki}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...Inki.map(
            (e) => Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(2)),
              child: GestureDetector(
                onTap: () {
                  print(e);
                  rentController.setInk(k: e);
                },
                child: Obx(
                  () => Container(
                    height: SizeConfig.screenHeight * 0.05,
                    width: SizeConfig.screenWidth * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: (rentController.Ink.contains(e))
                              ? Colors.blue
                              : Colors.grey,
                          width: getProportionateScreenHeight(2)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      e,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ).toList(),
        ],
      ),
    );
  }

  Widget X_RayData({required List X_ray_fimli}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...X_ray_fimli.map(
            (e) => Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(2)),
              child: GestureDetector(
                onTap: () {
                  rentController.setXraw(k: e);
                },
                child: Obx(
                  () => Container(
                    height: SizeConfig.screenHeight * 0.05,
                    width: SizeConfig.screenWidth * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: (rentController.X_raw.contains(e))
                              ? Colors.blue
                              : Colors.grey,
                          width: getProportionateScreenHeight(2)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      e,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ).toList(),
        ],
      ),
    );
  }

  Widget JellyData({required List Jelly}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...Jelly.map(
            (e) => Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(2)),
              child: GestureDetector(
                onTap: () {
                  rentController.setJayy(k: e);
                },
                child: Obx(
                  () => Container(
                    height: SizeConfig.screenHeight * 0.05,
                    width: SizeConfig.screenWidth * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: (rentController.Jally.contains(e)) ? Colors.blue : Colors.grey,
                          width: getProportionateScreenHeight(2)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      e,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map k = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Rent Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          (k['Paper_Photo'] != "")
              ? ProductImage(k['Paper_Photo'])
              : Container(
                  height: SizeConfig.screenHeight * .3,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      k['Name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(40),
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
          Container(
            padding: EdgeInsets.all(getProportionateScreenHeight(10)),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  k['Name'],
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(22),
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .012,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Paper",
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(16),
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenHeight * .13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              rentController.subPaper();
                            },
                            child: Icon(
                              AntDesign.minussquare,
                              size: getProportionateScreenHeight(25),
                              color: Colors.grey,
                            ),
                          ),
                          Obx(
                            () => Text(
                              "${rentController.Paper}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: getProportionateScreenHeight(18),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              rentController.addPaper();
                            },
                            child: Icon(
                              AntDesign.plussquare,
                              size: getProportionateScreenHeight(25),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .012,
                ),
                Text(
                  "Select Ink",
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(16),
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .012,
                ),
                InkData(
                  Inki: Inki,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .012,
                ),
                Text(
                  "Select Jelly",
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(16),
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .012,
                ),
                JellyData(Jelly: Jelly),
                SizedBox(
                  height: SizeConfig.screenHeight * .012,
                ),
                Text(
                  "Select X-Ray Filmis",
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(16),
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .012,
                ),
                X_RayData(X_ray_fimli: X_ray_fimli),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * .03,
          ),
          Container(
            height: SizeConfig.screenHeight * .09,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(15),
                ),
                Obx(
                  () => Text(
                    "₹ ${rentController.reat}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenHeight(
                        22,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(15),
                ),
                Container(
                  height: SizeConfig.screenHeight * .07,
                  width: SizeConfig.screenWidth * .5,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(PaymentOrderPage.routeName);
                    },
                    child: Text("Rent"),
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                        TextStyle(
                          fontSize: getProportionateScreenHeight(20),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ProductImage(String image) {
    return Container(
      height: SizeConfig.screenHeight * .3,
      width: double.infinity,
      child: Image.network("https://udservice.shop//Upload/$image",
          fit: BoxFit.cover),
    );
  }
}
