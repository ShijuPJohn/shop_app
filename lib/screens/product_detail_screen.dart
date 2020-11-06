import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const id = 'product_detail_screen';

  @override
  Widget build(BuildContext context) {
    final id = (ModalRoute.of(context).settings.arguments
        as Map<String, String>)['id'];
    final productId =
        Provider.of<Products>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(productId.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              width: double.infinity,
              color: Color.fromRGBO(0, 0, 0, 1),
              child: Text(
                productId.title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
            Image.network(
              productId.imageUrl,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text('\$${productId.price}'),
            Text('${productId.description}'),
            FlatButton(
              onPressed: () {
                //TODO
              },
              child: Text('Add to cart'),
            ),
            FlatButton(
              onPressed: () {
                //TODO
              },
              child: Text('Buy now'),
            ),
          ],
        ),
      ),
    );
  }
}
