// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:max_shop_app_12_1_22/Models/cart.dart';
import 'package:max_shop_app_12_1_22/Models/order.dart';
import 'package:max_shop_app_12_1_22/Widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartInputs = cart.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text('\$${cart.totalAmount}'),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrders(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Your Order has been submitted !'),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                    },
                    child: const Text('ORDER NOW'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) {
                  return CartWidget(
                    cartInputs.values.toList()[i].id,
                    cartInputs.values.toList()[i].price,
                    cartInputs.values.toList()[i].quantity,
                    cartInputs.values.toList()[i].title,
                    deleteItem: () {
                      cart.deleteItem(cartInputs.values.toList()[i].id);
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
