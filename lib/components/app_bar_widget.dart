import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int itemCountInCart;
  final VoidCallback onCartPressed;

  const MyAppBar({
    Key? key,
    required this.itemCountInCart,
    required this.onCartPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Your App Name'),
      centerTitle: true,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: onCartPressed,
          icon: Stack(
            children: [
              const Icon(
                Icons.shopping_cart,
                size: 32.0,
              ),
              itemCountInCart > 0
                  ? Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          itemCountInCart.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
