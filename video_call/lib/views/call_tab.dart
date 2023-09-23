import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:videocall_app/data/dio_api_service.dart';
import 'package:videocall_app/models/call_history_model.dart';
import 'package:videocall_app/providers/auth_provider.dart';
import 'package:videocall_app/utils/constants/app_config.dart';
import 'package:videocall_app/utils/constants/constant.dart';
import 'package:videocall_app/utils/search_delay_function.dart';
import 'package:videocall_app/utils/shared_pref.dart';
import 'package:videocall_app/utils/utils.dart';
import 'package:videocall_app/views/widgets/button.dart';
import 'package:videocall_app/views/widgets/flat_button.dart';
import 'package:badges/badges.dart' as badges;

import '../utils/constants/colors.dart';
import '../utils/router/router_path.dart';

class CallTab extends StatefulWidget {
  const CallTab({Key? key}) : super(key: key);

  @override
  State<CallTab> createState() => _CallTabState();
}

class _CallTabState extends State<CallTab> {
  late AuthProvider _authProvider;
  List<CallHistory>? callHistoryList;
  String search = "";
  final searchDelay = SearchDelayFunction();

  List<String> notiList = [];
  var a;
  fetchLocalNotiList() {
    var _i = SharedPref.instance.shared.getString('notifications_list');
    List<dynamic> list = _i != null ? jsonDecode(_i)['notifications'] : [];
    if (list.isNotEmpty) {
      for (var e in list) {
        String username = e['title'];
        String notificationType = e['notification_type'];
        String callType = e['call_type'];
        String adminMsg = e['body'];

        // if (callType == 'call') {
        //   String str = "$username called you....";
        //   notiList.add(str);
        // }
        if (notificationType == 'incoming_call') {
          String str = "$username called you....";
          notiList.add(str);
        }
        if (notificationType == 'admin_message') {
          String str = username + ": " + adminMsg;
          notiList.add(str);
        }
        if (notificationType == 'text_message') {
          String str = "$username text message you....";
          notiList.add(str);
        }
      }
    }
    a = notiList.length.toString();
  }

  @override
  void initState() {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    init();
    super.initState();
    fetchLocalNotiList();
  }

  Future<void> init() async {
    // var localUserId = SharedPref.instance.shared.getInt('login_user_id');
    if (_authProvider.user != null) {
      dynamic response = await DioApiService.getCallHistory(
          _authProvider.user!.data.id.toString(), search);
      if (response is CallHistoryModel) {
        callHistoryList = [];
        if (response.data != null) {
          callHistoryList!.addAll(response.data!);
        }
        setState(() {});
      }
    } else {
      _authProvider.fetchUser(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Image.asset("assets/images/backgrounds.png"),
          Positioned(
            top: 50,
            left: 15,
            right: 15,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      Constants.calls,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.viga(fontSize: 20),
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutePath.notifications);
                        },
                        child: a == '0'
                            ? Image.asset(
                                "assets/images/notification.png",
                                width: 24,
                                height: 24,
                              )
                            : badges.Badge(
                                badgeContent: Text(a,
                                    style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w600)),
                                child: Image.asset(
                                  "assets/images/notification.png",
                                  width: 24,
                                  height: 24,
                                ),
                              )
                        //       Image.asset(
                        //   "assets/images/notification.png",
                        //   width: 24,
                        //   height: 24,
                        // ),
                        )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColor.primary,
                    ),
                    hintText: Constants.search,
                    hintStyle: GoogleFonts.viga(fontSize: 14),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: AppColor.darkGrey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: AppColor.lightGrey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  onChanged: (s) {
                    search = s;
                    searchDelay.run(() {
                      init();
                    });
                  },
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: 150,
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
                    if (callHistoryList != null)
                      ListView(
                        children: [
                          ListView.separated(
                              separatorBuilder: (context, index) {
                                return Divider(
                                  height: 1,
                                  color: Colors.blueGrey,
                                );
                              },
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: callHistoryList!.length,
                              itemBuilder: (context, index) {
                                debugPrint(Utils.utcToLocal(
                                    callHistoryList![index]
                                        .createdAt
                                        .toString()));
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                "${AppConfig.profile_pic_base_url}${callHistoryList![index].userDetail!.profileImage}",
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Center(
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            callHistoryList![index]
                                                .name
                                                .toString(),
                                            textAlign: TextAlign.right,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            Utils.utcToLocal(
                                                callHistoryList![index]
                                                    .createdAt
                                                    .toString()),
                                            textAlign: TextAlign.right,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.blackShade1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
