import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
    required this.press,
  });
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        press();
      },
      child: Container(
        height: SizeConfig.getProportionateScreenWidth(46),
        width: SizeConfig.getProportionateScreenWidth(46),
        decoration: BoxDecoration(
            color: AppColors.kPrimaryColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8)),
        child: const Icon(
          Icons.shopping_cart_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
