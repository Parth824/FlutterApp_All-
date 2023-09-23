import 'package:count_provider_app/control/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/allproduct.dart';
import 'cart_pages.dart';

class ProdectPage extends StatefulWidget {
  const ProdectPage({super.key});

  @override
  State<ProdectPage> createState() => _ProdectPageState();
}

class _ProdectPageState extends State<ProdectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
            icon: Icon(Icons.shopping_bag),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: allproduct.length,
        itemBuilder: (context, i) {
          return Card(
            elevation: 3,
            child: ListTile(
              isThreeLine: true,
              leading: Text("${allproduct[i].id}"),
              title: Text("${allproduct[i].name}"),
              subtitle:
                  Text("${allproduct[i].category}\nRs. ${allproduct[i].price}"),
              trailing: IconButton(
                onPressed: () {
                  if (Provider.of<ProductProvider>(context, listen: false)
                      .added_product
                      .contains(allproduct[i])) {
                    allproduct[i].item++;
                  } else {
                    Provider.of<ProductProvider>(context, listen: false)
                        .addproduct(product: allproduct[i]);
                  }
                },
                icon: Icon(Icons.add_circle_outline),
              ),
            ),
          );
        },
      ),
    );
  }
}
