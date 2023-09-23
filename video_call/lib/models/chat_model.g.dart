// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      chats: (json['chats'] as List<dynamic>)
          .map((e) => Chat.fromJson(e as Map<String, dynamic>))
          .toList(),
      groupMembers: (json['group_members'] as List<dynamic>?)
          ?.map((e) => GroupMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'chats': instance.chats,
      'group_members': instance.groupMembers,
    };

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      id: json['id'] as int,
      senderUserId: json['sender_user_id'] as String,
      receiverUserId: json['receiver_user_id'] as String?,
      text: json['text'] as String?,
      image: json['image'],
      audio: json['audio'],
      video: json['video'],
      document: json['document'],
      isRead: json['is_read'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      senderUser: json['sender_user'] == null
          ? null
          : SenderUser.fromJson(json['sender_user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'id': instance.id,
      'sender_user_id': instance.senderUserId,
      'receiver_user_id': instance.receiverUserId,
      'text': instance.text,
      'image': instance.image,
      'audio': instance.audio,
      'video': instance.video,
      'document': instance.document,
      'is_read': instance.isRead,
      'created_at': instance.createdAt.toIso8601String(),
      'sender_user': instance.senderUser,
    };

SenderUser _$SenderUserFromJson(Map<String, dynamic> json) => SenderUser(
      id: json['id'] as int,
      uniqueId: json['uniqueId'] as String,
      name: json['name'] as String,
      email: json['email'],
      gender: json['gender'] as String,
      profileImage: json['profile_image'],
      fcmToken: json['fcm_token'] as String,
      blocked: json['blocked'] as String,
    );

Map<String, dynamic> _$SenderUserToJson(SenderUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uniqueId': instance.uniqueId,
      'name': instance.name,
      'email': instance.email,
      'gender': instance.gender,
      'profile_image': instance.profileImage,
      'fcm_token': instance.fcmToken,
      'blocked': instance.blocked,
    };

Receiver _$ReceiverFromJson(Map<String, dynamic> json) => Receiver(
      id: json['id'] as int?,
      uniqueId: json['uniqueId'] as String?,
      name: json['name'] as String,
      friendName: json['friend_name'] as String,
      profileImage: json['profile_image'],
    );

Map<String, dynamic> _$ReceiverToJson(Receiver instance) => <String, dynamic>{
      'id': instance.id,
      'uniqueId': instance.uniqueId,
      'name': instance.name,
      'friend_name': instance.friendName,
      'profile_image': instance.profileImage,
    };

GroupMember _$GroupMemberFromJson(Map<String, dynamic> json) => GroupMember(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      groupId: json['group_id'] as String,
      user: const _NestedListConverter().fromJson(json['user']),
    );

Map<String, dynamic> _$GroupMemberToJson(GroupMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'group_id': instance.groupId,
      'user': const _NestedListConverter().toJson(instance.user),
    };
