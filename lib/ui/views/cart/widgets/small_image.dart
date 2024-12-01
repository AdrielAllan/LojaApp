import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';

class SmallImage extends StatelessWidget {
  const SmallImage({
    super.key,
    required this.urlImage,
  });

  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return Skeleton.replace(
      height: 40,
      width: 40,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.kTextColor, // Cor da borda
            width: 2, // Largura da borda
          ),
        ),
        child: Image.network(fit: BoxFit.cover, urlImage),
      ),
    );
  }
}
