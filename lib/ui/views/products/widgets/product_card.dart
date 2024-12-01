import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/models/product.model.dart';
import 'package:usanacaixaapp/ui/views/products/widgets/price_card.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.press});

  final ProductModel product;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: GestureDetector(
        onTap: press,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: product.photo.isNotEmpty
                            ? Image.network(
                                product.photo,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              )
                            : const Icon(Icons.image_not_supported),
                      ),
                      Positioned(
                          child: Container(
                        decoration: const BoxDecoration(
                            gradient: AppColors.kPrimaryGradientColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 8),
                          child: Text(
                            product.variations[0].category,
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      product.variations[0].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    PriceCard(
                      price: product.variations[0].price,
                      promotionalPrice: product.variations[0].promotionalPrice,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
