import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    required this.success,
    required this.message,
    required this.data,
    required this.token,
  });

  @JsonKey(name: "success")
  final dynamic success;
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "data")
  final User data;
  @JsonKey(name: "token")
  final String? token;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.uniqueId,
    required this.name,
    required this.email,
    required this.fcmToken,
    required this.profileImage,
    required this.decryptPassword,
    required this.gender,
    required this.friendName,
    required this.updatedAt,
    required this.createdAt,
  });

  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "uniqueId")
  final String? uniqueId;
  @JsonKey(name: "name")
  final dynamic name;
  @JsonKey(name: 'fcm_token')
  final String? fcmToken;
  @JsonKey(name: "email")
  final dynamic email;
  @JsonKey(name: 'profile_image', defaultValue: null)
  final String? profileImage;
  @JsonKey(name: "decrypt_password")
  final String decryptPassword;
  @JsonKey(name: "gender")
  final String gender;
  @JsonKey(name: "friend_name")
  final String friendName;
  @JsonKey(name: "updated_at")
  final DateTime updatedAt;
  @JsonKey(name: "created_at")
  final DateTime createdAt;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
