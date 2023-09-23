// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:videocall_app/models/user_model.dart';
part 'chat_model.g.dart';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

@JsonSerializable()
class ChatModel {
  ChatModel(
      {required this.success,
      required this.message,
      // required this.sender,
      // required this.receiver,
      required this.chats,
      required this.groupMembers});

  final bool success;
  final String message;
  // final Receiver sender;
  // final Receiver receiver;
  final List<Chat> chats;
  @JsonKey(name: 'group_members')
  final List<GroupMember>? groupMembers;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}

@JsonSerializable()
class Chat {
  Chat({
    required this.id,
    required this.senderUserId,
    required this.receiverUserId,
    required this.text,
    required this.image,
    required this.audio,
    required this.video,
    required this.document,
    required this.isRead,
    required this.createdAt,
    required this.senderUser,
  });

  final int id;
  @JsonKey(name: 'sender_user_id')
  final String senderUserId;
  @JsonKey(name: 'receiver_user_id')
  final String? receiverUserId;
  final String? text;
  final dynamic image;
  final dynamic audio;
  final dynamic video;
  final dynamic document;
  @JsonKey(name: 'is_read')
  final bool isRead;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'sender_user')
  final SenderUser? senderUser;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}

@JsonSerializable()
class SenderUser {
  SenderUser({
    required this.id,
    required this.uniqueId,
    required this.name,
    required this.email,
    required this.gender,
    required this.profileImage,
    required this.fcmToken,
    required this.blocked,
  });

  final int id;
  @JsonKey(name: 'uniqueId')
  final String uniqueId;
  final String name;
  final dynamic email;
  @JsonKey(name: 'gender')
  final String gender;
  @JsonKey(name: 'profile_image')
  final dynamic profileImage;
  @JsonKey(name: 'fcm_token')
  final String fcmToken;
  final String blocked;

  factory SenderUser.fromJson(Map<String, dynamic> json) =>
      _$SenderUserFromJson(json);

  Map<String, dynamic> toJson() => _$SenderUserToJson(this);
}

@JsonSerializable()
class Receiver {
  Receiver({
    required this.id,
    required this.uniqueId,
    required this.name,
    required this.friendName,
    required this.profileImage,
  });

  final int? id;
  final String? uniqueId;
  final String name;
  @JsonKey(name: 'friend_name')
  final String friendName;
  @JsonKey(name: 'profile_image')
  final dynamic profileImage;

  factory Receiver.fromJson(Map<String, dynamic> json) =>
      _$ReceiverFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiverToJson(this);
}

@JsonSerializable()
class GroupMember {
  GroupMember({
    required this.id,
    required this.userId,
    required this.groupId,
    required this.user,
  });

  final int id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'group_id')
  final String groupId;
  @_NestedListConverter()
  final User user;

  factory GroupMember.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMemberToJson(this);
}

class _NestedListConverter extends JsonConverter<User, dynamic> {
  const _NestedListConverter();

  @override
  User fromJson(dynamic json) => User.fromJson(json);

  @override
  Map<String, dynamic> toJson(User object) => object.toJson();
}
