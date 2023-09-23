import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:chat_gpt/utils/extension.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_gpt/screens/hisrory_image_pages/history_image_screen_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:image_editor_plus/image_editor_plus.dart';

class ImageHistoeyView extends StatelessWidget {
  String image;
  Uint8List data1;
  ImageHistoeyView({super.key, required this.image, required this.data1});

  Widget build(BuildContext context) {
    HistoryImageController historyImageController =
        Get.put(HistoryImageController());
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Stack(children: [
        Center(
            child: CachedNetworkImage(
          imageUrl:
              "https://unextenuated-flower.000webhostapp.com/chatGpt/uploads/$image",
          placeholder: (context, url) => Center(
              child: Container(
                  height: 20,
                  width: 20,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: context.textTheme.headline1!.color))),
        )),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back_ios_new_rounded,
                      color: context.textTheme.headline1!.color, size: 18),
                  5.0.addWSpace(),
                  Text(
                    'imagePreview'.tr,
                    style: TextStyle(
                        color: context.textTheme.headline1!.color,
                        fontSize: 18),
                  )
                ],
              ).marginOnly(top: 50, left: 20),
            ),
            Row(
              children: [
                button(
                    text: "editor".tr,
                    onTap: () async {
                      // var editedImage = await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ImageEditor(
                      //       image: data1,
                      //     ),
                      //   ),
                      // );

                      // replace with edited image
                      // if (editedImage != null) {
                      //   data1 = editedImage;
                      // }
                    }),
                button(
                    text: "save".tr,
                    onTap: () async {
                      try {
                        var response = await Dio().get(image,
                            options: Options(responseType: ResponseType.bytes));
                        await ImageGallerySaver.saveImage(
                            Uint8List.fromList(response.data));
                      } catch (e) {
                        print('----------> Image  Store Error -> $e');
                      }
                    }),
              ],
            ).marginSymmetric(horizontal: 20, vertical: 15)
          ],
        )
      ]),
    );
  }

  Widget button({required String text, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: const Color(0xff56CBFF),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.w800),
          )),
        ).marginAll(3),
      ),
    );
  }
}
