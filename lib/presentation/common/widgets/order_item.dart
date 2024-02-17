import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '/presentation/resources/color_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../../domain/models/order.dart' as ord;

class OrderItems extends StatelessWidget {
  final ord.OrderItem order;
  const OrderItems(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: ExpansionTile(
        iconColor: ColorManager.error,
        collapsedIconColor: ColorManager.primary,
        title: Text(
          "\$${order.amount}",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        subtitle: Text(
          DateFormat("dd/MM/yyyy hh:mm").format(order.dateTime!),
          style: Theme.of(context).textTheme.displaySmall,
        ),
        children: order.products!
            .map(
              (prod) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(prod.title!,
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.start),
                  Text("${prod.quantity}X \$${prod.price}",
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.end)
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
