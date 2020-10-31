import 'package:flutter/material.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      initialRoute: ProductsOverviewScreen.id,
      routes: {
        ProductsOverviewScreen.id: (context) => ProductsOverviewScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
      ),
      home: ProductsOverviewScreen(),
    );
  }
}
