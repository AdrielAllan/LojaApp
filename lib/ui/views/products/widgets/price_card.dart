import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({super.key, required this.price, this.promotionalPrice});

  final String price;
  final String? promotionalPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          promotionalPrice == null
              ? '\$${price.toString()}'
              : '\$${promotionalPrice.toString()}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 5),
        promotionalPrice == null
            ? const SizedBox.shrink()
            : Text(
                '\$$price',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  decorationColor: AppColors.kSecondaryColor,
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.kSecondaryColor,
                  decorationThickness: 2,
                ),
              ),
      ],
    );
  }
}
