import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:videocall_app/providers/auth_provider.dart';
import 'package:videocall_app/utils/constants/app_config.dart';
import 'package:videocall_app/utils/constants/colors.dart';
import 'package:videocall_app/utils/constants/constant.dart';
import 'package:videocall_app/views/widgets/button.dart';
import 'package:videocall_app/views/widgets/flat_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      if (authProvider.isLoading) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }

      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.asset("assets/images/background.png"),
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Text(
                Constants.userProfile,
                textAlign: TextAlign.center,
                style: GoogleFonts.viga(fontSize: 20),
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
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            const Spacer(),
                            Visibility(
                              visible: authProvider.user != null &&
                                  authProvider.user?.data.profileImage != null,
                              child: GestureDetector(
                                onTap: () {
                                  authProvider.updateProfilePicture(
                                      context: context);
                                },
                                child: SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          "${AppConfig.profile_pic_base_url}${authProvider.user?.data.profileImage}",
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  authProvider.user?.data.profileImage == null,
                              child: GestureDetector(
                                onTap: () {
                                  authProvider.updateProfilePicture(
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
                            ), //
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              authProvider.user?.data.uniqueId ?? '',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.viga(fontSize: 24),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "id : ${authProvider.user?.data.uniqueId ?? ''}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.viga(
                                  fontSize: 14, color: AppColor.grey),
                            ),
                            // Text(
                            //   "Gender : ${authProvider.user?.data.gender ?? ''}",
                            //   textAlign: TextAlign.center,
                            //   style: GoogleFonts.viga(
                            //       fontSize: 14, color: AppColor.grey),
                            // ),
                            Text(
                              "Reset Password Keyword : ${(authProvider.user?.data.friendName)}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.viga(
                                  fontSize: 14, color: AppColor.grey),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                showBottomSheet(context);
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
                                      Icons.delete_outline_outlined,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      Constants.deleteAccount,
                                      style: GoogleFonts.viga(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FlatButtonWidget(
                              title: Constants.logout,
                              onTap: () {
                                authProvider.logout(context: context);
                              },
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
