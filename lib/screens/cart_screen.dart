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
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                      child: Text('ORDER NOW'),
                      onPressed: cart.cartTotalPrice <= 0
                          ? null
                          : () {
                              Provider.of<Orders>(context, listen: false)
                                  .addOrder(cart.items.values.toList(),
                                      cart.cartTotalPrice);
                              cart.clearCart();
                            },
                      textColor: Theme.of(context).primaryColor,
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

class OrderButton extends StatefulWidget {
  final Cart cart;

  const OrderButton({Key key, this.cart}) : super(key: key);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      onPressed: (widget.cart.cartTotalPrice <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(),
                  widget.cart.cartTotalPrice);
              setState(() {
                _isLoading = false;
              });
              widget.cart.clearCart();
            },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
