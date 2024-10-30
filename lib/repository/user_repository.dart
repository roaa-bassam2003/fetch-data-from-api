// lib/repositories/user_repository.dart

import '../model/user.dart';
import '../API/user_service.dart';

class UserRepository {
  final UserService _userService = UserService();

  Future<List<User>> fetchUsers() async {
    // Future extension: add local caching, database fetching, or other sources.
    return await _userService.fetchUsersFromApi();
  }
}
