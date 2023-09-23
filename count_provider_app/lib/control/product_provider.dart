import 'package:count_provider_app/modle/product_model.dart';
import 'package:count_provider_app/res/allproduct.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> added_product = [];

  get TotaleQut => added_product.length;
  get TotlePrice {
    int pri = 0;

    added_product.forEach((element) {
      pri = pri + (element.price * element.item);
    });

    return pri;
  }

  void add({required Product product}) {
    product.item++;
    notifyListeners();
  }

  void sub({required Product product}) {
    if (product.item > 1) {
      product.item--;
    }
    notifyListeners();
  }

  void addproduct({required Product product}) {
    added_product.add(product);

    notifyListeners();
  }

  void moveproduct({required Product product}) {
    product.item = 1;
    added_product.remove(product);
    notifyListeners();
  }
}
