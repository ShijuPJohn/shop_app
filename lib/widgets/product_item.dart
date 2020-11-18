import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';

import '../models/product.dart';
import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailScreen.id, arguments: {'id': product.id});
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: GridTile(
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(
                product.imageUrl,
              ),
              fit: BoxFit.cover,
            ),
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
              builder: (BuildContext context, product, child) {
                return IconButton(
                  icon: Icon(product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () async {
                    try {
                      await product.toggleFavoriteStatus(
                          Provider.of<Auth>(context, listen: false).token,
                          Provider.of<Auth>(context, listen: false).userId);
                    } catch (error) {
                      scaffold.showSnackBar(SnackBar(
                        content: Text(
                          'Add as favorite failed',
                          textAlign: TextAlign.center,
                        ),
                      ));
                    }
                  },
                  color: Theme.of(context).accentColor,
                );
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added item to cart'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Theme.of(context).primaryColor,
                    action: SnackBarAction(
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                      label: 'Undo',
                    ),
                  ),
                );
              },
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
