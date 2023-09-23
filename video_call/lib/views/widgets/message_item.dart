import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videocall_app/models/chat_model.dart';
import 'package:videocall_app/models/user_model.dart';
import 'package:videocall_app/utils/constants/app_config.dart';
import 'package:videocall_app/utils/constants/colors.dart';
import 'package:videocall_app/views/message.dart';
import 'package:external_path/external_path.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

final imgUrl =
    "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
final Dio dio = Dio();
bool loading = false;
double progress = 0;

class MessageItem extends StatefulWidget {
  // const MessageItem({Key? key, required this.enduser}) : super(key: key);
  const MessageItem(
      {Key? key,
      required this.chatMessage,
      required this.user,
      required this.enduser})
      : super(key: key);

  final Chat chatMessage;
  final UserModel user;
  final dynamic enduser;

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  Future<bool> saveVideo(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          var path = await ExternalPath.getExternalStoragePublicDirectory(
              ExternalPath.DIRECTORY_DOWNLOADS);
          directory = Directory(path);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$fileName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
          setState(() {
            progress = value1 / value2;
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  downloadFile(url) async {
    setState(() {
      loading = true;
      progress = 0;
    });
    File file = new File("${AppConfig.storage_url}${url}");
    String fileName = file.path.split('/').last;

    print(fileName);
    print("${AppConfig.storage_url}${url}");
// return;
    bool downloaded =
        await saveVideo("${AppConfig.storage_url}${url}", "${fileName}");
    if (downloaded) {
      print("File Downloaded");
    } else {
      print("Problem Downloading File");
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    File file = new File("${widget.chatMessage.document}");
    String docName = file.path.split('/').last;
    File audioFile = new File("${widget.chatMessage.audio}");
    String audioName = file.path.split('/').last;
    File videoFile = new File("${widget.chatMessage.video}");
    String videoName = file.path.split('/').last;
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (widget.chatMessage.senderUserId.toString() !=
                widget.user.data.id.toString()
            ? Alignment.topLeft
            : Alignment.topRight),
        child: widget.chatMessage.senderUserId.toString() !=
                widget.user.data.id.toString()
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Visibility(
                    visible: widget.chatMessage.text != null &&
                        widget.chatMessage.text != '',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.lightPurple),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (widget.chatMessage.senderUser != null)
                                    Text(
                                      widget.chatMessage.senderUser?.name ?? '',
                                      style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                  Text(
                                    widget.chatMessage.text ?? '',
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.blackShade2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (widget.chatMessage.document != null) {
                        downloadFile(widget.chatMessage.document);
                      }
                    },
                    child: Visibility(
                      visible: widget.chatMessage.document != null &&
                          widget.chatMessage.document != '',
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.lightPurple),
                          padding: const EdgeInsets.all(12),
                          child: loading
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LinearProgressIndicator(
                                    minHeight: 10,
                                    value: progress,
                                  ),
                                )
                              : const Icon(
                                  Icons.file_copy_outlined,
                                  size: 55,
                                  color: AppColor.blackShade2,
                                )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (widget.chatMessage.audio != null) {
                        downloadFile(widget.chatMessage.audio);
                      }
                    },
                    child: Visibility(
                      visible: widget.chatMessage.audio != null &&
                          widget.chatMessage.audio != '',
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.lightPurple),
                          padding: const EdgeInsets.all(12),
                          child: loading
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LinearProgressIndicator(
                                    minHeight: 10,
                                    value: progress,
                                  ),
                                )
                              : const Icon(
                                  Icons.audio_file_outlined,
                                  size: 55,
                                  color: AppColor.blackShade2,
                                )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (widget.chatMessage.video != null) {
                        downloadFile(widget.chatMessage.video);
                      }
                    },
                    child: Visibility(
                      visible: widget.chatMessage.video != null &&
                          widget.chatMessage.video != '',
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.lightPurple),
                          padding: const EdgeInsets.all(12),
                          child: loading
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LinearProgressIndicator(
                                    minHeight: 10,
                                    value: progress,
                                  ),
                                )
                              : const Icon(
                                  Icons.video_file_outlined,
                                  size: 55,
                                  color: AppColor.blackShade2,
                                )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (_) => imageDialog(
                              'My Image',
                              '${AppConfig.storage_url}${widget.chatMessage.image}',
                              context));
                    },
                    child: Visibility(
                      visible: widget.chatMessage.image != null &&
                          widget.chatMessage.image != '',
                      child: SizedBox(
                        height: 170,
                        width: 120,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              "${AppConfig.storage_url}${widget.chatMessage.image}",
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(widget.chatMessage.createdAt.toLocal().toString(),
                      style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blackShade2))
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Visibility(
                    visible: widget.chatMessage.text != null &&
                        widget.chatMessage.text != '',
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.primary),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.chatMessage.senderUser != null)
                            Text(
                              widget.chatMessage.senderUser?.name ?? '',
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                          Text(
                            widget.chatMessage.text ?? '',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (widget.chatMessage.document != null) {
                        downloadFile(widget.chatMessage.document);
                      }
                    },
                    child: Visibility(
                      visible: widget.chatMessage.document != null &&
                          widget.chatMessage.document != '',
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.primary),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            loading
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: LinearProgressIndicator(
                                      minHeight: 10,
                                      value: progress,
                                    ),
                                  )
                                : const Icon(
                                    Icons.file_copy_outlined,
                                    size: 55,
                                    color: AppColor.white,
                                  ),
                            //     Text(docName, style: GoogleFonts.inter(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.w400,
                            //       color: Colors.white),

                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (widget.chatMessage.audio != null) {
                        downloadFile(widget.chatMessage.audio);
                      }
                    },
                    child: Visibility(
                      visible: widget.chatMessage.audio != null &&
                          widget.chatMessage.audio != '',
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.primary),
                        padding: const EdgeInsets.all(12),
                        child: loading
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: LinearProgressIndicator(
                                  minHeight: 10,
                                  value: progress,
                                ),
                              )
                            : const Icon(
                                Icons.audio_file_outlined,
                                size: 55,
                                color: AppColor.white,
                              ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (widget.chatMessage.video != null) {
                        downloadFile(widget.chatMessage.video);
                      }
                    },
                    child: Visibility(
                      visible: widget.chatMessage.video != null &&
                          widget.chatMessage.video != '',
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.primary),
                          padding: const EdgeInsets.all(12),
                          child: loading
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LinearProgressIndicator(
                                    minHeight: 10,
                                    value: progress,
                                  ),
                                )
                              : const Icon(
                                  Icons.video_file_outlined,
                                  size: 55,
                                  color: AppColor.white,
                                )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (_) => imageDialog(
                              'My Image',
                              '${AppConfig.storage_url}${widget.chatMessage.image}',
                              context));
                    },
                    child: Visibility(
                      visible: widget.chatMessage.image != null &&
                          widget.chatMessage.image != '',
                      child: SizedBox(
                        height: 170,
                        width: 120,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              "${AppConfig.storage_url}${widget.chatMessage.image}",
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(widget.chatMessage.createdAt.toLocal().toString(),
                      style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blackShade2))
                ],
              ),
      ),
    );
  }
}

