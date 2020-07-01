import 'dart:math';

import 'package:flutter/foundation.dart';
import './product.dart';

class CartItem{
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.quantity,
    @required this.price
  });
}

class Cart with ChangeNotifier{
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items{
    return {..._items};
  }

  int get itemsCount{
    return _items.length;
  }


  double get totalAmount{
    double total = 0.0;

    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  } 

  void addItem(Product p){
    if(_items.containsKey(p.id)){
      _items.update(p.id, 
        (existeingItem) => CartItem(
          id: existeingItem.id, 
          productId: p.id, 
          title: existeingItem.title, 
          quantity: existeingItem.quantity + 1, 
          price: existeingItem.price
        ),
      );
    }else{
      _items.putIfAbsent(p.id, 
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: p.id,
          title: p.title,
          quantity: 1,
          price: p.price,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  void clear(){
    _items = {

    };
    notifyListeners();
  }
}