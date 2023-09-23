import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:videocall_app/models/chat_model.dart';
import 'package:videocall_app/providers/chat_provider.dart';
import 'package:videocall_app/utils/constants/app_config.dart';
import 'package:videocall_app/utils/constants/colors.dart';
import 'package:videocall_app/utils/constants/constant.dart';
import 'package:videocall_app/utils/router/router_path.dart';
import 'package:videocall_app/views/widgets/text_field.dart';

class EditGroup extends StatefulWidget {
  const EditGroup({super.key, required this.group});

  final dynamic group;

  @override
  State<EditGroup> createState() => _EditGroupState();
}

class _EditGroupState extends State<EditGroup> {
  late ChatProvider _chatProvider;
  TextEditingController gorupNameController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _chatProvider = Provider.of<ChatProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _chatProvider.clearFileVar();
    });
    gorupNameController.text = widget.group.name;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatProvider, child) {
      if (chatProvider.isLoading) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
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
                      Constants.editGroup,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (formkey.currentState?.validate() == true) {
                          chatProvider.updateGroup(
                              context: context,
                              name: gorupNameController.text,
                              description: '',
                              file: chatProvider.newGroupProfile,
                              groupID: widget.group.id.toString());
                        }
                      },
                      child: Text(
                        Constants.save,
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
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 18, right: 18, left: 18),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Visibility(
                              visible: widget.group.image != null &&
                                  widget.group.image != '' &&
                                  chatProvider.newGroupProfile == null,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    chatProvider.updateNewgroupPicture(
                                        context: context);
                                  },
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "${AppConfig.group_profile_baseurl}${widget.group.image}",
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: chatProvider.newGroupProfile == null &&
                                  (widget.group.image == null ||
                                      widget.group.image == ''),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    chatProvider.updateNewgroupPicture(
                                        context: context);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: AppColor.lightPurple,
                                    radius: 60,
                                    child: Image.asset(
                                      "assets/images/photo.png",
                                      width: 53,
                                      height: 53,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (chatProvider.newGroupProfile != null &&
                                chatProvider.newGroupProfile?.path != null)
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    chatProvider.updateNewgroupPicture(
                                        context: context);
                                  },
                                  child: SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.file(
                                        File(
                                            chatProvider.newGroupProfile!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(
                              height: 25,
                            ),
                            TextFieldWidget(
                              controller: gorupNameController,
                              hintText: Constants.name,
                              validator: (e) {
                                if (e == '') {
                                  return 'invalid value';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutePath.addGroupMember,
                                        arguments: {'group': widget.group});
                                  },
                                  child: const Text(
                                    'Add Memeber',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount:
                                    widget.group.groupMembers?.length ?? 0,
                                itemBuilder: (context, index) {
                                  GroupMember member =
                                      widget.group.groupMembers[index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            if (member.user.profileImage !=
                                                    null &&
                                                member.user.profileImage != '')
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    25,
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    25,
                                                  ),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        "${AppConfig.profile_pic_base_url}${member.user.profileImage}",
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                downloadProgress) =>
                                                            Center(
                                                      child: CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                            Visibility(
                                              visible: member
                                                          .user.profileImage ==
                                                      null ||
                                                  member.user.profileImage ==
                                                      '',
                                              child: CircleAvatar(
                                                radius: 25,
                                                child: Image.asset(
                                                  "assets/images/photo.png",
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              member.user.uniqueId.toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            dynamic res = await chatProvider
                                                .romoveGroupMember(
                                                    groupId: widget.group.id
                                                        .toString(),
                                                    userId: member.user.id
                                                        .toString());

                                            if (res == true) {
                                              (widget.group.groupMembers
                                                      as List<GroupMember>)
                                                  .removeWhere(
                                                (element) =>
                                                    element.user.id ==
                                                    member.user.id,
                                              );
                                              setState(() {});
                                            }
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            size: 18,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
