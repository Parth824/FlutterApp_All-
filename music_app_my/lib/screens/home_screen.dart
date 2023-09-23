import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_app_my/screens/edit_profile.dart';
import 'package:music_app_my/screens/favorite.dart';
import 'package:music_app_my/screens/main_screen.dart';
import 'package:music_app_my/screens/search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screenList = [
    const MainScreen(),
    const SearchPage(),
    const FavoritePage(),
    const ProfileEditPage(),
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FloatingNavbar(
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        currentIndex: selectedIndex,
        items: [
          FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          FloatingNavbarItem(icon: Icons.search, title: 'Search'),
          FloatingNavbarItem(
              icon: Icons.play_circle_filled_rounded, title: 'Playlist'),
          FloatingNavbarItem(icon: Icons.settings, title: 'Edit Profile'),
        ],
      ),
      body: screenList[selectedIndex],
    );
  }
}
