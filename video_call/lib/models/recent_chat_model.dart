// To parse this JSON data, do
//
//     final recentChatList = recentChatListFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:videocall_app/models/chat_model.dart';
part 'recent_chat_model.g.dart';

RecentChatList recentChatListFromJson(String str) =>
    RecentChatList.fromJson(json.decode(str));

String recentChatListToJson(RecentChatList data) => json.encode(data.toJson());

@JsonSerializable()
class RecentChatList {
  RecentChatList({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final List<RecentDatum> data;

  factory RecentChatList.fromJson(Map<String, dynamic> json) =>
      _$RecentChatListFromJson(json);

  Map<String, dynamic> toJson() => _$RecentChatListToJson(this);
}

@JsonSerializable()
class RecentDatum {
  RecentDatum({
    required this.id,
    required this.type,
    required this.fcmToken,
    required this.name,
    required this.image,
    required this.unreadCount,
    required this.lastChat,
    this.groupMembers,
  });

  final int id;
  final String type;
  @JsonKey(name: 'fcm_token')
  final String? fcmToken;
  final String name;
  @JsonKey(name: 'image')
  final dynamic image;
  @JsonKey(name: 'unread_count')
  final int unreadCount;
  @JsonKey(name: 'last_chat', defaultValue: null)
  final LastChat? lastChat;
  // final String? lastChat;
  @JsonKey(name: 'group_members')
  List<GroupMember>? groupMembers;

  factory RecentDatum.fromJson(Map<String, dynamic> json) =>
      _$RecentDatumFromJson(json);

  Map<String, dynamic> toJson() => _$RecentDatumToJson(this);
}

@JsonSerializable()
class LastChat {
  LastChat({
    required this.id,
    required this.text,
    required this.image,
    required this.audio,
    required this.video,
    required this.document,
    required this.createdAt,
  });

  final int id;
  final String? text;
  final dynamic image;
  final dynamic audio;
  final dynamic video;
  final dynamic document;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  factory LastChat.fromJson(Map<String, dynamic> json) =>
      _$LastChatFromJson(json);

  Map<String, dynamic> toJson() => _$LastChatToJson(this);
}
