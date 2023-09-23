import 'package:flutter/material.dart';
import 'package:music_app_my/tracks/bairiya.dart';
import 'package:music_app_my/tracks/chaleya.dart';
import 'package:music_app_my/tracks/daku.dart';
import 'package:music_app_my/tracks/kahanisuno.dart';
import 'package:music_app_my/tracks/kesariya.dart';
import 'package:music_app_my/tracks/maan_meri_jaan.dart';
import 'package:music_app_my/tracks/malangsajna.dart';
import 'package:music_app_my/tracks/obedardeya.dart';
import 'package:music_app_my/tracks/shreeganeshay.dart';
import 'package:music_app_my/tracks/terepyaarmein.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> songs = [
    'Mann Meri Jaan',
    'Bairiya',
    'Daku',
    'Kahani Suno',
    'Kesariya',
    'Malang Sajna',
    'O Bedardeya',
    'Shree Ganeshay Dheemanhi',
    'Tere Pyaar Mein',
    'Chaleya',
  ];

  final List<Widget> screens = [
    const MaanMerijaan(),
    const Bairiya(),
    const Daku(),
    const KahaniSuno(),
    const Kesariya(),
    const MalangSajna(),
    const Obedardeya(),
    const ShreeGaneshay(),
    const TerePyaarMein(),
    const Chaleya(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Songs'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return ListTile(
            title: Text(
              song,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            leading: const Icon(
              Icons.music_note,
              color: Colors.white,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.play_circle_filled,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  currentIndex = index;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => screens[currentIndex],
                    ));
              },
            ),
          );
        },
      ),
    );
  }
}