Widget imageDialog(text, path, context) {
  return Dialog.fullscreen(
    // backgroundColor: Colors.transparent,
    // elevation: 0,

    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$text',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close_rounded),
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
        Visibility(
          visible: path != null && path != '',
          child: SizedBox(
            height: 600,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: "${path}",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child:
                    CircularProgressIndicator(value: downloadProgress.progress),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: () {
            downloadImages(context, path);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 48,
            decoration: BoxDecoration(
                color: AppColor.purple,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.download_outlined,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Download',
                  style: GoogleFonts.viga(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

void downloadImages(context, path) async {
  try {
    // Saved with this method.

    Navigator.of(context).pop();
    // var imageId = await ImageDownloader.downloadImage("$path", outputMimeType: 'image/jpeg', destination: AndroidDestinationType.custom(directory: 'Download'));
    var imageId = await ImageDownloader.downloadImage(path,
        destination: AndroidDestinationType.directoryDownloads
          ..subDirectory("${DateTime.now().toIso8601String()}.png"));
    if (imageId == null) {
      return;
    }
    // Below is a method of obtaining saved image information.
    // var fileName = await ImageDownloader.findName(imageId);
    // var path = await ImageDownloader.findPath(imageId);
    // var size = await ImageDownloader.findByteSize(imageId);
    // var mimeType = await ImageDownloader.findMimeType(imageId);
  } on PlatformException catch (error) {
    print(error.message);
  }
}
