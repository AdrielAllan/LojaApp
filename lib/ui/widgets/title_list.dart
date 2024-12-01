import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';

class TitleList extends StatelessWidget {
  const TitleList({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold)),
        Text(description,
            style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenHeight(12),
                color: AppColors.kTextColor))
      ],
    );
  }
}
