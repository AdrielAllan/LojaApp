import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';

class DescriptionItemCart extends StatelessWidget {
  const DescriptionItemCart({
    super.key,
    required this.productName,
    required this.productPrice,
  });

  final String productName;
  final String productPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            productName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text("\$$productPrice x 1",
            style: TextStyle(
              color: AppColors.kTextColor,
            ))
      ],
    );
  }
}
