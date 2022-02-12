// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class CartWidget extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final Function deleteItem;

  const CartWidget(
    this.id,
    this.price,
    this.quantity,
    this.title, {
    Key? key,
    required this.deleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Are you sure ?'),
                content: const Text(
                    'Do you want to delete the product from the cart ?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: const Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: const Text('Yes'),
                  ),
                ],
              );
            });
      },
      onDismissed: (_) {
        deleteItem();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The Product has been Deleted !'),
            duration: Duration(milliseconds: 750),
          ),
        );
      },
      background: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        alignment: Alignment.centerLeft,
        color: Colors.blueAccent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.delete,
              color: Colors.white,
              size: 26,
            ),
            SizedBox(width: 10),
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text('\$${price}'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
