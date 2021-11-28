import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_task/app/data/model/item_model.dart';
import 'package:shop_app_task/app/modules/cart/cart_controller.dart';
import 'package:shop_app_task/app/theme/color_theme.dart';
import 'package:shop_app_task/app/utils/helpers.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  final bool isCart;
  const ItemWidget(
    this.item, {
    Key? key,
    this.isCart = false,
  }) : super(key: key);

  CartController get cart => Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => !isCart ? checkableItem() : cartItem());
  }

  Widget checkableItem() {
    final isSelected = cart.items.contains(item);
    return CheckboxListTile(
      value: isSelected,
      // selected: isSelected,
      title: Text(item.name),
      activeColor: Palette.primary,
      subtitle: Text(currencyFormatter.format(item.price)),
      secondary: Image.asset("assets" + item.imagePath),
      onChanged: (value) => isSelected ? removeFromCart() : addToCart(),
    );
  }

  Widget cartItem() {
    return Stack(
      fit: StackFit.loose,
      children: [
        ListTile(
          title: Text(item.name),
          subtitle: Text(currencyFormatter.format(item.price)),
          leading: Image.asset("assets" + item.imagePath),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  item.decrease();
                  updateCart();
                },
                icon: const Icon(Icons.remove),
              ),
              SizedBox(
                width: 30.0,
                child: Center(
                  child: Text(
                    "${item.count}",
                    style: item.count > 0
                        ? const TextStyle(fontWeight: FontWeight.bold)
                        : null,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  item.increase();
                  updateCart();
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => cart.items.remove(item),
          icon: Icon(
            Icons.delete,
            color: Palette.primary2,
          ),
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        )
      ],
    );
  }

  void updateCart() {
    if (item.count > 0 && !cart.items.contains(item)) {
      cart.items.add(item);
      cart.items.assignAll(cart.items.toSet());
    } else if (item.count <= 0 && cart.items.contains(item)) {
      cart.items.assignAll(cart.items.toSet());
      cart.items.remove(item);
    }

    cart.items.removeWhere((element) => element.count <= 0);
  }

  void addToCart() {
    item.count = 1;
    updateCart();
  }

  void removeFromCart() {
    item.count = 0;
    updateCart();
  }
}
