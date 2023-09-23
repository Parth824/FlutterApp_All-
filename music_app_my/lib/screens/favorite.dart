import 'package:flutter/material.dart';
import 'package:music_app_my/screens/main_screen.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final List<Song> favoriteSongs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text('Favorites'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ));
          },
        ),
      ),
      body: ListView.builder(
        itemCount: favoriteSongs.length,
        itemBuilder: (context, index) {
          final song = favoriteSongs[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(song.albumCoverUrl),
            ),
            title: Text(song.title),
            trailing: IconButton(
              icon: const Icon(Icons.play_circle_filled),
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}

class Song {
  final String title;
  final String albumCoverUrl;

  Song({required this.title, required this.albumCoverUrl});
}
