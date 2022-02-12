import 'package:flutter/material.dart';
import 'package:max_shop_app_12_1_22/Models/cart.dart';
import 'package:max_shop_app_12_1_22/Models/products.dart';
import 'package:max_shop_app_12_1_22/Screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (builder) => ProductDetailScreen(id: product.id),
            ),
          );
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            leading: Consumer<Product>(builder: (context, product, child) {
              return IconButton(
                onPressed: product.toggleFavouriteStatus,
                icon: product.isFavourite
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      )
                    : const Icon(Icons.favorite_border),
              );
            }),
            trailing: IconButton(
                onPressed: () {
                  cart.addItem(
                    product.id,
                    product.price,
                    product.title,
                  );
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          const Text('The Product has been added to your Cart !'),
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                        label:  'UNDO',
                        onPressed: ()=>cart.removeSingleItem(product.id),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.local_grocery_store)),
          ),
        ),
      ),
    );
  }
}
