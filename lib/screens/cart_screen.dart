import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';

import '../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  static const id = 'cart_screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.cartTotalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme
                              .of(context)
                              .primaryTextTheme
                              .headline6
                              .color,
                        ),
                      ),
                      backgroundColor: Theme
                          .of(context)
                          .primaryColor,
                    ),
                    FlatButton(
                      child: Text('ORDER NOW'),
                      onPressed: () {
                        Provider.of<Orders>(context,listen: false).addOrder(
                            cart.items.values.toList(), cart.cartTotalPrice);
                        cart.clearCart();
                      },
                      textColor: Theme
                          .of(context)
                          .primaryColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.cartItemsCount,
                itemBuilder: (context, index) {
                  return CartItemWidget(
                      productId: cart.items.keys.toList()[index],
                      id: cart.items.values.toList()[index].id,
                      price: cart.items.values.toList()[index].price,
                      quantity: cart.items.values.toList()[index].quantity,
                      title: cart.items.values.toList()[index].title);
                },
              ),
            )
          ],
        ));
  }
}
