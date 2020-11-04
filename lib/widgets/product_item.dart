import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context,listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailScreen.id, arguments: {'product': product});
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
              style: TextStyle(fontSize: 12.0),
            ),
            leading: Consumer<Product>(
              builder: (BuildContext context, product, Widget child) {
                return IconButton(
                  icon: Icon(product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () {
                    product.toggleFavoriteStatus();
                  },
                  color: Theme.of(context).accentColor,
                );
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
              },
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
