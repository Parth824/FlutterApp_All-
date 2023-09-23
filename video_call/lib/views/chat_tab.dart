import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:videocall_app/main.dart';
import 'package:videocall_app/providers/chat_provider.dart';
import 'package:videocall_app/utils/constants/colors.dart';
import 'package:videocall_app/utils/constants/constant.dart';
import 'package:videocall_app/utils/data_type_extension.dart';
import 'package:videocall_app/utils/router/router_path.dart';
import 'package:videocall_app/utils/shared_pref.dart';
import 'package:videocall_app/utils/utils.dart';
import 'package:videocall_app/views/widgets/list_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:badges/badges.dart' as badges;

import '../helper/helpers.dart';
import 'call/incoming_call.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatProvider _chatProvider;
  StreamSubscription<dynamic>? listenChatStream;
  List<String> notiList = [];
  var a;

  fetchLocalNotiList() {
    String? strCallArg =
        SharedPref.instance.shared.getString('notifications_callArg');
    if (strCallArg.validate().isNotEmpty) {
      Map<String, dynamic> callArg = jsonDecode(strCallArg!);
      SharedPref.instance.shared.setString('notifications_callArg', "");
      Future.delayed(Duration(seconds: 2)).then((value) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, RoutePath.incomingCall,
            arguments: callArg);
      });
    }

    var _i = SharedPref.instance.shared.getString('notifications_list');
    List<dynamic> list = _i != null ? jsonDecode(_i)['notifications'] : [];
    if (list.isNotEmpty) {
      for (var e in list) {
        String username = e['title']??"";
        String notificationType = e['notification_type'];
        String callType = e['call_type']??"";
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
    super.initState();

    _chatProvider = Provider.of<ChatProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _chatProvider.clearRecentChat();
    });
    _chatProvider.listAllChat();
    listenChatStream = Utils.chatListenStream.stream.listen((event) {
      //
      print(">>>>>>>>>>>>>>> received socket event");
      print(event);
      _chatProvider.listAllChat();
      FlutterRingtonePlayer.play(
          fromAsset: "assets/sound/message_tone.mp3",
          volume: 1,
          looping: false);
    });
    fetchLocalNotiList();
  }

  @override
  Widget build(BuildContext context) {
    if (Helper.k == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => IncomingCall(
              callType: Helper.data!['call_type'],
              endUserName: Helper.data!['end_user_name']!,
              callMethod: Helper.data!['call_method'],
              userLength: Helper.data!['user_length'],
              callerFcmToken: Helper.data!['caller_fcm_token'],
              agoraChannel: Helper.data!['agora_channel'],
              endUserId: Helper.data!['end_user_id']),
        ),
      );
    }
    return Consumer<ChatProvider>(builder: (context, chatProvider, child) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
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
                          Constants.chats,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutePath.notifications);
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
                                  )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: chatProvider.searchController,
                      onChanged: (e) {
                        chatProvider.clearSearchResult();
                        chatProvider
                            .searchUser(chatProvider.searchController.text);
                        if (e == '') {
                          FocusScope.of(context).unfocus();
                          chatProvider.updateIsSearching(false);
                        } else {
                          chatProvider.updateIsSearching(true);
                        }
                        chatProvider.updateState();
                      },
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
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w400),
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
                        RefreshIndicator(
                          onRefresh: () async {
                            await chatProvider.listAllChat();
                            chatProvider.clearSearchResult();
                            if (chatProvider.searchController.text != '') {
                              await chatProvider.searchUser(
                                  chatProvider.searchController.text);
                            }
                            return Future.delayed(
                                    const Duration(microseconds: 1))
                                .then((value) => true);
                          },
                          child: ListView(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RoutePath.createGroup);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      Constants.newGroup,
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: AppColor.primary),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !chatProvider.isSearching &&
                                    chatProvider.searchController.text == '',
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      chatProvider.recentChat?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return Slidable(
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) {
                                              chatProvider.deleteChat(index);
                                            },
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                          ),
                                        ],
                                      ),
                                      child: ListItem(
                                        title: chatProvider
                                                .recentChat?[index].name ??
                                            '',
                                        profilePic: chatProvider
                                                .recentChat?[index].image ??
                                            '',
                                        subTitle: (chatProvider
                                                    .recentChat?[index]
                                                    .lastChat
                                                    ?.text !=
                                                null)
                                            ? (chatProvider.recentChat?[index]
                                                    .lastChat?.text ??
                                                '')
                                            : ((chatProvider.recentChat?[index]
                                                        .lastChat?.image !=
                                                    null)
                                                ? 'image'
                                                : ''),
                                        chatType: chatProvider
                                                .recentChat?[index].type ??
                                            'personal',
                                        unreadCound: chatProvider
                                                .recentChat?[index]
                                                .unreadCount ??
                                            0,
                                        onTap: () async {
                                          dynamic back =
                                              await Navigator.pushNamed(
                                            context,
                                            RoutePath.messageScreen,
                                            arguments: {
                                              'user': chatProvider
                                                  .recentChat?[index]
                                            },
                                          );
                                          chatProvider.listAllChat();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Visibility(
                                visible: chatProvider.isSearching &&
                                    chatProvider.searchController.text != '',
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        chatProvider.searchUserList.length,
                                    itemBuilder: (context, index) {
                                      return ListItem(
                                        title: chatProvider
                                            .searchUserList[index].name,
                                        subTitle: '',
                                        profilePic: chatProvider
                                                .searchUserList[index].image ??
                                            '',
                                        chatType: chatProvider
                                                .searchUserList[index].type ??
                                            'personal',
                                        unreadCound: chatProvider
                                            .searchUserList[index].unreadCount,
                                        onTap: () => Navigator.pushNamed(
                                            context, RoutePath.messageScreen,
                                            arguments: {
                                              'user': chatProvider
                                                  .searchUserList[index]
                                            }),
                                      );
                                    }),
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
        ),
      );
    });
  }
}
