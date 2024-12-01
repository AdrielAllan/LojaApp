import 'package:usanacaixaapp/data/models/product.model.dart';

List<String> getCategories(List<ProductModel> products) {
  final Set<String> uniqueCategories = {};

  for (final product in products) {
    if (product.variations.isNotEmpty) {
      final category = product.variations.first.category;
      if (category.isNotEmpty) {
        uniqueCategories.add(category);
      }
    }
  }

  return uniqueCategories.toList();
}
