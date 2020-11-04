import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const id = 'product_detail_screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Product>;
    var product = routeArgs['product'];
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              width: double.infinity,
              color: Color.fromRGBO(0, 0, 0, 1),
              child: Text(product.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                    fontSize: 25.0
                ),),
            ),
            Image.network(product.imageUrl),
          ],
        ),
      ),
    );
  }
}
