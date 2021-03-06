import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/manage_products_item.dart';

import './edit_product_screen.dart';

class UserProductsScreen extends StatefulWidget {
  static const id = 'user_products_screen';

  @override
  _UserProductsScreenState createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  Future<void> _refreshFunction() async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndStoreProducts(true);
  }

  @override
  void initState() {
    Provider.of<Products>(context, listen: false).fetchAndStoreProducts(true);
    super.initState();
  }

  void setStateFunction() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final products = Provider.of<Products>(context);
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
      body: FutureBuilder(
          future: _refreshFunction(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return RefreshIndicator(
                onRefresh: _refreshFunction,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Consumer<Products>(
                    builder: (ctx, productsData, child) => ListView.builder(
                      itemBuilder: (ctx, index) => ManageProductsItem(
                        product: productsData.items[index],
                        setStateCallback: setStateFunction,
                      ),
                      itemCount: productsData.items.length,
                    ),
                  ),
                ),
              );
            }
          }),
      drawer: AppDrawer(),
    );
  }
}
