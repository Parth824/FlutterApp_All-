// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentChatList _$RecentChatListFromJson(Map<String, dynamic> json) =>
    RecentChatList(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => RecentDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecentChatListToJson(RecentChatList instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

RecentDatum _$RecentDatumFromJson(Map<String, dynamic> json) => RecentDatum(
      id: json['id'] as int,
      type: json['type'] as String,
      fcmToken: json['fcm_token'] as String?,
      name: json['name'] as String,
      image: json['image'],
      unreadCount: json['unread_count'] as int,
      lastChat: json['last_chat'] == null
          ? null
          : LastChat.fromJson(json['last_chat'] as Map<String, dynamic>),
      groupMembers: (json['group_members'] as List<dynamic>?)
          ?.map((e) => GroupMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecentDatumToJson(RecentDatum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'fcm_token': instance.fcmToken,
      'name': instance.name,
      'image': instance.image,
      'unread_count': instance.unreadCount,
      'last_chat': instance.lastChat,
      'group_members': instance.groupMembers,
    };

LastChat _$LastChatFromJson(Map<String, dynamic> json) => LastChat(
      id: json['id'] as int,
      text: json['text'] as String?,
      image: json['image'],
      audio: json['audio'],
      video: json['video'],
      document: json['document'],
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$LastChatToJson(LastChat instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'image': instance.image,
      'audio': instance.audio,
      'video': instance.video,
      'document': instance.document,
      'created_at': instance.createdAt.toIso8601String(),
    };
