import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  
  final CartItem cartItem;

   CartItemWidget(this.cartItem);
  
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right:20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical:4
        ),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size:40
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_){
        return showDialog(
          context: context,
          builder: (ctx)=> AlertDialog(
            title: Text('Tem certeza?'),
            content: Text('Deseja remover este item do seu carrinho?'),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
                child: Text('Não'),
              ),
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
                child: Text('Sim'),
              ),
            ],
          ) 
        );
      },
      onDismissed: (_){
        Provider.of<Cart>(context, listen: false).removeItem(cartItem.productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(  
              child: Padding(
                padding: EdgeInsets.all(3),
                child: FittedBox(
                  child: Text('${cartItem.price}'),
                ),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text('Total R\$ ${cartItem.price * cartItem.quantity}'),
            trailing: Text('${cartItem.quantity}x'),
          ),
        ),
      ),
    );
  }
}