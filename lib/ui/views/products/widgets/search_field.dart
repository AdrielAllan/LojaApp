import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
            hintStyle: const TextStyle(color: AppColors.kTextColor),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: "search".tr(),
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.kTextColor,
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig.getProportionateScreenWidth(20),
                vertical: SizeConfig.getProportionateScreenWidth(9))),
      ),
    );
  }
}
