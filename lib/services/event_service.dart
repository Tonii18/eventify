import 'dart:convert';

import 'package:eventify/models/event_model.dart';
import 'package:eventify/services/token_service.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class EventService {
  final logger = Logger();
  static const String baseUrl = 'https://eventify.iaknowhow.es/public/api/';

  Future<List<EventModel>> getEvents() async {
    final token = await TokenService.getToken();

    final response = await http.get(
      Uri.parse('${baseUrl}events'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    final jsonResponse =  jsonDecode(response.body);
    if(response.statusCode == 200 && jsonResponse['success'] == true){
      final events = (jsonResponse['data'] as List)
        .map((event) => EventModel.fromJson(event))
        .toList();
      return events;
    }else{
      throw Exception('Error obteniendo los eventos: ${jsonResponse['message']}');
    }
  }
}
