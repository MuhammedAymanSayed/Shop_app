import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    Map<String, CartItem> x = _items;
    return x;
  }

  int get itemCount {
    int total = 0;
    _items.forEach((key, value) => total = total + value.quantity);
    return total;
  }

  double get totalAmount {
    double total = 0;
    _items.forEach(
      (key, value) => total = total + (value.price * value.quantity),
    );
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (value) => CartItem(
          id: value.id,
          title: value.title,
          price: value.price,
          quantity: value.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void deleteItem(String id) {
    _items.removeWhere((key, value) => value.id == id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    } else if (_items[id]!.quantity > 1) {
      _items.update(
        id,
        (value) => CartItem(
          id: value.id,
          title: value.title,
          quantity: value.quantity-1,
          price: value.price,
        ),
      );
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
