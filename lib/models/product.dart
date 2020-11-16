import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String authToken, String userId) async {
    final url =
        'https://shop-app-cc8bd.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken';
    final oldStatus = isFavorite;
    final productId = id;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        print('404');
        isFavorite = oldStatus;
        notifyListeners();
        throw HttpException('Couldn\'t complete request');
      }
    } catch (error) {
      print('inside catch block');
      isFavorite = oldStatus;
      notifyListeners();
      throw error;
    }
  }
}
