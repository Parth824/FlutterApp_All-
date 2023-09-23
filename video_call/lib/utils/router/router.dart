import 'package:flutter/material.dart';
import 'package:videocall_app/utils/router/router_path.dart';
import 'package:videocall_app/utils/shared_pref.dart';
import 'package:videocall_app/views/call/dial.dart';
import 'package:videocall_app/views/call/call_screen.dart';
import 'package:videocall_app/views/call/incoming_call.dart';
import 'package:videocall_app/views/group/add_group_member.dart';
import 'package:videocall_app/views/group/create_group.dart';
import 'package:videocall_app/views/forgot_password.dart';
import 'package:videocall_app/views/group/create_group_name.dart';
import 'package:videocall_app/views/group/edit_group.dart';
import 'package:videocall_app/views/home.dart';
import 'package:videocall_app/views/home_parent.dart';
import 'package:videocall_app/views/login.dart';
import 'package:videocall_app/views/message.dart';
import 'package:videocall_app/views/notification.dart';
import 'package:videocall_app/views/register.dart';

import '../../views/splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RoutePath.splash:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );
      case RoutePath.login:
        return MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        );
      case RoutePath.homeParent:
        return MaterialPageRoute(
          builder: (context) {
            return const HomeParent();
          },
        );
      case RoutePath.register:
        return MaterialPageRoute(
          builder: (context) {
            return const RegisterScreen();
          },
        );
      case RoutePath.forgotPassword:
        return MaterialPageRoute(
          builder: (context) {
            return const ForgotPasswordScreen();
          },
        );
      case RoutePath.home:
        return MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        );
      case RoutePath.notifications:
        return MaterialPageRoute(
          builder: (context) {
            return const NotificationScreen();
          },
        );
      case RoutePath.messageScreen:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) {
            return MessageScreen(enduser: arg['user']);
          },
        );
      case RoutePath.createGroup:
        return MaterialPageRoute(
          builder: (context) {
            return const CreateGroup();
          },
        );
      // case RoutePath.dialScreen:
      //   Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;

      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return DialScreen(
      //         callType: arg['call_type'],
      //         endUserName: arg['end_user_name'],
      //         callMethod: arg['call_method'],
      //         userLength: arg['user_length'],
      //         endUserFcmToken: arg['end_user_fcm_token'],
      //       );
      //     },
      //   );
      case RoutePath.incomingCall:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) {
            return IncomingCall(
              callType: arg['call_type'],
              endUserName: arg['end_user_name'],
              callMethod: arg['call_method'],
              userLength: arg['user_length'],
              callerFcmToken: arg['caller_fcm_token'],
              agoraChannel: arg['agora_channel'],
              endUserId: arg['end_user_id'],
            );
          },
        );
      case RoutePath.createGroupName:
        return MaterialPageRoute(
          builder: (context) {
            return const CreateGroupName();
          },
        );
      case RoutePath.addGroupMember:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) {
            return AddGroupMember(
              group: arg['group'],
            );
          },
        );
      case RoutePath.editGroup:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) {
            return EditGroup(
              group: arg['group'],
            );
          },
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return SharedPref.instance.shared.getString('token') != '' &&
                SharedPref.instance.shared.getString('token') != null
            ? const HomeScreen()
            : const SplashScreen();
        // Scaffold(
        //   appBar: AppBar(
        //     title: const Text('Error'),
        //   ),
        //   body: const Center(
        //     child: Text('Error'),
        //   ),
        // );
      },
    );
  }
}
