import 'dart:math';

import 'package:flutter/foundation.dart';
import './product.dart';

class CartItem{
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price
  });
}

class Cart with ChangeNotifier{
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get item{
    return {..._items};
  }

  int get itemCount{
    return _items.length;
  }

  void addItem(Product p){
    if(_items.containsKey(p.id)){
      _items.update(p.id, 
        (existeingItem) => CartItem(
          id: existeingItem.id, 
          title: existeingItem.title, 
          quantity: existeingItem.quantity + 1, 
          price: existeingItem.price
        ),
      );
    }else{
      _items.putIfAbsent(p.id, 
        () => CartItem(
          id: Random().nextDouble().toString(),
          title: p.title,
          quantity: 1,
          price: p.price,
        ),
      );
    }

    notifyListeners();
  }
}