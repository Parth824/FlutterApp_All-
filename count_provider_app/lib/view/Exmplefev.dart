import 'package:count_provider_app/control/fvprovider.dart';
import 'package:count_provider_app/view/fvpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Fav_like extends StatefulWidget {
  const Fav_like({super.key});

  @override
  State<Fav_like> createState() => _Fav_likeState();
}

class _Fav_likeState extends State<Fav_like> {
  @override
  Widget build(BuildContext context) {
    final fvprovider = Provider.of<FvProvider>(context, listen: false);
    print("Parth");
    return Scaffold(
      appBar: AppBar(
        title: Text("Like App"),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Fv_Page(),
                  ),
                );
              },
              child: Icon(Icons.create)),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              if (fvprovider.f.sub.contains(index + 1)) {
                fvprovider.remove(a: index + 1);
              } else {
                fvprovider.add(a: index + 1);
              }
            },
            leading: Text("Subject ${index + 1}"),
            trailing: Consumer<FvProvider>(
              builder: (context, value, child) {
                return (value.f.sub.contains(index + 1))
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border_outlined);
              },
            ),
          );
        },
      ),
    );
  }
}
