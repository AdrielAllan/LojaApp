import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/models/group_model.dart';
import 'package:usanacaixaapp/ui/widgets/custom_button.dart';

class GroupCardCart extends StatelessWidget {
  const GroupCardCart({
    super.key,
    required this.group,
    required this.press,
  });

  final GroupModel group;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.2), // Cor da sombra com opacidade
                spreadRadius: 0, // Expansão da sombra
                blurRadius: 5, // Desfoque da sombra
                offset: const Offset(
                    0, 0), // Deslocamento horizontal e vertical da sombra
              ),
            ],
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : AppColors.kDarkColor2,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    group.name,
                    style: TextStyle(fontSize: 18),
                  ),
                  Skeleton.replace(
                    replacement: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        color: Colors.black,
                        child: Image.network(group.logoImage,
                            fit: BoxFit.fill, height: 70),
                      ),
                    ),
                  )
                ],
              ),
              CustomButton(
                isFixedWidth: false,
                onPressed: press,
                text: "Acessar carrinho",
                width: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
