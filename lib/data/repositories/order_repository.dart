import 'dart:convert';
import 'package:usanacaixaapp/data/http/http_client.dart';
import 'package:usanacaixaapp/data/models/order_details_model.dart';
import 'package:usanacaixaapp/data/models/order_model.dart';

abstract class IOrderRepository {
  Future<OrderModel> getOrder(String token);

  Future<OrderDetailsModel> getOrderDetails(String token, int idOrder);

  Future<int> createOrder(String token, int idGroup);

  Future<String> payParceladoUsa(String token, int idOrder);

  Future<String> payParcelow(String token, int idOrder);

  Future<String> payBrazilPays(String token, int idOrder);

  Future<String> payCredits(String token, int idOrder);
}

class OrderRepository implements IOrderRepository {
  final IHttpClient client;

  OrderRepository({required this.client});

  @override
  Future<OrderModel> getOrder(String token) async {
    final url = 'https://worldborderless.com.br/aplicativo/api/user/orders';

    final body = jsonEncode({
      "auth_token": token,
    });

    final response = await client.post(
      url: url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (!responseBody.containsKey('error') || responseBody['error'] == 0) {
        return OrderModel.fromMap(responseBody);
      } else {
        throw ('Erro no registro: ${responseBody['message']}');
      }
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error') || responseBody['error'] > 0) {
        throw ('Erro: ${responseBody['message']}');
      }
      throw ('Erro na requisição: ${response.statusCode}');
    }
  }

  @override
  Future<OrderDetailsModel> getOrderDetails(String token, int idOrder) async {
    final url = 'https://worldborderless.com.br/aplicativo/api/orders/details';

    final body = jsonEncode({
      "auth_token": token,
      "order_id": idOrder,
    });

    final response = await client.post(
      url: url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (!responseBody.containsKey('error') || responseBody['error'] == 0) {
        return OrderDetailsModel.fromMap(responseBody);
      } else {
        throw ('Erro no registro: ${responseBody['message']}');
      }
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error') || responseBody['error'] > 0) {
        throw ('Erro: ${responseBody['message']}');
      }
      throw ('Erro na requisição: ${response.statusCode}');
    }
  }

  @override
  Future<int> createOrder(String token, int idGroup) async {
    final url =
        'https://worldborderless.com.br/aplicativo/api/groups/cart/order';

    final body = jsonEncode({
      "auth_token": token,
      "group_id": idGroup,
    });

    final response = await client.post(
      url: url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (!responseBody.containsKey('error') ||
          responseBody['error'] == false) {
        return responseBody["order_id"];
      } else {
        throw ('Erro no registro: ${responseBody['message']}');
      }
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error') || responseBody['error'] == true) {
        throw ('Erro: ${responseBody['message']}');
      }
      throw ('Erro na requisição: ${response.statusCode}');
    }
  }

  @override
  Future<String> payParceladoUsa(String token, int idOrder) async {
    final url =
        'https://worldborderless.com.br/aplicativo/api/groups/payment/parceladousa';

    final body = jsonEncode({
      "auth_token": token,
      "order_id": idOrder,
    });

    final response = await client.post(
      url: url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (!responseBody.containsKey('error') ||
          responseBody['error'] == false) {
        return responseBody["payment_link"];
      } else {
        throw ('Erro no registro: ${responseBody['message']}');
      }
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error') || responseBody['error'] == true) {
        throw ('${responseBody['message']}');
      }
      throw ('Erro na requisição: ${response.statusCode}');
    }
  }

  @override
  Future<String> payBrazilPays(String token, int idOrder) async {
    final url =
        'https://worldborderless.com.br/aplicativo/api/groups/payment/brazilpays';

    final body = jsonEncode({
      "auth_token": token,
      "type": 3,
      "order_id": idOrder,
    });

    final response = await client.post(
      url: url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (!responseBody.containsKey('error') ||
          responseBody['error'] == false) {
        return responseBody["payment_link"];
      } else {
        throw ('Erro no registro: ${responseBody['message']}');
      }
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error') || responseBody['error'] == true) {
        throw ('${responseBody['message']}');
      }
      throw ('Erro na requisição: ${response.statusCode}');
    }
  }

  @override
  Future<String> payCredits(String token, int idOrder) async {
    final url =
        'https://worldborderless.com.br/aplicativo/api/groups/payment/credits';

    final body = jsonEncode({
      "auth_token": token,
      "order_id": idOrder,
    });

    final response = await client.post(
      url: url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (!responseBody.containsKey('error') ||
          responseBody['error'] == false) {
        return responseBody["message"];
      } else {
        throw ('Erro no registro: ${responseBody['message']}');
      }
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error') || responseBody['error'] == true) {
        throw ('${responseBody['message']}');
      }
      throw ('Erro na requisição: ${response.statusCode}');
    }
  }

  @override
  Future<String> payParcelow(String token, int idOrder) async {
    final url =
        'https://worldborderless.com.br/aplicativo/api/groups/payment/parcelow';

    final body = jsonEncode({
      "auth_token": token,
      "order_id": idOrder,
    });

    final response = await client.post(
      url: url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (!responseBody.containsKey('error') ||
          responseBody['error'] == false) {
        return responseBody["payment_link"];
      } else {
        throw ('Erro no registro: ${responseBody['message']}');
      }
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error') || responseBody['error'] == true) {
        throw ('${responseBody['message']}');
      }
      throw ('Erro na requisição: ${response.statusCode}');
    }
  }
}
