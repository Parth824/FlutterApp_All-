import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:videocall_app/models/chat_model.dart';
import 'package:videocall_app/models/recent_chat_model.dart';
import 'package:videocall_app/providers/auth_provider.dart';
import 'package:videocall_app/providers/chat_provider.dart';
import 'package:videocall_app/utils/constants/colors.dart';
import 'package:videocall_app/utils/constants/constant.dart';
import 'package:videocall_app/utils/router/router_path.dart';
import 'package:videocall_app/utils/utils.dart';
import 'package:videocall_app/views/widgets/message_item.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key, required this.enduser}) : super(key: key);

  final dynamic enduser;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController textMessageController = TextEditingController();
  late ChatProvider _chatProvider;
  StreamSubscription<dynamic>? listenChatStream;
  final ScrollController scrollController = ScrollController();

  void scrollAtEnd() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(microseconds: 1), curve: Curves.fastOutSlowIn);
  }

  void getLatestMessages() async {
    await _chatProvider.getPersonalChat(
        widget.enduser.id.toString(), widget.enduser?.type ?? 'personal');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollAtEnd();
    });
  }

  @override
  void initState() {
    super.initState();
    _chatProvider = Provider.of<ChatProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _chatProvider.clearCurrentChat();
    });

    if (widget.enduser != null) {
      getLatestMessages();
    }

    listenChatStream = Utils.chatListenStream.stream.listen((event) {
      getLatestMessages();
      FlutterRingtonePlayer.play(
          fromAsset: "assets/sound/message_tone.mp3",
          volume: 1,
          looping: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatProvider, AuthProvider>(
        builder: (context, chatProvider, authProvider, child) {
      // if (chatProvider.isLoading) {
      //   return const Scaffold(
      //     body: Center(child: CircularProgressIndicator()),
      //   );
      // }
      return Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Image.asset("assets/images/background.png"),
              Positioned(
                top: 50,
                left: 10,
                right: 10,
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
                    GestureDetector(
                      onTap: () {
                        if (widget.enduser.type == 'group' &&
                            chatProvider.currentChat != null) {
                          RecentDatum datum = widget.enduser;
                          datum.groupMembers =
                              chatProvider.currentChat?.groupMembers;
                          Navigator.pushNamed(context, RoutePath.editGroup,
                              arguments: {'group': widget.enduser});
                        }
                      },
                      child: Text(
                        widget.enduser.name,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        if (widget.enduser.type != 'group') {
                          await Utils.sendMessage(
                            title: authProvider.user?.data.name ?? 'pickup',
                            msg: 'Incoming call',
                            receiverFcmToken: widget.enduser.fcmToken,
                            data: {
                              'notification_type': 'incoming_call',
                              'agora_channel':
                                  '${authProvider.user?.data.id}_${widget.enduser.id}',
                              'call_type': 'video',
                              'end_user_name':
                                  authProvider.user?.data.name ?? 'pickup',
                              'user_length': 0,
                              'caller_user_id':
                                  authProvider.user?.data.id.toString(),
                              'caller_fcm_token':
                                  authProvider.user?.data.fcmToken,
                              'time': DateTime.now().toString(),
                              'end_user_id': widget.enduser.id.toString(),
                            },
                          );

                          Utils.callStream.add({
                            'call_type': 'video',
                            'end_user_name': widget.enduser.name,
                            'cur_user_id':
                                authProvider.user?.data.id.toString(),
                            'call_method': 'dialing',
                            'user_length': 0,
                            'end_user_fcm_token': widget.enduser.fcmToken,
                            'agora_channel':
                                '${authProvider.user?.data.id}_${widget.enduser.id}',
                            'end_user_id': widget.enduser.id.toString(),
                          });
                        } else {
                          if (chatProvider.currentChat!.groupMembers != null &&
                              chatProvider
                                      .currentChat!.groupMembers?.isNotEmpty ==
                                  true) {
                            List callmembers = [];
                            for (var usr
                                in chatProvider.currentChat!.groupMembers!) {
                              callmembers.add(usr.user.fcmToken);
                              if (usr.user.id != authProvider.user?.data.id) {
                                await Utils.sendMessage(
                                  title:
                                      authProvider.user?.data.name ?? 'pickup',
                                  msg: 'Incoming call',
                                  receiverFcmToken: usr.user.fcmToken!,
                                  data: {
                                    'notification_type': 'incoming_call',
                                    'agora_channel':
                                        'group_${widget.enduser.id}',
                                    'call_type': 'video',
                                    'end_user_name':
                                        authProvider.user?.data.name ??
                                            'pickup',
                                    'user_length': 0,
                                    'caller_user_id':
                                        authProvider.user?.data.id.toString(),
                                    'caller_fcm_token': usr.user.fcmToken,
                                    'time': DateTime.now().toString(),
                                    'end_user_id': widget.enduser.id.toString(),
                                  },
                                );
                              }
                            }
                            //
                            Utils.callStream.add({
                              'call_type': 'video',
                              'end_user_name': widget.enduser.name,
                              'cur_user_id':
                                  authProvider.user?.data.id.toString(),
                              'call_method': 'dialing',
                              'user_length': 0,
                              'end_user_fcm_token': '',
                              'agora_channel': 'group_${widget.enduser.id}',
                              'end_user_id': widget.enduser.id.toString(),
                              'call_members': callmembers,
                            });
                          }
                        }
                      },
                      child: const Icon(
                        Icons.videocam,
                        size: 30,
                        color: AppColor.primary,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (widget.enduser.type != 'group') {
                          await Utils.sendMessage(
                            title: authProvider.user?.data.name ?? 'pickup',
                            msg: 'Incoming call',
                            receiverFcmToken: widget.enduser.fcmToken,
                            data: {
                              'notification_type': 'incoming_call',
                              'agora_channel':
                                  '${authProvider.user?.data.id}_${widget.enduser.id}',
                              'call_type': 'audio',
                              'end_user_name':
                                  authProvider.user?.data.name ?? 'pickup',
                              'user_length': 0,
                              'caller_fcm_token':
                                  authProvider.user?.data.fcmToken,
                              'time': DateTime.now().toString(),
                              'end_user_id': widget.enduser.id.toString(),
                            },
                          );

                          Utils.callStream.add({
                            'call_type': 'audio',
                            'end_user_name': widget.enduser.name,
                            'cur_user_id':
                                authProvider.user?.data.id.toString(),
                            'call_method': 'dialing',
                            'user_length': 0,
                            'agora_channel':
                                '${authProvider.user?.data.id}_${widget.enduser.id}',
                            'end_user_fcm_token': widget.enduser.fcmToken,
                            'end_user_id': widget.enduser.id.toString(),
                          });
                        } else {
                          if (chatProvider.currentChat!.groupMembers != null &&
                              chatProvider
                                      .currentChat!.groupMembers?.isNotEmpty ==
                                  true) {
                            List callmembers = [];
                            for (var usr
                                in chatProvider.currentChat!.groupMembers!) {
                              if (usr.user.id != authProvider.user?.data.id) {
                                callmembers.add(usr.user.fcmToken);
                                await Utils.sendMessage(
                                  title:
                                      authProvider.user?.data.name ?? 'pickup',
                                  msg: 'Incoming call',
                                  receiverFcmToken: usr.user.fcmToken!,
                                  data: {
                                    'notification_type': 'incoming_call',
                                    'agora_channel':
                                        'group_${widget.enduser.id}',
                                    'call_type': 'audio',
                                    'end_user_name':
                                        authProvider.user?.data.name ??
                                            'pickup',
                                    'user_length': 0,
                                    'caller_user_id':
                                        authProvider.user?.data.id.toString(),
                                    'caller_fcm_token': usr.user.fcmToken,
                                    'time': DateTime.now().toString(),
                                    'end_user_id': widget.enduser.id.toString(),
                                  },
                                );
                              }
                            }
                            //
                            Utils.callStream.add({
                              'call_type': 'audio',
                              'end_user_name': widget.enduser.name,
                              'cur_user_id':
                                  authProvider.user?.data.id.toString(),
                              'call_method': 'dialing',
                              'user_length': 0,
                              'end_user_fcm_token': '',
                              'agora_channel': 'group_${widget.enduser.id}',
                              'end_user_id': widget.enduser.id.toString(),
                              'call_members': callmembers,
                            });
                          }
                        }
                      },
                      child: const Icon(
                        Icons.call,
                        color: AppColor.primary,
                        size: 25,
                      ),
                    )
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
                      ),
                    ),
                    child: Stack(
                      children: [
                        ListView.builder(
                          controller: scrollController,
                          itemCount:
                              chatProvider.currentChat?.chats.length ?? 0,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 15, bottom: 70),
                          itemBuilder: (context, index) {
                            return MessageItem(
                              chatMessage:
                                  chatProvider.currentChat!.chats[index],
                              user: authProvider.user!,
                              enduser: widget.enduser,
                            );
                          },
                        ),
                        messageComposer(chatProvider, authProvider),
                        if (chatProvider.isLoading)
                          Container(
                            height: 23,
                            decoration: const BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              children: const [
                                Text('uploading'),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  height: 2,
                                  child: LinearProgressIndicator(
                                    color: AppColor.primary,
                                  ),
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

  Align messageComposer(ChatProvider chatProvider, AuthProvider authProvider) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 20, bottom: 10),
        height: 70,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: textMessageController,
                onChanged: (e) {
                  chatProvider.updateState();
                },
                decoration: InputDecoration(
                  hintText: Constants.writeHere,
                  hintStyle: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColor.blackShade2,
                    ),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColor.blackShade2,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.blackShade2,
                      width: 1,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColor.blackShade2,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            if (textMessageController.text == '')
              IconButton(
                icon: const Icon(Icons.photo),
                iconSize: 25.0,
                color: AppColor.primary,
                onPressed: () {
                  chatProvider.selectImage(
                      context,
                      widget.enduser.id.toString(),
                      widget.enduser?.type ?? 'personal');
                },
              ),
            if (textMessageController.text != '')
              GestureDetector(
                onTap: () {
                  chatProvider.sendMessage(
                    widget.enduser.id.toString(),
                    authProvider.user!.data.id.toString(),
                    textMessageController.text,
                    widget.enduser?.type ?? 'personal',
                  );

                  if (widget.enduser?.type == 'personal') {
                    Utils.sendMessage(
                      receiverFcmToken: widget.enduser.fcmToken,
                      msg: textMessageController.text,
                      title: authProvider.user?.data.name ?? 'pickup',
                      data: {'notification_type': 'text_message'},
                    );
                  }
                  if (widget.enduser?.type == 'group') {
                    widget.enduser.groupMembers =
                        chatProvider.currentChat?.groupMembers;
                    for (var member
                        in (widget.enduser as RecentDatum).groupMembers ?? []) {
                      member as GroupMember;

                      if (member.user.fcmToken != null &&
                          member.user.fcmToken != '' &&
                          member.user.id != authProvider.user!.data.id) {
                        Utils.sendMessage(
                          receiverFcmToken: member.user.fcmToken!,
                          msg: textMessageController.text,
                          title: (widget.enduser as RecentDatum).name,
                          data: {'notification_type': 'text_message'},
                        );
                      }
                    }
                  }
                  textMessageController.clear();
                },
                child: Image.asset(
                  "assets/images/send.png",
                  width: 30,
                  height: 30,
                ),
              ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  String name;
  String messageContent;
  String messageType;

  ChatMessage(
      {required this.name,
      required this.messageContent,
      required this.messageType});
}
