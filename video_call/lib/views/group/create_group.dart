import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:videocall_app/models/recent_chat_model.dart';
import 'package:videocall_app/providers/chat_provider.dart';
import 'package:videocall_app/utils/constants/app_config.dart';
import 'package:videocall_app/utils/constants/constant.dart';
import 'package:videocall_app/views/widgets/button.dart';
import 'package:videocall_app/views/widgets/flat_button.dart';
import 'package:videocall_app/views/widgets/list_item.dart';

import '../../utils/constants/colors.dart';
import '../../utils/router/router_path.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatProvider, child) {
      return Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Image.asset("assets/images/background.png"),
              Positioned(
                top: 50,
                left: 15,
                right: 15,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      Constants.newGroup,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RoutePath.createGroupName);
                      },
                      child: Text(
                        Constants.next,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                top: 100,
                left: 0,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xFFFFFDFB),
                            Color(0xFFF3F4FF),
                          ],
                        )),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: InkWell(
                            onTap: null,
                            child: Image.asset(
                              "assets/images/bottom.png",
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                        Builder(builder: (context) {
                          List<RecentDatum>? listUsers = chatProvider.recentChat
                              ?.where((element) => element.type != 'group')
                              .toList();
                          return ListView(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: listUsers?.length ?? 0,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  bool isSelected = chatProvider.newGroupList
                                      .any((int element) =>
                                          element ==
                                          listUsers?[index].id as int);
                                  int? id;
                                  if (isSelected) {
                                    id = listUsers?[index].id;
                                  }
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Visibility(
                                                  visible: listUsers?[index]
                                                              .image !=
                                                          null &&
                                                      listUsers?[index].image !=
                                                          '',
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: SizedBox(
                                                      height: 50,
                                                      width: 50,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60),
                                                        child:
                                                            CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl:
                                                              "${AppConfig.profile_pic_base_url}${listUsers?[index].image}",
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                      downloadProgress) =>
                                                                  Center(
                                                            child: CircularProgressIndicator(
                                                                value: downloadProgress
                                                                    .progress),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: listUsers?[index]
                                                              .image ==
                                                          null ||
                                                      listUsers?[index].image ==
                                                          '',
                                                  child: CircleAvatar(
                                                    radius: 25,
                                                    child: Image.asset(
                                                      "assets/images/photo.png",
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      listUsers?[index].name ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Radio(
                                              value: isSelected ? id : 0,
                                              groupValue: listUsers?[index].id,
                                              toggleable: true,
                                              onChanged: (e) {
                                                chatProvider
                                                    .addUserToNewGroupList(
                                                        listUsers![index].id);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1.2,
                                        color: AppColor.lightGrey,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            children: [
              Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.cancel_outlined,
                          color: AppColor.darkGrey,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    Constants.wantToDeleteAccount,
                    style: GoogleFonts.viga(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FlatButtonWidget(
                            title: Constants.no,
                            onTap: () => Navigator.pop(context)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ButtonWidget(
                              onTap: () => Navigator.pop(context),
                              title: Constants.yes))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
