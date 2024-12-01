import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/ui/widgets/custom_button.dart';
import 'package:usanacaixaapp/viewmodels/cart/cart_viewmodel.dart';

class CheckoutContainer extends StatelessWidget {
  const CheckoutContainer({
    super.key,
    required this.viewmodel,
  });

  final CartViewModel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : AppColors.kDarkColor2,
          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(0.1), // Cor da sombra com opacidade
              spreadRadius: 0, // Expansão da sombra
              blurRadius: 5, // Desfoque da sombra
              offset: const Offset(
                  0, 0), // Deslocamento horizontal e vertical da sombra
            ),
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${viewmodel.store.cart.value!.totalToPay}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            CustomButton(
              isLoading: viewmodel.isLoading,
              isFixedWidth: true,
              width: 150,
              text: "Criar pedido",
              onPressed: () {
                viewmodel.checkOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
