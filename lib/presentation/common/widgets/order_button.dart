import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/presentation/resources/color_manager.dart';
import '../../cart_screen/viewmodel/viewmodel.dart';
import '../../orders_screen/viewmodel/viewmodel.dart';
import '/presentation/resources/string_manager.dart';

class OrderButton extends StatefulWidget {
  const OrderButton({super.key});

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<OrdersViewModel, CartViewModel>(
      builder: (ctx, orderViewModel, cartViewModel, _) => TextButton(
        style: TextButton.styleFrom(backgroundColor: ColorManager.green),
        onPressed: orderViewModel.isLoading
            ? null
            : () {
                orderViewModel.addOrder(cartViewModel.cartItems.values.toList(),
                    cartViewModel.totalAmount, context);
              },
        child: orderViewModel.isLoading
            ? CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )
            : Text(
                StringsManager.orderNow,
                style: Theme.of(context).textTheme.displayMedium,
              ),
      ),
    );
  }
}
