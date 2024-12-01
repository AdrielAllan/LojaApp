import 'dart:convert';
import 'package:usanacaixaapp/data/http/http_client.dart';
import 'package:usanacaixaapp/data/models/product.model.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> getProducts(int groupId);

  Future<List<ProductModel>> getProductsbyCategory(
      int groupId, String category);
}

class ProductRepository implements IProductRepository {
  final IHttpClient client;

  ProductRepository({required this.client});

  @override
  Future<List<ProductModel>> getProducts(int groupId) async {
    final url =
        'https://worldborderless.com.br/aplicativo/api/groups/$groupId/products';
    final response = await client.get(url: url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      if (!body.containsKey('error') || body['error'] == 0) {
        final List<dynamic> products = body['products'];
        return products.map((json) => ProductModel.fromMap(json)).toList();
      } else {
        throw Exception('Erro na resposta da API: ${body['message']}');
      }
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error') || responseBody['error'] > 0) {
        throw Exception('Erro: ${responseBody['message']}');
      }
      throw Exception('Erro ao carregar produtos: ${response.statusCode}');
    }
  }

  @override
  Future<List<ProductModel>> getProductsbyCategory(
      int groupId, String category) async {
    final url =
        'https://worldborderless.com.br/aplicativo/api/groups/$groupId/$category/products';
    final response = await client.get(url: url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      if (!body.containsKey('error') || body['error'] == 0) {
        final List<dynamic> products = body['products'];
        return products.map((json) => ProductModel.fromMap(json)).toList();
      } else {
        throw Exception('Erro na resposta da API: ${body['message']}');
      }
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error') || responseBody['error'] > 0) {
        throw Exception('Erro: ${responseBody['message']}');
      }
      throw Exception('Erro ao carregar produtos: ${response.statusCode}');
    }
  }
}
