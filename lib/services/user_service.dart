import 'dart:convert';

import 'package:eventify/models/user_model.dart';
import 'package:eventify/services/token_service.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class UserService {
  final logger = Logger();
  static const baseURL = 'https://eventify.iaknowhow.es/public/api/';

  // TODO: Service Admin
  Future<List<UserModel>> getUsers() async {
    final token = await TokenService.getToken();

    final response = await http.get(
      Uri.parse('${baseURL}users'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      final users = (jsonResponse['data'] as List)
          .map((user) => UserModel.fromJson(user))
          .where((user) => user.deleted == 0)
          .where((user) => user.role != 'a')
          .toList();
      return users;
    } else {
      throw Exception('Error obteniendo los usuarios: ${jsonResponse['message']}');
    }
  }

  Future<bool> activateUser(int id) async {
    final token = await TokenService.getToken();

    final response = await http.post(
      Uri.parse('${baseURL}activate'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {'id': id.toString()},
    );

    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      return true;
    } else {
      logger.e('Error al activar el usuario: ${jsonResponse['message']}');
      return false;
    }
  }

  Future<bool> deactivateUser(int id) async {
    final token = await TokenService.getToken();

    final response = await http.post(
      Uri.parse('${baseURL}deactivate'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {'id': id.toString()},
    );

    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      return true;
    } else {
      logger.e('Error al desactivar el usuario: ${jsonResponse['message']}');
      return false;
    }
  }

  Future<bool> deleteUser(int id) async {
    final token = await TokenService.getToken();

    final response = await http.post(
      Uri.parse('${baseURL}deleteUser'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {'id': id.toString()},
    );

    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      return true;
    } else {
      logger.e('Error al eleiminar el usuario: ${jsonResponse['message']}');
      return false;
    }
  }

  Future<bool> updateUser(int id, String newName) async {
    final token = await TokenService.getToken();

    final response = await http.post(
      Uri.parse('${baseURL}updateUser'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {'id': id.toString(), 'name': newName},
    );

    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      return true;
    } else {
      logger.e('Error al actualizar el usuario: ${jsonResponse['message']}');
      return true;
    }
  }

  // TODO: Service User
  

  // TODO: Service Organizer
}
