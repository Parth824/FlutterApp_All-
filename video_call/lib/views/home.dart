import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videocall_app/providers/auth_provider.dart';
import 'package:videocall_app/providers/chat_provider.dart';
import 'package:videocall_app/utils/constants/colors.dart';
import 'package:videocall_app/views/chat_tab.dart';
import 'package:videocall_app/views/profile.dart';

import 'call_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthProvider _authProvider;
  late ChatProvider _chatProvider;
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const ChatScreen(),
    const CallTab(),
    const ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void fetchUser() async {
    await _authProvider.fetchUser(context: context);
  }

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _chatProvider = Provider.of<ChatProvider>(context, listen: false);
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: AppColor.darkGrey,
        selectedItemColor: AppColor.primary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/chat_unselected.png",
              width: 24,
              height: 24,
            ),
            activeIcon: Image.asset(
              "assets/images/chat_selected.png",
              width: 24,
              height: 24,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/call_unselected.png",
              width: 24,
              height: 24,
            ),
            activeIcon: Image.asset(
              "assets/images/call_selected.png",
              width: 24,
              height: 24,
            ),
            label: 'Call',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/profile_unselected.png",
              width: 20,
              height: 22,
            ),
            activeIcon: Image.asset(
              "assets/images/profile_selected.png",
              width: 22,
              height: 22,
            ),
            label: 'Profile',
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
