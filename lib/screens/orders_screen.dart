import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';

import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart' as OrderItemWidget;

class OrdersScreen extends StatelessWidget {
  static const id = 'orders_screen';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return OrderItemWidget.OrderItem(
            order: orderData.orders[index],
          );
        },
        itemCount: orderData.orders.length,
      ),
    );
  }
}
