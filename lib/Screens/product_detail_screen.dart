import 'package:flutter/material.dart';
import 'package:max_shop_app_12_1_22/Models/cart.dart';
import 'package:max_shop_app_12_1_22/Models/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final String id;
  const ProductDetailScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(id);
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(
              loadedProduct.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '\$${loadedProduct.price}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              loadedProduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_circle),
        onPressed: () {
          cart.addItem(
            loadedProduct.id,
            loadedProduct.price,
            loadedProduct.title,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The Product has been added to your Cart !'),
              duration: Duration(milliseconds: 750),
            ),
          );
        },
      ),
    );
  }
}
