import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String productId;

  CartItemWidget(
      {this.id, this.price, this.quantity, this.title, this.productId});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you want to remove the item from cart?'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('Not sure'),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text('Delete'),
                    )
                  ],
                ));
      },
      key: ValueKey(id),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        padding: EdgeInsets.only(right: 20.0),
        alignment: Alignment.centerRight,
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      direction: DismissDirection.endToStart,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              child: FittedBox(
                  child: Padding(
                      padding: EdgeInsets.all(5.0), child: Text('\$$price'))),
            ),
            title: Text(title),
            subtitle: Text('Total Amount: \$${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
