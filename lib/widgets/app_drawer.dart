import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import '../utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title:Text('Bem vindo Usuário!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Loja'),
            onTap: (){
              Navigator.of(context).pushNamed(
                AppRoutes.AUTH_HOME
              );
            },
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos'),
            onTap: (){
              Navigator.of(context).pushNamed(
                AppRoutes.ORDERS
              );
            },
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerenciar Produtos'),
            onTap: (){
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCTS
              );
            },
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: (){
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}