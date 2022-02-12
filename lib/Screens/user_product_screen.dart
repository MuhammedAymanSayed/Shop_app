import 'package:flutter/material.dart';
import 'package:max_shop_app_12_1_22/Models/products_provider.dart';
import 'package:max_shop_app_12_1_22/Screens/edit_product_screen.dart';
import 'package:max_shop_app_12_1_22/Widgets/drawer.dart';
import 'package:max_shop_app_12_1_22/Widgets/user_product_widget.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (c) => EditProductScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: ()=>productsData.fetchProducts(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (ctx, i) {
              return UserProductItem(
                id: productsData.items[i].id,
                imageUrl: productsData.items[i].imageUrl,
                title: productsData.items[i].title,
                subtitle: productsData.items[i].price.toString(),
              );
            },
          ),
        ),
      ),
    );
  }
}
