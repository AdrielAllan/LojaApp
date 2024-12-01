import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/http/http_client.dart';
import 'package:usanacaixaapp/data/models/group_model.dart';
import 'package:usanacaixaapp/data/repositories/auth_repository.dart';
import 'package:usanacaixaapp/data/repositories/group_repository.dart';
import 'package:usanacaixaapp/data/services/auth_service_token_storage.dart';

class GroupStore {
  final IGroupRepository groupRepository;
  final IAuthRepository authRepository = AuthRepository(client: HttpClient());
  final AuthServiceTokenStorage authService = AuthServiceTokenStorage();

  final ValueNotifier<List<GroupModel>> groups =
      ValueNotifier<List<GroupModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> errorMessage = ValueNotifier<String>("");

  GroupStore({required this.groupRepository});

  Future<void> fetchGroups() async {
    isLoading.value = true;

    try {
      groups.value = await groupRepository.getGroups();
    } catch (error) {
      errorMessage.value = error.toString();
      groups.value = [];
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
