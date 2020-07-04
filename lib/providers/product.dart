import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';

class Product with ChangeNotifier{
  final String _baseUrl = '${Constants.BASE_API_URL}/products';

  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
   this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false
  });

  void _toogleFavorite(){
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toogleFavorite(Product product) async{

    _toogleFavorite();

    try{
      final response = await http.patch(
        "$_baseUrl/${product.id}.json",
        body: json.encode({
          'isFavorite': isFavorite
        })
      );
      if(response.statusCode >=400){
       _toogleFavorite();
      }
    }catch(error){
      _toogleFavorite();
    }
    
  }
}