import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';
import '../widgets/product_item.dart';
import '../utils/app_routes.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final products = Provider.of<Products>(context);

    final productItems = products.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos!'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_FORM
              );
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (ctx,i)=> Column(
            children: <Widget>[
              ProductItem(productItems[i]),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}