import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/manage_products_item.dart';

import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const id = 'user_products_screen';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.id);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (ctx, index) => ManageProductsItem(
            product: products.items[index],
          ),
          itemCount: products.items.length,
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
