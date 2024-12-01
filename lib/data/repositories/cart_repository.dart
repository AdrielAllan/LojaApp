import 'dart:convert';
import 'package:usanacaixaapp/data/http/http_client.dart';
import 'package:usanacaixaapp/data/models/cart_model.dart';

abstract class ICartRepository {
  Future<CartModel> getCart(String token, int idGroup);

  Future<void> addCart(String idProduct, String token);

  Future<void> removeCartUnit(String idProduct, String token);

  Future<void> deleteCartItem(String idProduct, String token);

  Future<void> addObs(String idProduct, String token, String obs);
}

class CartRepository implements ICartRepository {
  final IHttpClient client;

  CartRepository({required this.client});

  @override
  Future<CartModel> getCart(String token, int idGroup) async {
    final response = await client.get(
      url:
          'https://worldborderless.com.br/aplicativo/api/groups/$idGroup/cart/$token',
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      if (body['error'] == 0) {
        return CartModel.fromMap(body);
      } else {
        throw Exception('Erro na resposta da API: ${body['message']}');
      }
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error') && responseBody['error'] == true) {
        throw ('${responseBody['message']}');
      }
      throw ('Erro ao carregar carrinho: ${response.statusCode}');
    }
  }

  @override
  Future<void> addCart(String idProduct, String token) async {
    final url =
        'https://worldborderless.com.br/aplicativo/api/products/cart/add';

    final body = jsonEncode({
      "auth_token": token,
      "product_uuid": idProduct,
    });

    final response = await client.post(
      url: url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (!responseBody.containsKey('error') || responseBody['error'] == 0) {
        // Retorna token
      } else {
        throw Exception('Erro no registro: ${responseBody['message']}');
      }
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error') || responseBody['error'] > 0) {
        throw Exception('Erro: ${responseBody['message']}');
      }
      throw Exception('Erro na requisição: ${response.statusCode}');
    }
  }

  @override
  Future<void> addObs(String idProduct, String token, String obs) async {
    final url =
        'https://worldborderless.com.br/aplicativo/api/cart/add-observations';

    final body = jsonEncode(
        {"auth_token": token, "product_uuid": idProduct, "observations": obs});

    final response = await client.post(
      url: url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (!responseBody.containsKey('error') || responseBody['error'] == 0) {
        // Retorna token
      } else {
        throw Exception('Erro no registro: ${responseBody['message']}');
      }
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error') || responseBody['error'] > 0) {
        throw Exception('Erro: ${responseBody['message']}');
      }
      throw Exception('Erro na requisição: ${response.statusCode}');
    }
  }

  @override
  Future<void> removeCartUnit(String idProduct, String token) async {
    final url =
        'https://worldborderless.com.br/aplicativo/api/products/cart/remove';

    final body = jsonEncode({
      "auth_token": token,
      "product_uuid": idProduct,
    });

    final response = await client.post(
      url: url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (!responseBody.containsKey('error') || responseBody['error'] == 0) {
        // Retorna token
      } else {
        throw Exception('Erro no registro: ${responseBody['message']}');
      }
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error') || responseBody['error'] > 0) {
        throw Exception('Erro: ${responseBody['message']}');
      }
      throw Exception('Erro na requisição: ${response.statusCode}');
    }
  }

  @override
  Future<void> deleteCartItem(String idProduct, String token) async {
    final url =
        'https://worldborderless.com.br/aplicativo/api/products/cart/delete';

    final body = jsonEncode({
      "auth_token": token,
      "product_uuid": idProduct,
    });

    final response = await client.post(
      url: url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (!responseBody.containsKey('error') || responseBody['error'] == 0) {
        // Retorna token
      } else {
        throw Exception('Erro no registro: ${responseBody['message']}');
      }
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error') || responseBody['error'] > 0) {
        throw Exception('Erro: ${responseBody['message']}');
      }
      throw Exception('Erro na requisição: ${response.statusCode}');
    }
  }
}
