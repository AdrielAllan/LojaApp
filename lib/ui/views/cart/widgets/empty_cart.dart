import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Theme.of(context).brightness == Brightness.light
                ? 'assets/images/empty_cart_light.svg'
                : 'assets/images/empty_cart_dark.svg',
            width: 200,
          ),
          Text("Ops... Seu carrinho está vazio"),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
