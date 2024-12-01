import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/ui/widgets/custom_button.dart';

class NeedLoginView extends StatelessWidget {
  const NeedLoginView({super.key, required this.showLogin});

  final VoidCallback showLogin;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Theme.of(context).brightness == Brightness.light
                ? 'assets/images/login_light.svg'
                : 'assets/images/login_dark.svg',
            width: 200,
          ),
          Text("Ops... Você precisa de um login"),
          SizedBox(
            height: 20,
          ),
          CustomButton(
            isFixedWidth: false,
            onPressed: () {
              showLogin();
            },
            text: "Faça login ou registre-se",
            width: 0.8,
            buttonColor: AppColors.kPrimaryColor,
          )
        ],
      ),
    );
  }
}
