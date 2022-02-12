import 'package:flutter/material.dart';
import 'package:max_shop_app_12_1_22/Screens/orders_screen.dart';
import 'package:max_shop_app_12_1_22/Screens/product_overview_screen.dart';
import 'package:max_shop_app_12_1_22/Screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Friend !'),
            automaticallyImplyLeading: false,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  color: Colors.white,
                  child: ListTile(
                    title: const Text(
                      'Shop',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                    leading: const Icon(Icons.shop_two),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => const ProductOverviewScreen(),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  elevation: 5,
                  color: Colors.white,
                  child: ListTile(
                    title: const Text(
                      'My Orders',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                    leading: const Icon(Icons.description),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => const OrdersScreen(),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  elevation: 5,
                  color: Colors.white,
                  child: ListTile(
                    title: const Text(
                      'Manage Products',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                    leading: const Icon(Icons.edit),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => const UserProductsScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
