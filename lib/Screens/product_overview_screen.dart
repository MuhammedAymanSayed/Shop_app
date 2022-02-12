import 'package:flutter/material.dart';
import 'package:max_shop_app_12_1_22/Models/cart.dart';
import 'package:max_shop_app_12_1_22/Models/products_provider.dart';
import 'package:max_shop_app_12_1_22/Screens/cart_screen.dart';
import 'package:max_shop_app_12_1_22/Widgets/badge.dart';
import 'package:max_shop_app_12_1_22/Widgets/drawer.dart';

import 'package:max_shop_app_12_1_22/Widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showOnlyFavorite = false;
  bool isInit = true;
  bool isLoading = false;
  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Products>(context).fetchProducts().catchError((onError) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Error'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('okay'),
                  ),
                ],
              );
            });
      }).then((value) {
        setState(() {
          isLoading = false;
        });
      });
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) {
              return Badge(
                child: ch as Widget,
                value: cart.itemCount.toString(),
              );
            },
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const CartScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.favorites) {
                  _showOnlyFavorite = true;
                } else {
                  _showOnlyFavorite = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Only Fav'),
                value: FilterOptions.favorites,
              ),
              const PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.all,
              ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorite),
    );
  }
}
