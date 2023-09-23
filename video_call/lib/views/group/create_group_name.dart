import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:videocall_app/providers/chat_provider.dart';
import 'package:videocall_app/utils/constants/colors.dart';
import 'package:videocall_app/utils/constants/constant.dart';
import 'package:videocall_app/views/widgets/text_field.dart';

class CreateGroupName extends StatefulWidget {
  const CreateGroupName({super.key});

  @override
  State<CreateGroupName> createState() => _CreateGroupNameState();
}

class _CreateGroupNameState extends State<CreateGroupName> {
  TextEditingController gorupNameController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
                      Constants.newGroup,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (formkey.currentState?.validate() == true) {
                          chatProvider.createGroup(
                              context: context,
                              name: gorupNameController.text,
                              description: '',
                              file: chatProvider.newGroupProfile,
                              members: chatProvider.newGroupList.join(','));
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, RoutePath.home, (route) => false);
                        }
                      },
                      child: Text(
                        Constants.create,
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
                      padding: const EdgeInsets.all(18.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Visibility(
                              visible: chatProvider.newGroupProfile == null,
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
                            Visibility(
                              visible: chatProvider.newGroupProfile != null &&
                                  chatProvider.newGroupProfile?.path != null,
                              child: Center(
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
                                      child: Image.asset(
                                        chatProvider.newGroupProfile?.path ??
                                            '',
                                        fit: BoxFit.cover,
                                      ),
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
                          ],
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
    });
  }
}
