import 'package:flutter/material.dart';
import 'package:shop_app_flutter/widgets/app_drawer.dart';
import '../providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart' as order_widget;

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const route = "/orders";

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future? _orderFuture;
  Future obtainOrdersFuture() {
    return Provider.of<Orders>(context).fetchAndSetOrders();
  }

  @override
  void initState() {
    _orderFuture = obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future: _orderFuture,
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.hasError) {
                return Center(child: Text(dataSnapshot.error.toString()));
              } else {
                return Consumer<Orders>(
                    builder: (context, orderData, child) => ListView.builder(
                          itemBuilder: (context, index) {
                            return order_widget.OrderItem(
                              orderItem: orderData.orders[index],
                            );
                          },
                          itemCount: orderData.orders.length,
                        ));
              }
            }
          },
        ));
  }
}
