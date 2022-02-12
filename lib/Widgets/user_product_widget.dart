import 'package:flutter/material.dart';
import 'package:max_shop_app_12_1_22/Models/products_provider.dart';
import 'package:max_shop_app_12_1_22/Screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String title, imageUrl, subtitle, id;
  const UserProductItem({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.subtitle,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deleteProduct = Provider.of<Products>(context);
    return Column(
      children: [
        ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => EditProductScreen.special(
                        id: id,
                        isEditing: true,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  _deleteProduct.deleteProduct(_deleteProduct.findById(id));
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
