import 'package:flutter/material.dart';
import 'package:max_shop_app_12_1_22/Models/order.dart';
import 'package:max_shop_app_12_1_22/Widgets/drawer.dart';
import 'package:max_shop_app_12_1_22/Widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final orderData = Provider.of<Orders>(context).orders;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchOrders(),
        builder: (ctx,data){
        if (data.connectionState==ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderWidget(order: orderData.orders[i]),
      ),
              );
        }
      })
    );
  }
}
// ListView.builder(
//         itemCount: orderData.length,
//         itemBuilder: (ctx, i) => OrderWidget(order: orderData[i]),
//       ),