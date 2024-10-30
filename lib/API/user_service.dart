// lib/services/user_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class UserService {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<User>> fetchUsersFromApi() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
