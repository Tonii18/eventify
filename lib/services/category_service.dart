import 'dart:convert';

import 'package:eventify/models/category_model.dart';
import 'package:eventify/services/token_service.dart';
import 'package:logger/logger.dart';

import 'package:http/http.dart' as http;

class CategoryService {
  final logger = Logger();
  static const String baseUrl = 'https://eventify.iaknowhow.es/public/api/';

  Future<List<CategoryModel>> getCategories() async {
    final token = TokenService.getToken();

    final response = await http.get(
      Uri.parse('${baseUrl}categories'),
      headers: {'Accept': 'application', 'Authorization': 'Bearer $token'},
    );

    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      final categories = (jsonResponse['body'] as List)
          .map((category) => CategoryModel.fromJson(category))
          .toList();
      return categories;
    } else {
      throw Exception(
        'Error obteniendo las categorias: ${jsonResponse['message']}',
      );
    }
  }
}
