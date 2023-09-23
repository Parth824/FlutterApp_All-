import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

part 'search_user_model.g.dart';

SearchUserModel searchUserModelFromJson(String str) =>
    SearchUserModel.fromJson(json.decode(str));

String searchUserModelToJson(SearchUserModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class SearchUserModel {
  SearchUserModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final String success;
  final String message;
  final Data data;

  factory SearchUserModel.fromJson(Map<String, dynamic> json) =>
      _$SearchUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUserModelToJson(this);
}

@JsonSerializable()
class Data {
  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });
  @JsonKey(name: 'current_page')
  final int? currentPage;
  final List<SearchUser> data;
  @JsonKey(name: 'first_page_url')
  final String firstPageUrl;
  final int? from;
  @JsonKey(name: 'last_page')
  final int? lastPage;
  @JsonKey(name: 'last_page_url')
  final String lastPageUrl;
  @JsonKey(name: 'next_page_url')
  final dynamic nextPageUrl;
  final String path;
  @JsonKey(name: 'per_page')
  final int? perPage;
  @JsonKey(name: 'prev_page_url')
  final dynamic prevPageUrl;
  final dynamic to;
  final int? total;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class SearchUser {
  SearchUser({
    required this.id,
    required this.name,
    required this.fcmToken,
    required this.image,
    required this.unreadCount,
    required this.type,
  });

  final int id;
  final String name;
  @JsonKey(name: 'fcm_token')
  final String? fcmToken;
  final dynamic image;
  @JsonKey(name: 'unread_count')
  final int unreadCount;
  final dynamic type;

  factory SearchUser.fromJson(Map<String, dynamic> json) =>
      _$SearchUserFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUserToJson(this);
}
