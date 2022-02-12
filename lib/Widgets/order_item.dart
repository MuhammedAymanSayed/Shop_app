import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:max_shop_app_12_1_22/Models/order.dart';

class OrderWidget extends StatefulWidget {
  final OrderItem order;
  const OrderWidget({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              DateFormat(
                'dd-MM-yyyy hh:mm',
              ).format(widget.order.dateTime),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: _expanded
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_more),
            ),
          ),
          if (_expanded)
            SizedBox(
              height: min(widget.order.products.length * 20, 100),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: widget.order.products
                    .map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '${e.quantity}x \$${e.price}',
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
