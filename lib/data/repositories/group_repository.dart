import 'dart:convert';
import 'package:usanacaixaapp/data/http/http_client.dart';
import '../models/group_model.dart';

abstract class IGroupRepository {
  Future<List<GroupModel>> getGroups();
}

class GroupRepository implements IGroupRepository {
  final IHttpClient client;

  GroupRepository({required this.client});

  @override
  Future<List<GroupModel>> getGroups() async {
    final response = await client.get(
        url: 'https://worldborderless.com.br/aplicativo/api/groups/list');

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      if (body['error'] == 0) {
        final List<dynamic> groups = body['groups'];
        return groups.map((json) => GroupModel.fromMap(json)).toList();
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
