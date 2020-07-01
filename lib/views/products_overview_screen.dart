import 'package:flutter/material.dart';
import '../widgets/product_grid.dart';

enum FilterOptions{
  Favorite,
  All,
}

class ProductOverViewScreen extends StatefulWidget {

  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {

  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: new Text('Minha Loja', textAlign: TextAlign.center)),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue){
              setState(() {
                if(selectedValue == FilterOptions.Favorite){
                  _showFavoriteOnly = true;
                }else{
                  _showFavoriteOnly = false;
                }
              });
            },
            itemBuilder: (_)=>[
              PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: (){
              
            },
          )
        ],
      ),
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}