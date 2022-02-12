import 'package:flutter/material.dart';
import 'package:max_shop_app_12_1_22/Models/cart.dart';
import 'package:max_shop_app_12_1_22/Models/order.dart';
import 'package:provider/provider.dart';
import 'Screens/product_overview_screen.dart';
import 'Models/products_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: const MaterialApp(
        title: 'My Shop',
        home: ProductOverviewScreen(),
      ),
    );
  }
}
