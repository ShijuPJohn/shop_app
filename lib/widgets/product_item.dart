import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(routeName)
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          header: GridTileBar(
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.6),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.6),
            title: Text(
              '\$${product.price}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                //TODO
              },
              color: Theme.of(context).accentColor,
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                //TODO
              },
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
