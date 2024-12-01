import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/models/group_model.dart';
import 'package:usanacaixaapp/data/utils/format.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key,
    required this.press,
    required this.group,
  });

  final GroupModel group;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            press();
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.1), // Cor da sombra com opacidade
                      spreadRadius: 0, // Expansão da sombra
                      blurRadius: 5, // Desfoque da sombra
                      offset: const Offset(
                          0, 0), // Deslocamento horizontal e vertical da sombra
                    ),
                  ],
                ),
                child: Skeleton.replace(
                  height: 160,
                  width: 160,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      group.logoImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      _showBottomSheet(context, group.description);
                    },
                    child: const Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.getProportionateScreenWidth(10),
              ),
              Text(group.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: SizeConfig.getProportionateScreenWidth(10),
              ),
              Text("opening".tr(),
                  style: const TextStyle(color: AppColors.kTextColor)),
              Text(formatDateTime(group.openDate),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("closing".tr(),
                  style: const TextStyle(color: AppColors.kTextColor)),
              Text(formatDateTime(group.finishDate),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}

void _showBottomSheet(BuildContext context, String message) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (_, controller) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Informações da loja",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      message,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
