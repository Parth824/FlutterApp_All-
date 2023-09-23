import 'package:count_provider_app/control/fvprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Fv_Page extends StatefulWidget {
  const Fv_Page({super.key});

  @override
  State<Fv_Page> createState() => _Fv_PageState();
}

class _Fv_PageState extends State<Fv_Page> {
  @override
  Widget build(BuildContext context) {
    final fvprovider = Provider.of<FvProvider>(context, listen: false);
    print('om');
    return Scaffold(
      appBar: AppBar(
        title: Text("SubLike"),
      ),
      body: Consumer<FvProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.f.sub.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  value.remove(a: value.f.sub[index]);
                },
                leading: Text("Subject ${value.f.sub[index]}"),
                trailing: Icon(Icons.favorite),
              );
            },
          );
        },
      ),
    );
  }
}
