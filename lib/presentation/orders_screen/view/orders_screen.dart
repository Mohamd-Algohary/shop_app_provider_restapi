import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/presentation/resources/string_manager.dart';
import '../../common/widgets/app_drawer.dart';
import '../../common/widgets/order_item.dart';
import '../viewmodel/viewmodel.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringsManager.yourOrder)),
      body: FutureBuilder(
        future: Provider.of<OrdersViewModel>(context, listen: false)
            .fetchOrders(context),
        builder: (ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          } else {
            return Consumer<OrdersViewModel>(
              builder: (ctx, orderViewModel, _) => orderViewModel.orders.isEmpty
                  ? Center(
                      child: Text(StringsManager.noOrdersYet,
                          style: Theme.of(context).textTheme.displayMedium),
                    )
                  : ListView.builder(
                      itemCount: orderViewModel.orders.length,
                      itemBuilder: (_, index) {
                        return OrderItems(orderViewModel.orders[index]);
                      },
                    ),
            );
          }
        },
      ),
      drawer: Appdrawer(),
    );
  }
}
