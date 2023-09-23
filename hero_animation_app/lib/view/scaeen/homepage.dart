import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hero_animation_app/view/compends/game.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int k = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: k,
        children: [
          GemaPlaye(),
          Container(),
          Container(),
          Container(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: k,
        selectedItemColor: Colors.green.shade800,
        unselectedItemColor: Colors.black54,
        onTap: (value) {
          setState(() {
            k = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.game_controller),
            label: "Games",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: "Apps",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_movies),
            label: "Movies & TV",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: "Books",
          ),
        ],
      ),
    );
  }
}
