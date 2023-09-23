// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchUserModel _$SearchUserModelFromJson(Map<String, dynamic> json) =>
    SearchUserModel(
      success: json['success'] as String,
      message: json['message'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchUserModelToJson(SearchUserModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) => SearchUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['first_page_url'] as String,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      lastPageUrl: json['last_page_url'] as String,
      nextPageUrl: json['next_page_url'],
      path: json['path'] as String,
      perPage: json['per_page'] as int?,
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'] as int?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'last_page': instance.lastPage,
      'last_page_url': instance.lastPageUrl,
      'next_page_url': instance.nextPageUrl,
      'path': instance.path,
      'per_page': instance.perPage,
      'prev_page_url': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
    };

SearchUser _$SearchUserFromJson(Map<String, dynamic> json) => SearchUser(
      id: json['id'] as int,
      name: json['name'] as String,
      fcmToken: json['fcm_token'] as String?,
      image: json['image'],
      unreadCount: json['unread_count'] as int,
      type: json['type'],
    );

Map<String, dynamic> _$SearchUserToJson(SearchUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fcm_token': instance.fcmToken,
      'image': instance.image,
      'unread_count': instance.unreadCount,
      'type': instance.type,
    };
