// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:max_shop_app_12_1_22/Models/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    List<OrderItem> newOrders = _orders;
    return newOrders;
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.add(
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> addOrders(List<CartItem> value, double total) async {
    const url =
        'https://maxshopapp-f9422-default-rtdb.firebaseio.com/orders.json';
    final timestamp = DateTime.now();
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': value
            .map((e) => {
                  'id': e.id,
                  'title': e.title,
                  'quantity': e.quantity,
                  'price': e.price,
                })
            .toList()
      }),
    );
    final newOrder = OrderItem(
      amount: total,
      dateTime: timestamp,
      id: json.decode(response.body)['name'],
      products: value,
    );
    _orders.add(newOrder);
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    const myUrl =
        'https://maxshopapp-f9422-default-rtdb.firebaseio.com/orders.json';
    final response = await http.get(Uri.parse(myUrl));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<OrderItem> loadedOrders = [];
    if (extractedData == null) {
      return;
    } else {
      extractedData.forEach((key, value) {
        loadedOrders.add(
          OrderItem(
            id: key,
            amount: value['amount'],
            dateTime: DateTime.parse(
              value['dateTime'],
            ),
            products: (value['products'] as List<dynamic>)
                .map((e) => CartItem(
                      id: e['id'],
                      title: e['title'],
                      quantity: e['quantity'],
                      price: e['price'],
                    ))
                .toList(),
          ),
        );
      });
    }
    _orders = loadedOrders;
    notifyListeners();
  }
}
// (value['products']as List<dynamic>).map((e) {
//             CartItem(
//               id: e.id,
//               title: e.title,
//               quantity: e.quantity,
//               price: e.price,
//             );
//           }).toList(),