import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/presentation/resources/string_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../common/widgets/cart_item.dart';
import '../../common/widgets/order_button.dart';
import '../viewmodel/viewmodel.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringsManager.yourCart)),
      body: Consumer<CartViewModel>(builder: (context, viewModel, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: const EdgeInsets.all(AppMargin.m15),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.total,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const Spacer(),
                    Chip(
                      label: Text(
                        "\$${viewModel.totalAmount.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    viewModel.totalAmount <= 0
                        ? const SizedBox()
                        : const OrderButton(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSize.s10),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.itemCount,
                itemBuilder: (BuildContext ctx, int index) => CartItem(
                    viewModel.cartItems.values.toList()[index],
                    viewModel.cartItems.keys.toList()[index]),
              ),
            ),
          ],
        );
      }),
    );
  }
}
