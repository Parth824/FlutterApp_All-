// ignore_for_file: constant_identifier_names

class ApiPath {
  static const String register = "/signup";
  static const String login = "/login";
  static const String get_user = "/get-profile";
  static const String forget_password = "/change-password";
  static const String update_profile_pic = '/change-profile';
  static const String update_profile = '/change-profile';
  static const String search_user = '/chat/search';
  static const String list_all_chat = '/chat/listWithGroup';
  static const String list_personal_chat = '/chat/received';
  static const String send_message = '/chat/send';
  static const String create_group = '/group/create';
  static const String update_group = '/group';
  static const String remove_group_member = '/groupmember';
  static const String add_group_member = '/groupmember/add';
  static const String delete_chat = '/chat';
  static const String postcallHistory = '/chat/postcallHistory';
  static const String getcallHistory = '/chat/getcallHistory';
}
