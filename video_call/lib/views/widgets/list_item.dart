import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videocall_app/utils/constants/app_config.dart';
import 'package:videocall_app/utils/constants/colors.dart';

class ListItem extends StatelessWidget {
  final dynamic title;
  final String subTitle;
  final String? profilePic;
  final VoidCallback onTap;
  final String chatType;
  final int unreadCound;
  const ListItem({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.profilePic,
    required this.onTap,
    required this.chatType,
    required this.unreadCound,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: profilePic != null &&
                      profilePic != '' &&
                      chatType == 'group',
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            "${AppConfig.group_profile_baseurl}$profilePic",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: profilePic != null &&
                      profilePic != '' &&
                      chatType == 'personal',
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            "${AppConfig.profile_pic_base_url}$profilePic",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: profilePic == null || profilePic == '',
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
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title.toString(),
                            textAlign: TextAlign.right,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            subTitle,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackShade1,
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: unreadCound > 0,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              unreadCound.toString(),
                              style: const TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 1.2,
          color: AppColor.lightGrey,
        )
      ],
    );
  }
}
