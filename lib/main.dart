import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return Products();
      },
      child: MaterialApp(
        title: 'MyShop',
        initialRoute: ProductsOverviewScreen.id,
        routes: {
          ProductsOverviewScreen.id: (context) => ProductsOverviewScreen(),
          ProductDetailScreen.id: (context) => ProductDetailScreen(),
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
