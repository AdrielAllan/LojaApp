import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';

class SkeletonGroup extends StatelessWidget {
  const SkeletonGroup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skeleton.leaf(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.kPrimaryColor),
            height: 160,
            width: 160,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.getProportionateScreenWidth(10),
              ),
              Text(BoneMock.fullName,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: SizeConfig.getProportionateScreenWidth(10),
              ),
              Text("opening".tr(),
                  style: const TextStyle(color: AppColors.kTextColor)),
              Text(BoneMock.date,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("closing".tr(),
                  style: const TextStyle(color: AppColors.kTextColor)),
              Text(BoneMock.date,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}
