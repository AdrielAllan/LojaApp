import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/ui/widgets/custom_button.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.grupo,
    required this.status,
    required this.valor,
    required this.dataSoliticitacao,
    required this.statusBackgroundColor,
    required this.statusTextColor,
    required this.actionData,
  });

  final String grupo;
  final String status;
  final String valor;
  final String dataSoliticitacao;
  final Color statusBackgroundColor;
  final Color statusTextColor;
  final Map<String, dynamic> actionData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : AppColors.kDarkColor2,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Cor da sombra com opacidade
            spreadRadius: 1, // Expansão da sombra
            blurRadius: 2, // Desfoque da sombra
            offset: const Offset(
                0, 0), // Deslocamento horizontal e vertical da sombra
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ajusta dinamicamente ao conteúdo
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(grupo),
                Container(
                  decoration: BoxDecoration(
                      color: statusBackgroundColor,
                      borderRadius: BorderRadius.circular(3)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    child: Text(
                      status,
                      style: TextStyle(color: statusTextColor, fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Valor:"), Text("\$ $valor")],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Data da Solicitação"), Text(dataSoliticitacao)],
            ),
            const SizedBox(height: 10),
            CustomButton(
              isFixedWidth: false,
              onPressed: actionData['action'] as VoidCallback,
              width: 1,
              text: actionData['text'],
            )
          ],
        ),
      ),
    );
  }
}
