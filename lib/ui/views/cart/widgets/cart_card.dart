import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/models/cart_model.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';
import 'package:usanacaixaapp/ui/views/cart/widgets/item_count.dart';
import 'package:usanacaixaapp/viewmodels/cart/cart_viewmodel.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.viewmodel,
    required this.cart,
  });

  final CartViewModel viewmodel;
  final CartItemModel cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            viewmodel.openFullscreenImage(cart.imagePath);
          },
          child: SizedBox(
            width: SizeConfig.getProportionateScreenWidth(88),
            height: SizeConfig.getProportionateScreenHeight(88),
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    fit: BoxFit.cover,
                    cart.imagePath,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.getProportionateScreenWidth(20),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      cart.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      maxLines: 2,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        viewmodel.deleteCartItem(cart.id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
              InkWell(
                onTap: () {
                  viewmodel.openObsModal(cart);
                },
                child: Text(
                  "Obs. +",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.kTextColor),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(TextSpan(
                      text: "\$${cart.unitPrice}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.kPrimaryColor),
                      children: [
                        TextSpan(
                          text: " x1",
                          style: TextStyle(color: AppColors.kTextColor),
                        )
                      ])),
                  ItemCount(
                    item: cart,
                    viewmodel: viewmodel,
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
