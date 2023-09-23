// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      success: json['success'],
      message: json['message'] as String,
      data: User.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'token': instance.token,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      uniqueId: json['uniqueId'] as String?,
      name: json['name'],
      email: json['email'],
      fcmToken: json['fcm_token'] as String?,
      profileImage: json['profile_image'] as String?,
      decryptPassword: json['decrypt_password'] as String,
      gender: json['gender'] as String,
      friendName: json['friend_name'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'uniqueId': instance.uniqueId,
      'name': instance.name,
      'fcm_token': instance.fcmToken,
      'email': instance.email,
      'profile_image': instance.profileImage,
      'decrypt_password': instance.decryptPassword,
      'gender': instance.gender,
      'friend_name': instance.friendName,
      'updated_at': instance.updatedAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };
