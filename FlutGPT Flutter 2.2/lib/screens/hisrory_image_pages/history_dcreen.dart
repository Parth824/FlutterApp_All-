import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_gpt/constant/app_icon.dart';
import 'package:chat_gpt/main.dart';
import 'package:chat_gpt/screens/hisrory_image_pages/history_image_screen_controller.dart';
import 'package:chat_gpt/screens/hisrory_image_pages/view_history_page.dart';
import 'package:chat_gpt/screens/home_pages/home_screen.dart';
import 'package:chat_gpt/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';

class HistoryImageScreen extends StatefulWidget {
  const HistoryImageScreen({super.key});

  @override
  State<HistoryImageScreen> createState() => _HistoryImageScreenState();
}

class _HistoryImageScreenState extends State<HistoryImageScreen> {
  HistoryImageController historyImageController =
      Get.put(HistoryImageController());
  Uint8List? data1;
  Future readNetworkImage(String imageUrl) async {
    final ByteData data =
        await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl);
    final Uint8List bytes = data.buffer.asUint8List();
    data1 = bytes;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(const HomeScreen(), transition: Transition.leftToRight);
        return true;
      },
      child: Scaffold(
          backgroundColor: context.theme.backgroundColor,
          appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Get.offAll(const HomeScreen(),
                      transition: Transition.leftToRight);
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: context.textTheme.headline1!.color,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    if (historyImageController.Data.isNotEmpty) {
                      showAppDialog(context);
                    } else {
                      showToast(text: 'historyEmpty'.tr);
                    }
                  },
                  icon: AppIcon.deleteIcon(context),
                )
              ],
              backgroundColor: context.theme.backgroundColor,
              centerTitle: true,
              // leading: IconButton(
              // onPressed: (){
              //   Get.offAll(
              //       const HomeScreen(),
              //       transition: Transition.leftToRight);
              //   }, icon: const Icon(Icons.arrow_back_rounded)),`
              title: Text("history".tr,
                  style: TextStyle(
                      color: context.textTheme.headline1!.color,
                      fontWeight: FontWeight.w500))),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              FutureBuilder(
                future: historyImageController
                    .getImage(k: {"U_Id": sharedPreferences!.getString('id')}),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    return Obx(() => (historyImageController.Data.isEmpty)
                        ? Center(
                            child: Text("noData".tr,
                                style: TextStyle(
                                    color: context.textTheme.headline1!.color)))
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // childAspectRatio: (0.45 / 0.5),
                              // crossAxisSpacing: 10,
                              // mainAxisSpacing: 10
                            ),
                            itemCount: historyImageController.Data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  await readNetworkImage(historyImageController
                                      .Data[index]['Image']);

                                  Get.to(
                                      ImageHistoeyView(
                                        image: historyImageController
                                            .Data[index]['Image'],
                                            data1: data1!
                                      ),
                                      transition: Transition.rightToLeft);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Stack(
                                    // alignment: Alignment.bottomRight,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            "https://unextenuated-flower.000webhostapp.com/chatGpt/uploads/${historyImageController.Data[index]['Image']}",

                                        // fit: BoxFit.fill,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: context.textTheme
                                                    .headline1!.color)),
                                        errorWidget: (context, error, u) =>
                                            Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color: context.textTheme
                                                            .headline1!.color)),
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              // try {
                                              //   var response = await Dio().get(
                                              //       searchScreenController.imageList[index],
                                              //       options: Options(responseType: ResponseType.bytes));
                                              //   await ImageGallerySaver.saveImage(Uint8List.fromList(response.data)
                                              //   );
                                              // } catch (e) {
                                              //   print(
                                              //       '----------> Image  Store Error -> $e');
                                              // }
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff7C9AAC)),
                                              child: Icon(Icons.edit),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              // try {
                                              //   var response = await Dio().get(
                                              //       searchScreenController.imageList[index],
                                              //       options: Options(responseType: ResponseType.bytes));
                                              //   await ImageGallerySaver.saveImage(Uint8List.fromList(response.data)
                                              //   );
                                              // } catch (e) {
                                              //   print(
                                              //       '----------> Image  Store Error -> $e');
                                              // }

                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await historyImageController
                                                  .DeleteOne(k: {
                                                "I_Id": historyImageController
                                                    .Data[index]['I_Id']
                                              });
                                              await historyImageController
                                                  .getImage(k: {
                                                "U_Id": prefs.getString('id')
                                              });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff7C9AAC)),
                                              child: Icon(Icons.delete),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.end,
                                      //   children: [
                                      //
                                      //     IconButton(
                                      //         onPressed: () async {
                                      //       try {
                                      //         int i = Random().nextInt(30);
                                      //         Directory tempDir = await getTemporaryDirectory();
                                      //         final path = '${tempDir.path}/$i.jpeg';
                                      //         await Dio().download(
                                      //             searchScreenController
                                      //                 .imageList[index], path);
                                      //         Share.shareFiles([path]);
                                      //       } catch (e) {
                                      //         print("Share File ------> $e");
                                      //       }
                                      //     },
                                      //         icon: const Icon(Icons.share,
                                      //           color: Color(0xff7E30A1),)),
                                      //
                                      //
                                      //     IconButton(onPressed: () async {
                                      //       try {
                                      //         var response = await Dio().get(
                                      //             searchScreenController
                                      //                 .imageList[index],
                                      //             options: Options(
                                      //                 responseType: ResponseType
                                      //                     .bytes));
                                      //         await ImageGallerySaver.saveImage(
                                      //             Uint8List.fromList(response.data)
                                      //         );
                                      //       } catch (e) {
                                      //         print(
                                      //             '----------> Image  Store Error -> $e');
                                      //       }
                                      //     },
                                      //         icon: const Icon(Icons.save,
                                      //           color: Color(0xff7E30A1),)),
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ),
                              ).marginAll(3);
                            }));
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          )),
    );
  }

  showAppDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'doYouDelete'.tr,
            style: TextStyle(color: context.textTheme.headline1!.color),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('areYouConfirm'.tr,
                    style:
                        TextStyle(color: context.textTheme.headline1!.color)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('confirm'.tr),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await historyImageController.DeleteAll(
                    k: {"U_Id": prefs.getString('id')});
                await historyImageController
                    .getImage(k: {"U_Id": prefs.getString('id')});
                // studentList.removeAt(index);
                setState(() {});
                Get.back();
              },
            ),
            TextButton(
              child: Text('cancel'.tr),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
