import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product.dart';

class Products with ChangeNotifier{
  final String _url = 'https://flutter-coder-4c7d4.firebaseio.com/products.json';
  
  List<Product> _items = [];

  List<Product> get items => [..._items];

  int get itemsCount{
    return _items.length;
  }
  
  List<Product> get favoriteItems {
    return _items.where((prod)=>prod.isFavorite).toList();
  }

  Future<void> loadProducts() async{
    final response = await http.get(_url);

    Map<String, dynamic> data = json.decode(response.body);

    if(data != null){
      _items.clear();
      data.forEach((productId, productData) {
        _items.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> addProduct(Product newProduct) async {

    final response = await http.post(
      _url, 
      body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl,
        'isFavorite': newProduct.isFavorite
      })
    );

    _items.add(Product(
      id: json.decode(response.body)['name'],
      title: newProduct.title,
      description: newProduct.description,
      price: newProduct.price,
      imageUrl: newProduct.imageUrl
    ));
    notifyListeners();
  }

  void updateProdut(Product product){
    if(product == null || product.id == null){
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);

    if(index > 0){
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id){
    final index = _items.indexWhere((prod) => prod.id == id);
    if(index >= 0){
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }
}