import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List k = [
    Colors.amber,
    Colors.orange,
    Colors.redAccent,
    Colors.pink,
    Colors.deepPurple,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.indigo,
    Colors.lightGreen,
    Colors.lime,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              // pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 200,
              // collapsedHeight: 100,

              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1.5,
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Text("Sliver AppBar"),
                background: Image.network(
                  "https://i.ibb.co/QpWGK5j/Geeksfor-Geeks.png",
                  fit: BoxFit.cover,
                  // color: Colors.red,
                ),
              ),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  color: k[index],
                  child: Center(child: Text("${index + 1}")),
                ),
                childCount: k.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1),
            ),
          ];
        },
        
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   pinned: true,
          //   snap: true,
          //   floating: true,
          //   expandedHeight: 200,
          //   // collapsedHeight: 100,
          //   title: Text("Sliver AppBar"),
          //   centerTitle: true,
          //   // flexibleSpace: FlexibleSpaceBar(
          //   //   expandedTitleScale: 1.5,
          //   //   collapseMode: CollapseMode.pin,

          //   //
          //   //   centerTitle: true,
          //   //   background: Image.network(
          //   //     "https://i.ibb.co/QpWGK5j/Geeksfor-Geeks.png",
          //   //     fit: BoxFit.cover,
          //   //     // color: Colors.red,
          //   //   ),
          //   // ),
          // ),
          SliverAppBar(
            // pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 200,
            // collapsedHeight: 100,

            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.5,
              collapseMode: CollapseMode.pin,
              centerTitle: true,
              title: Text("Sliver AppBar"),
              background: Image.network(
                "https://i.ibb.co/QpWGK5j/Geeksfor-Geeks.png",
                fit: BoxFit.cover,
                // color: Colors.red,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(

              (context, index) => Container(
                color: k[index],
                child: Center(child: Text("${index + 1}")),
              ),
              childCount: k.length,
              // addAutomaticKeepAlives: true,

            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                color: k[index],
                child: Center(child: Text("${index + 1}")),
              ),
              childCount: k.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 1),
          ),
        ],
      ),
      ),
    );
  }
}
