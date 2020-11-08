import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

import '../models/product.dart';

class ManageProductsItem extends StatelessWidget {
  final Product product;

  const ManageProductsItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(product.imageUrl),
      ),
      title: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Text(product.title)),
      trailing: Container(
        width: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.id,
                    arguments: {'id': product.id});
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
