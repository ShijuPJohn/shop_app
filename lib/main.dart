import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';

import './providers/products.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => Products()),
        ChangeNotifierProvider(create: (BuildContext context) => Cart()),
        ChangeNotifierProvider(create: (BuildContext context) => Orders()),
      ],
      child: MaterialApp(
        title: 'MyShop',
        initialRoute: ProductsOverviewScreen.id,
        routes: {
          ProductsOverviewScreen.id: (context) => ProductsOverviewScreen(),
          ProductDetailScreen.id: (context) => ProductDetailScreen(),
          CartScreen.id: (context) => CartScreen(),
          OrdersScreen.id: (context) => OrdersScreen(),
        },
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        ),
        home: ProductsOverviewScreen(),
      ),
    );
  }
}
