// ignore_for_file: prefer_final_fields, unused_field, file_names, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:max_shop_app_12_1_22/Models/products.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  Future<void> fetchProducts() async {
    const myUrl =
        'https://maxshopapp-f9422-default-rtdb.firebaseio.com/products.json';
    final response = await http.get(Uri.parse(myUrl));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Product> loadedProducts = [];

    if (extractedData == null) {
      return;
    } else {
      extractedData.forEach((key, value) {
        loadedProducts.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          imageUrl: value['imageUrl'],
          isFavourite: value['isFavourite'],
        ));
      });
    }
    _items = loadedProducts;
    notifyListeners();
  }

  List<Product> get items {
    List<Product> newItems = _items;
    return newItems;
  }

  List<Product> get favoriteItems {
    List<Product> newItems = _items.where((e) => e.isFavourite).toList();
    return newItems;
  }

  Future<void> addProduct(Product value) async {
    const url =
        'https://maxshopapp-f9422-default-rtdb.firebaseio.com/products.json';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'title': value.title,
        'description': value.description,
        'imageUrl': value.imageUrl,
        'price': value.price,
        'isFavourite': value.isFavourite,
      }),
    );
    final newProduct = Product(
      title: value.title,
      description: value.description,
      price: value.price,
      imageUrl: value.imageUrl,
      id: json.decode(response.body)['name'],
    );
    _items.add(newProduct);
    notifyListeners();
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://maxshopapp-f9422-default-rtdb.firebaseio.com/products/$id.json';
      await http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          },
        ),
      );
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {}
  }

  void deleteProduct(Product value) {
    final url =
        'https://maxshopapp-f9422-default-rtdb.firebaseio.com/products/${value.id}.json';
    http.delete(Uri.parse(url));
    _items.remove(value);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere(
      (item) => item.id == id,
    );
  }
}
// [
//     Product(
//       id: 'p1',
//       title: 'Red Shirt',
//       description: 'A red shirt - it is pretty red!',
//       price: 30.0,
//       imageUrl:
//           'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     ),
//     Product(
//       id: 'p2',
//       title: 'Trousers',
//       description: 'A nice pair of trousers.',
//       price: 60.0,
//       imageUrl:
//           'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
//     ),
//     Product(
//       id: 'p3',
//       title: 'Yellow Scarf',
//       description: 'Warm and cozy - exactly what you need for the winter.',
//       price: 20.0,
//       imageUrl:
//           'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
//     ),
//     Product(
//       id: 'p4',
//       title: 'A Pan',
//       description: 'Prepare any meal you want.',
//       price: 50.0,
//       imageUrl:
//           'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
//     ),
//   ]