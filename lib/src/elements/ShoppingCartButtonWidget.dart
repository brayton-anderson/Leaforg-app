import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/cart_controller.dart';
import '../models/route_argument.dart';
import '../repository/user_repository.dart';

class ShoppingCartButtonWidget extends StatefulWidget {
  const ShoppingCartButtonWidget({
    this.iconColor,
    this.labelColor,
    Key key,
  }) : super(key: key);

  final Color iconColor;
  final Color labelColor;

  @override
  _ShoppingCartButtonWidgetState createState() =>
      _ShoppingCartButtonWidgetState();
}

class _ShoppingCartButtonWidgetState
    extends StateMVC<ShoppingCartButtonWidget> {
  CartController _con;

  _ShoppingCartButtonWidgetState() : super(CartController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForCartsCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (currentUser.value.apiToken != null) {
          Navigator.of(context).pushNamed('/Cart',
              arguments: RouteArgument(param: '/Pages', id: '2'));
        } else {
          Navigator.of(context).pushNamed('/Login');
        }
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          Icon(
            Icons.shopping_cart,
            color: this.widget.iconColor,
            size: 28,
          ),
          Container(
            child: Text(
              _con.cartCount.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption.merge(
                    TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
            ),
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            constraints: BoxConstraints(
                minWidth: 18, maxWidth: 18, minHeight: 18, maxHeight: 18),
          ),
        ],
      ),
      // fillColor: Colors.white,
    );
  }
}
