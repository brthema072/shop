import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utils/app_routes.dart';

import './views/auth_screen.dart';
import './views/products_overview_screen.dart';
import './views/cart_screen.dart';
import './views/product_detail_screen.dart';
import './views/orders_screen.dart';
import './views/products_screen.dart';
import './views/product_form_screen.dart';
import 'views/auth_home_screen.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=> Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (ctx, auth, previousProducts)=> Products(auth.token, auth.userId, previousProducts.items),
        ),
        ChangeNotifierProvider(
          create: (_)=> Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_)=> Orders(),
          update: (ctx, auth, previousOrders) => Orders(auth.token, auth.userId, previousOrders.items),
        ),
      ],
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        // home: ProductOverViewScreen(),
        routes: {
          AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
          AppRoutes.CART: (ctx) => CartScreen(),
          AppRoutes.ORDERS: (ctx) => OrdersScreen(),
          AppRoutes.PRODUCTS: (ctx) => ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormScreen(),
        },
      ),
    );
  }
}