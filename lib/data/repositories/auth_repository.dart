import 'dart:convert';
import 'package:usanacaixaapp/data/http/http_client.dart';
import 'package:usanacaixaapp/data/models/user_model.dart';
import 'package:usanacaixaapp/data/models/user_register_model.dart';

abstract class IAuthRepository {
  Future<UserModel> getUserInfo(String token);

  Future<String> registerUser(UserRegisterModel user);

  Future<String> loginUser(String email, String password);

  Future<void> checkSession(String token);
}

class AuthRepository implements IAuthRepository {
  final IHttpClient client;

  AuthRepository({required this.client});

  @override
  Future<UserModel> getUserInfo(String token) async {
    final url =
        'https://worldborderless.com.br/aplicativo/api/users/$token/info';
    final response = await client.get(url: url);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (!responseBody.containsKey('error') || responseBody['error'] == 0) {
        final dynamic user = responseBody['user'];
        return UserModel.fromMap(user);
      } else {
        throw Exception('Erro: ${responseBody['message']}');
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
  Future<String> registerUser(UserRegisterModel user) async {
    final url = 'https://worldborderless.com.br/aplicativo/api/register';

    // Converter o UserRegisterModel para JSON
    final body = jsonEncode(user.toMap());

    final response = await client.post(
      url: url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (!responseBody.containsKey('error') || responseBody['error'] == 0) {
        // Retorna token
        return responseBody['token'];
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
  Future<String> loginUser(String email, String password) async {
    final url = 'https://worldborderless.com.br/aplicativo/api/login';

    final body = jsonEncode({
      "email": email,
      "password": password,
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
        return responseBody['token'];
      } else {
        throw Exception('Erro ao acessar: ${responseBody['message']}');
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
  Future<void> checkSession(String token) async {
    final url =
        'https://worldborderless.com.br/aplicativo/api/auth/validate/$token';
    final response = await client.get(url: url);

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);

      if (!responseBody.containsKey('error') || responseBody['error'] == 0) {
      } else {
        throw Exception('Erro na resposta da API: ${responseBody['message']}');
      }
    } else {
      jsonDecode(response.body);
    }
  }
}
