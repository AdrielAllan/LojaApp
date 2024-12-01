import 'package:usanacaixaapp/data/models/product.model.dart';

class ProductDetailsArguments {
  final ProductModel product;
  final int idGroup;

  ProductDetailsArguments({required this.product, required this.idGroup});
}
