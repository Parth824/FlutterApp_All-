import 'dart:io';

import 'package:chat_gpt/constant/app_icon.dart';
import 'package:chat_gpt/screens/chat_pages/chat_screen.dart';
import 'package:chat_gpt/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../modals/all_modal.dart';
import '../../utils/app_keys.dart';
import '../../widgets/app_textfield.dart';
import '../chat_pages/chat_controller.dart';
import '../hisrory_image_pages/history_dcreen.dart';
import '../history_pages/history_screen.dart';
import '../search_images_pages/search_images_screen.dart';
import '../setting_pages/setting_page_controller.dart';
import '../setting_pages/setting_screen.dart';
import 'home_screen_controller.dart';

int messageLimit = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int messageLimit = maxMessageLimit;

  SettingPageController settingPageController =
      Get.put(SettingPageController());
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  ChatController chatScreenController = Get.put(ChatController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FocusScope.of(context).requestFocus(inputNode);
    getMessageLimit();
    storeMessage(messageLimit);
  }

  getMessageLimit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    messageLimit = prefs.getInt('messageLimit') ?? maxMessageLimit;
    print('messageLimit -->${messageLimit}');
    setState(() {});
  }

  // bottomSheetToAdsPremium(BuildContext context,
  //     {required VoidCallback adsOnTap}) {
  //   return showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: 700,
  //         child: AlertDialog(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //           contentPadding:
  //               const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //           backgroundColor: Colors.white,
  //           title: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               const CircleAvatar(
  //                 radius: 12,
  //                 backgroundColor: Colors.white,
  //                 child: Icon(
  //                   Icons.close,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //               const Text(
  //                 "Unlock feature",
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.w700,
  //                     fontSize: 17),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   Get.back();
  //                 },
  //                 child: const CircleAvatar(
  //                   radius: 12,
  //                   backgroundColor: Color(0xffE7E7E8),
  //                   child:
  //                       Icon(Icons.close, color: Color(0xff7F7F83), size: 18),
  //                 ),
  //               )
  //             ],
  //           ),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               5.0.addHSpace(),
  //               GestureDetector(
  //                 onTap: adsOnTap,
  //                 child: Container(
  //                   padding: const EdgeInsets.symmetric(vertical: 10),
  //                   // height: 50,
  //                   width: double.infinity,
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(10),
  //                       border: Border.all(color: Colors.black, width: 1.5)),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     mainAxisSize: MainAxisSize.max,
  //                     children: [
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Container(
  //                                 height: 24,
  //                                 width: 24,
  //                                 child:  AppIcon.videoRecordingIcon().marginOnly(left: 5,right: 5),
  //                                 decoration: BoxDecoration(
  //                                   shape: BoxShape.circle,
  //                                     border: Border.all(color: Colors.black)),
  //                               ),
  //                               // AppIcon.videoRecordingIcon(),
  //                               3.0.addWSpace(),
  //                               const Text('Watch ad for 10 free message',
  //                                   style: TextStyle(
  //                                       fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold))
  //                             ],
  //                           ),
  //                           5.0.addHSpace(),
  //                           const Text("Unlock for free",
  //                               style: TextStyle(
  //                                   color: Colors.black, fontSize: 12)),
  //                           10.0.addHSpace(),
  //                           Row(mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               const Text("10 message",
  //                                   style: TextStyle(
  //                                       color: Colors.black, fontSize: 12),textAlign:TextAlign.center).marginOnly(left: 80,top: 10),
  //                             ],
  //                           ),

  //                         ],
  //                       ).marginOnly(left: 10, top: 5, bottom: 5),
  //                       const Icon(Icons.arrow_forward_ios_outlined,
  //                               size: 14, color: Colors.black)
  //                           .marginOnly(right: 5)
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  bool isColor = false;
  FocusNode inputNode = FocusNode();

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        title: appBarTitle(context).marginOnly(left: 20),
        backgroundColor: context.theme.backgroundColor,
        actions: [
          // premiumScreenController.isPremium == false ? Container() : IconButton(onPressed: (){Get.to(const ImageGenerationScreen(),transition: Transition.rightToLeft);}, icon: AppIcon.aiImageIcon(context)),
          // GestureDetector(
          //   onTap: () {
          //     // bottomSheetToAdsPremium(context, adsOnTap: () {
          //     //   Navigator.pop(context);
          //     //   print('addd');
          //     // });
          //     // showRewardedAd();
          //     ;
          //   },
          //   child: CircleAvatar(
          //     radius: 17,
          //     backgroundColor: Colors.white54,
          //     child: Text(
          //       '${messageLimit}',
          //       style:
          //           TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // ).marginOnly(right: 5),
          IconButton(
            onPressed: () {
              Get.to(const ImageGenerationScreen(),
                  transition: Transition.rightToLeft);
            },
            icon:
                showImage == true ? AppIcon.aiImageIcon(context) : Container(),
          ),

          IconButton(
              onPressed: () {
                Get.to(const HistoryScreen(),
                    transition: Transition.rightToLeft);
              },
              icon: AppIcon.historyIcon(context)),

          IconButton(
            onPressed: () {
              Get.to(const HistoryImageScreen(), transition: Transition.rightToLeft);
            },
            icon: AppIcon.historyIcon(context),
          ),

          IconButton(
              onPressed: () {
                Get.offAll(const SettingScreen(), transition: Transition.fade);
              },
              icon: AppIcon.settingIcon(context)),
        ],
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<HomeScreenController>(
            assignId: true,
            builder: (logic) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.0.addHSpace(),
                      Obx(() => homeScreenController.isLoading.value == true
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: const Center(
                                  child: CircularProgressIndicator()))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        homeScreenController
                                            .categoriesList.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(inputNode);
                                                homeScreenController
                                                    .onChangeIndex(
                                                        index,
                                                        homeScreenController
                                                                .categoriesList[
                                                            index]);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 9,
                                                        horizontal: 15),
                                                decoration: BoxDecoration(
                                                    color: homeScreenController
                                                                .selectedIndex
                                                                .value ==
                                                            index
                                                        ? const Color(
                                                            0xff3FB085)
                                                        : context
                                                            .theme.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Text(
                                                    homeScreenController
                                                                .categoriesList[
                                                            index] ??
                                                        "",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                              ).marginOnly(left: 10),
                                            )),
                                  ),
                                ).marginOnly(left: 8, right: 8),

                                // Obx(() {
                                //   return SingleChildScrollView(
                                //     physics: const BouncingScrollPhysics(),
                                //     scrollDirection: Axis.horizontal,
                                //     child: Row(
                                //       children: List.generate(
                                //           homeScreenController.categoriesList.length, (index) =>
                                //           GestureDetector(
                                //             onTap: () {
                                //               homeScreenController.onChangeIndex(index,homeScreenController.categoriesList[index]);
                                //             },
                                //             child: Container(
                                //               padding: const EdgeInsets.symmetric(
                                //                   vertical: 9, horizontal: 15),
                                //               decoration: BoxDecoration(
                                //                   color: homeScreenController.selectedIndex.value == index
                                //                       ?
                                //                   const Color(0xff3FB085)
                                //                       :
                                //                   context.theme.primaryColor,
                                //                   borderRadius: BorderRadius.circular(
                                //                       8)),
                                //               child: Text(homeScreenController
                                //                   .categoriesList[index] ?? "",
                                //                   style: const TextStyle(
                                //                       color: Colors.white,
                                //                       fontSize: 14,
                                //                       fontWeight: FontWeight.w700)),
                                //             ).marginOnly(left: 10),
                                //           )),
                                //     ),).marginOnly(left: 8);
                                // }),

                                10.0.addHSpace(),

                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: chatGPTList.length,
                                    itemBuilder: (context, index) {
                                      return chatGPTList[index].name ==
                                              homeScreenController.selectedText
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: chatGPTList[index]
                                                  .categoriesData
                                                  .length,
                                              itemBuilder: (context, i) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    // FocusScope.of(context).requestFocus(inputNode);
                                                    // _interstitialAd?.show();
                                                    // _loadInterstitialAd();
                                                    // messageController.text = chatGPTList[index].categoriesData[i].question;
                                                    // setState(() {});
                                                    //
                                                    // messageController.text = chatGPTList[index].categoriesData[i].question;
                                                    // setState(() {});

                                                    // _interstitialAd?.show();
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            inputNode);
                                                    // _loadInterstitialAd();
                                                    messageController.text =
                                                        chatGPTList[index]
                                                            .categoriesData[i]
                                                            .question;
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 15),
                                                    decoration: BoxDecoration(
                                                        color: context
                                                            .theme.primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          chatGPTList[index]
                                                              .categoriesData[i]
                                                              .title,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        7.0.addHSpace(),
                                                        Text(
                                                          chatGPTList[index]
                                                              .categoriesData[i]
                                                              .description,
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xff9193A2),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ).marginSymmetric(
                                                        horizontal: 10),
                                                  ).marginSymmetric(
                                                      horizontal: 18,
                                                      vertical: 5),
                                                );
                                              })
                                          : Container();
                                    }),

                                10.0.addHSpace(),
                              ],
                            ))
                    ],
                  ),
                ),
              );
            },
          ),
          Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: context.isDarkMode == false
                        ? const Color(0xffEDEDED)
                        : Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            AppTextField(
                              focusNod: inputNode,
                              controller: messageController,
                              onChanged: (value) {
                                value.isEmpty
                                    ? isColor = false
                                    : isColor = true;
                                setState(() {});
                              },
                              maxLines: messageController.text.length < 10
                                  ? messageController.text.length < 20
                                      ? 3
                                      : 1
                                  : 2,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            // if (messageController.text.isNotEmpty) {
                            //   Get.to(
                            //       ChatScreen(message: messageController.text),
                            //       transition: Transition.rightToLeft);
                            //   messageController.clear();
                            // } else {
                            //   Fluttertoast.showToast(
                            //       msg: "pleaseEnterText".tr,
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.SNACKBAR,
                            //       timeInSecForIosWeb: 1,
                            //       backgroundColor: Colors.white,
                            //       textColor: Colors.black,
                            //       fontSize: 16.0);
                            // }

                            hideKeyboard(context);

                            if (messageLimit == 0) {
                              showToast(text: 'Please watch ads'.tr);
                            } else if (messageController.text.isNotEmpty) {
                              messageLimit == 0 ? null : messageLimit--;
                              await storeMessage(messageLimit);
                              Get.offAll(
                                  ChatScreen(message: messageController.text),
                                  transition: Transition.rightToLeft);
                              setState(() {
                                print('messageLimit -->${maxMessageLimit}');
                              });
                              messageController.clear();
                            } else {
                              showToast(text: 'pleaseEnterText'.tr);
                            }
                          },
                          icon: Icon(
                            Icons.send,
                            color: isColor
                                ? Colors.green
                                : const Color(0xffABAABA),
                          )),
                    ],
                  )).marginSymmetric(horizontal: 15, vertical: 10),
            ],
          ),
        ],
      ),
    );
  }

  storeMessage(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('messageLimit', value);
    // maxMessageLimit = prefs.getInt('messageLimit') ?? maxMessageLimit;
    // print('-------------->maxMessageLimit${maxMessageLimit}');
    // setState(() {});
  }
}
