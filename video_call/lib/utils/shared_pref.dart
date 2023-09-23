import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();
  late SharedPreferences shared;

  Future<void> getSharedInstance() async {
    shared = await SharedPreferences.getInstance();
  }

  static final SharedPref _singletone = SharedPref._();

  static SharedPref get instance => _singletone;
}
