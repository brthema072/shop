import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../utils/app_routes.dart';
import '../widgets/app_drawer.dart';

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
  bool _isLoading = true;

  @override
  void initState(){
    super.initState();
    Provider.of<Products>(context, listen: false).loadProducts().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _refreshProduct(BuildContext context){
    return Provider.of<Products>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: new Text('Minha Loja', textAlign: TextAlign.center)),
        actions: <Widget>[
          Consumer<Cart>(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: (){
                Navigator.of(context).pushNamed(AppRoutes.CART);
              },
            ),
            builder: (_, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child,
            ),
          ),
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
          )
        ],
      ),
      body: _isLoading 
      ? Center(child: CircularProgressIndicator(),)
      : RefreshIndicator(
          onRefresh: ()=> _refreshProduct(context),
          child: ProductGrid(_showFavoriteOnly)
        ),
      drawer: AppDrawer(),
    );
  }
}