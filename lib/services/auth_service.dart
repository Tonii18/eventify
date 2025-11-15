import 'dart:convert';
import 'package:eventify/models/user_model.dart';
import 'package:eventify/services/token_service.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class AuthService {
  final logger = Logger();
  static const String baseURL = 'https://eventify.iaknowhow.es/public/api/';

  // TODO : Service Register
  Future<UserModel?> registerUser(UserModel userModel) async {
    final response = await http.post(
      Uri.parse('${baseURL}register'),
      headers: {'Accept': 'application/json'},
      body: {
        'name': userModel.name,
        'email': userModel.email,
        'password': userModel.password,
        'c_password': userModel.password,
        'role': userModel.role,
      },
    );

    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      return UserModel.fromJson(jsonResponse['data']);
    } else {
      logger.e('Register failed: ${jsonResponse['message']}');
      return null;
    }
  }

  // TODO : Service Login
  Future<UserModel?> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${baseURL}login'),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password},
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonResponse['success'] == true) {
        final data = jsonResponse['data'];
        final token = data['token'];

        await TokenService.saveToken(token);
        await TokenService.saveUserId(data['id'].toString());

        return UserModel.fromJson(data);
      } else {
        logger.e('Login failed: ${jsonResponse['data']['error']}');
        return null;
      }
    } catch (e) {
      logger.e('Error in loginUser: $e');
      return null;
    }
  }

  // TODO : Service Logout
  Future<void> logout() async {
    await TokenService.deleteToken();
    logger.i('Token eliminado. Sesión cerrada.');
  }
}
