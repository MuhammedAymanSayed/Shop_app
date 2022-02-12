import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  bool isTaken;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
    this.isTaken = false,
  });

  void toggleFavouriteStatus() async {
    isFavourite = !isFavourite;
    notifyListeners();
    final url =
        'https://maxshopapp-f9422-default-rtdb.firebaseio.com/products/$id.json';
    await http.patch(
      Uri.parse(url),
      body: json.encode(
        {'isFavourite': isFavourite},
      ),
    );
  }
}
