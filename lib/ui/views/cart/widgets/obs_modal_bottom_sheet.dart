import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/models/cart_model.dart';
import 'package:usanacaixaapp/ui/widgets/custom_button.dart';
import 'package:usanacaixaapp/ui/widgets/custom_field.dart';
import 'package:usanacaixaapp/viewmodels/cart/cart_viewmodel.dart';

Future<void> onShowBottomSheetObs(BuildContext context, CartItemModel item,
    VoidCallback press, CartViewModel viewmodel) async {
  viewmodel.obsController.text = item.obs;

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Permite ajustar com base no teclado
    backgroundColor: Colors.transparent,
    builder: (context) {
      final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
      final heightFactor =
          keyboardVisible ? 0.9 : 0.4; // Aumenta o modal com o teclado

      return FractionallySizedBox(
        heightFactor: heightFactor,
        child: AnimatedBuilder(
            animation: Listenable.merge([
              viewmodel.store.isObsLoading,
              viewmodel.store.errorMessage,
              viewmodel.store.cart,
              viewmodel.authViewModel.store.user
            ]),
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                    bottom: keyboardVisible
                        ? MediaQuery.of(context).viewInsets.bottom
                        : 16, // Ajusta para o teclado
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Indicador para arrastar
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // Campo de texto
                      Expanded(
                        child: CustomTextField(
                          isMultiline: true,
                          fieldHeight: 200,
                          width: 1,
                          isFixedWidth: false,
                          hintText:
                              "Digite a observação para o produto ${item.name}",
                          isRequired: false,
                          inputType: TextInputType.text,
                          controller: viewmodel.obsController,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Botão para salvar
                      CustomButton(
                        isLoading: viewmodel.isObsLoading,
                        buttonColor: AppColors.kPrimaryColor,
                        isFixedWidth: false,
                        onPressed: press,
                        width: 1,
                        text: "Salvar",
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    },
  );
}
