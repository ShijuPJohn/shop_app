import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

import '../models/product.dart';

class Products with ChangeNotifier {
  final String authToken;
  final String userId;
  bool _disposed = false;
  List<Product> _items = [];

  Products(this.authToken, this._items, this.userId);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Future<void> fetchAndStoreProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? '&orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://shop-app-cc8bd.firebaseio.com/products.json?auth=$authToken$filterString';
    try {
      final response = await http.get(url);
      final decodedResponse =
          json.decode(response.body) as Map<String, dynamic>;
      List<Product> listOfProducts = [];
      if (decodedResponse == null) {
        return;
      }
      url =
          'https://shop-app-cc8bd.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteDecodedData = json.decode(favoriteResponse.body);
      decodedResponse.forEach((key, value) {
        var tempProduct = Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imageUrl: value['imageUrl'],
            isFavorite: favoriteDecodedData == null
                ? false
                : favoriteDecodedData[key] ?? false);
        listOfProducts.add(tempProduct);
      });
      _items = listOfProducts;
      notifyListeners();
      print('here14');
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://shop-app-cc8bd.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId,
            // 'isFavorite': product.isFavorite,
          }));

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
        // isFavorite: false,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print('add product catch section');
      throw error;
    }
  }

  Future<void> editProduct(String id, Product newProduct) async {
    Product product = findById(id);
    product.title = newProduct.title;
    product.price = newProduct.price;
    product.description = newProduct.description;
    product.imageUrl = newProduct.imageUrl;
    final url =
        'https://shop-app-cc8bd.firebaseio.com/products/$id.json?auth=$authToken';
    await http.patch(url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
        }));
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://shop-app-cc8bd.firebaseio.com/products/$id.json';
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    existingProduct = null;

    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
