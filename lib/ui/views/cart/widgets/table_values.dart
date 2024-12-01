import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';

class TableValues extends StatelessWidget {
  const TableValues({
    super.key,
    required this.price,
    required this.salesTax,
    required this.serviceTax,
    required this.totalToPay,
  });

  final String price;
  final String salesTax;
  final String serviceTax;
  final String totalToPay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : AppColors.kDarkColor2),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Preço dos produtos",
                  style: TextStyle(color: AppColors.kTextColor),
                ),
                Text("\$ $price", style: TextStyle(color: AppColors.kTextColor))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sales tax",
                  style: TextStyle(color: AppColors.kTextColor),
                ),
                Text("\$ $salesTax",
                    style: TextStyle(color: AppColors.kTextColor))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Taxa de serviço",
                  style: TextStyle(color: AppColors.kTextColor),
                ),
                Text("\$ $serviceTax",
                    style: TextStyle(color: AppColors.kTextColor))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total da compra",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  "\$ $totalToPay",
                  style: TextStyle(fontWeight: FontWeight.w600),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
