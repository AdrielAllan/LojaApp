import 'package:flutter/material.dart';
import 'package:usanacaixaapp/ui/views/product_details/product_details_view.dart';
import 'package:usanacaixaapp/viewmodels/product_details/product_details_viewmodel.dart';

class ProductDetailImage extends StatelessWidget {
  const ProductDetailImage({
    super.key,
    required this.widget,
    required this.viewModel,
  });

  final ProductDetailsView widget;
  final ProductDetailsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 300,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 300,
            width: 300,
            child: GestureDetector(
              onTap: () {
                viewModel.openFullscreenImage(widget.arguments.product.photo);
              },
              child: Image.network(
                widget.arguments.product.photo,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
