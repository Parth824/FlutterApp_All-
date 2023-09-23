import 'package:count_provider_app/control/product_provider.dart';
import 'package:count_provider_app/modle/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Price: ${Provider.of<ProductProvider>(context).TotlePrice}"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Qutit: ${Provider.of<ProductProvider>(context).TotaleQut}"),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView.builder(
                itemCount:
                    Provider.of<ProductProvider>(context).added_product.length,
                itemBuilder: (context, i) {
                  List<Product> data =
                      Provider.of<ProductProvider>(context).added_product;
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      isThreeLine: true,
                      leading: Text("${i + 1}"),
                      title: Text("${data[i].name}"),
                      subtitle:
                          Text("${data[i].category}\nRs. ${data[i].price}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .add(product: data[i]);
                            },
                            icon: Icon(Icons.add, size: 20),
                          ),
                          Text(
                            "${data[i].item}",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .sub(product: data[i]);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .moveproduct(product: data[i]);
                            },
                            icon: Icon(
                              Icons.delete,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
