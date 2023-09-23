class CallHistoryModel {
  bool? success;
  String? message;
  List<CallHistory>? data;

  CallHistoryModel({this.success, this.message, this.data});

  CallHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CallHistory>[];
      json['data'].forEach((v) {
        data!.add(new CallHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CallHistory {
  String? id;
  String? senderUserId;
  String? receiverUserId;
  String? duration;
  String? status;
  String? jsonData;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? profileImage;
  UserDetail? userDetail;

  CallHistory(
      {this.id,
        this.senderUserId,
        this.receiverUserId,
        this.duration,
        this.status,
        this.jsonData,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.profileImage,
        this.userDetail});

  CallHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderUserId = json['sender_user_id'];
    receiverUserId = json['receiver_user_id'];
    duration = json['duration'];
    status = json['status'];
    jsonData = json['json_data'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    profileImage = json['profile_image'];
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_user_id'] = this.senderUserId;
    data['receiver_user_id'] = this.receiverUserId;
    data['duration'] = this.duration;
    data['status'] = this.status;
    data['json_data'] = this.jsonData;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    return data;
  }
}

class UserDetail {
  String? profileImage;
  String? name;

  UserDetail({this.profileImage, this.name});

  UserDetail.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image'] = this.profileImage;
    data['name'] = this.name;
    return data;
  }

}