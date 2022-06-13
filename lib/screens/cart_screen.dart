import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/card.dart' show Cart;
import 'package:shop_app_flutter/providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const route = '/cartScreen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("my Cart"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return CartItem(
                  productId: cart.items.keys.toList()[index],
                  id: cart.items.values.toList()[index].id,
                  title: cart.items.values.toList()[index].title,
                  quantity: cart.items.values.toList()[index].quantity,
                  price: cart.items.values.toList()[index].price);
            },
            itemCount: cart.items.length,
          )),
          SizedBox(
            height: 10,
          ),
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(label: Text('\$' + cart.totalPrice.toStringAsFixed(2))),
                  orderButton(cart: cart)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class orderButton extends StatefulWidget {
  const orderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<orderButton> createState() => _orderButtonState();
}

class _orderButtonState extends State<orderButton> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (widget.cart.totalPrice <= 0 || isLoading == true)
            ? null
            : () async {
                setState(() {
                  isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrder(
                    widget.cart.items.values.toList(), widget.cart.totalPrice);
                setState(() {
                  isLoading = false;
                });
                widget.cart.clear();
              },
        child: isLoading ? CircularProgressIndicator() : Text("Submit Order"));
  }
}
