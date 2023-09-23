import 'package:flutter/material.dart';
import 'package:rentapp/size_config.dart';

class OrderRequest extends StatefulWidget {
  const OrderRequest({super.key});

  static String routeName = '/orderrequest';

  @override
  State<OrderRequest> createState() => _OrderRequestState();
}

class _OrderRequestState extends State<OrderRequest> {
  List orderRequest = [
    {
      "Image": "assets/images/printer1.jpeg",
      "Name": "Cartoon Printer",
      "Paper Type": "A4 210",
      "Ink": "BK",
      "Jelly": "250 ml",
      "Paper Qut": "500",
      "MRP": "₹700",
    },
    {
      "Image": "assets/images/printer2.jpeg",
      "Name": "Inkjet Printer",
      "Paper Type": "A3 300",
      "Ink": "LC",
      "Jelly": "1 kg",
      "Paper Qut": "500",
      "MRP": "₹700",
    },
    {
      "Image": "assets/images/printer3.jpeg",
      "Name": "Cartoon Printer",
      "Paper Type": "A4 1024",
      "Ink": "C",
      "Jelly": "5 kg",
      "Paper Qut": "500",
      "MRP": "₹700",
    },
    {
      "Image": "assets/images/printer1.jpeg",
      "Name": "Cartoon Printer",
      "Paper Type": "A4 210",
      "Ink": "BK",
      "Jelly": "250 ml",
      "Paper Qut": "500",
      "MRP": "₹700",
    },
    {
      "Image": "assets/images/printer2.jpeg",
      "Name": "Inkjet Printer",
      "Paper Type": "A3 300",
      "Ink": "LC",
      "Jelly": "1 kg",
      "Paper Qut": "500",
      "MRP": "₹700",
    },
    {
      "Image": "assets/images/printer3.jpeg",
      "Name": "Cartoon Printer1",
      "Paper Type": "A4 1024",
      "Ink": "C",
      "Jelly": "5 kg",
      "Paper Qut": "500",
      "MRP": "₹700",
    },
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      
      body: SingleChildScrollView(
        child: ListView.builder(
          reverse: true,
          itemCount: orderRequest.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(10)),
              child: Container(
                height: SizeConfig.screenHeight * .21,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenHeight(10)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 5),
                      color: Colors.black26,
                      spreadRadius: 2,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    titleBar(index: orderRequest[index]),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: SizeConfig.screenHeight * 0.15,
                              padding: EdgeInsets.only(
                                left: getProportionateScreenHeight(5),
                                top: getProportionateScreenHeight(0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  typeData("Paper Type",
                                      orderRequest[index]['Paper Type'],Colors.black,Colors.grey),
                                  typeData("Ink", orderRequest[index]['Ink'],Colors.black,Colors.grey),
                                  typeData(
                                      "Jelly", orderRequest[index]['Jelly'],Colors.black,Colors.grey),
                                  typeData("Paper Qut",
                                      orderRequest[index]['Paper Qut'],Colors.black,Colors.grey),
                                  typeData("M.R.P", orderRequest[index]['MRP'],Colors.green,Colors.green),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {},
                                      child: Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Text(
                                        
                                        "Confirm",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  typeData(String name, String type, Color HedingColor, Color ValueColor) {
    return Row(
      children: [
        Container(
          width: SizeConfig.screenWidth * .25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(14),
                  // fontWeight: FontWeight.bold,
                  color: HedingColor,
                ),
              ),
              Text(
                ":",
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(14),
                  // fontWeight: FontWeight.bold,
                  color: HedingColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: SizeConfig.screenHeight * .02,
        ),
        Text(
          type,
          style: TextStyle(
              fontSize: getProportionateScreenHeight(13),
              // fontWeight: FontWeight.w500,
              color: ValueColor),
        ),
      ],
    );
  }
}

class titleBar extends StatelessWidget {
  const titleBar({
    super.key,
    required this.index,
  });

  final Map index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              getProportionateScreenHeight(10),
            ),
          ),
          child: Container(
            width: SizeConfig.screenWidth * .4,
            // height: double.infinity,
            child: Image.asset(index['Image'], fit: BoxFit.contain),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: getProportionateScreenHeight(5),
              top: getProportionateScreenHeight(5),
              bottom: getProportionateScreenHeight(1.5),
            ),

            width: SizeConfig.screenWidth * .4,
            // height: ,
            child: Text(
              index["Name"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getProportionateScreenHeight(13),
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

