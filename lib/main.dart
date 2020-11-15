import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

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
        ChangeNotifierProvider(create: (BuildContext context) => Auth())
      ],
      child: Consumer<Auth>(
        builder: (context, authData, child) {
          return MaterialApp(
            title: 'MyShop',
            initialRoute:
                authData.isAuth ? ProductsOverviewScreen.id : AuthScreen.id,
            routes: {
              ProductsOverviewScreen.id: (context) => ProductsOverviewScreen(),
              ProductDetailScreen.id: (context) => ProductDetailScreen(),
              CartScreen.id: (context) => CartScreen(),
              OrdersScreen.id: (context) => OrdersScreen(),
              UserProductsScreen.id: (context) => UserProductsScreen(),
              EditProductScreen.id: (context) => EditProductScreen(),
              AuthScreen.id: (context) => AuthScreen(),
            },
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
            ),
            home: ProductsOverviewScreen(),
          );
        },
      ),
    );
  }
}
