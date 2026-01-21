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

    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      final events = (jsonResponse['data'] as List)
          .map((event) => EventModel.fromJson(event))
          .toList();
      return events;
    } else {
      throw Exception(
        'Error obteniendo los eventos: ${jsonResponse['message']}',
      );
    }
  }

  Future<List<EventModel>> getEventsByCategory(String categoryFilter) async {
    final token = await TokenService.getToken();

    final response = await http.get(
      Uri.parse('${baseUrl}events'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      final eventsByCategory = (jsonResponse['data'] as List)
          .map((event) => EventModel.fromJson(event))
          .where(
            (event) =>
                event.category.toLowerCase() == categoryFilter.toLowerCase(),
          )
          .toList();
      return eventsByCategory;
    } else {
      throw Exception(
        'Error obteniendo los eventos por categorias: ${jsonResponse['message']}',
      );
    }
  }

  Future<void> registerEvent({
    required int userId,
    required int eventId,
  }) async {
    final token = await TokenService.getToken();
    final response = await http.post(
      Uri.parse('${baseUrl}registerEvent'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {
        'user_id': userId.toString(),
        'event_id': eventId.toString(),
        'registered_at': DateTime.now().toIso8601String(),
      },
    );

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      return;
    } else {
      throw Exception(jsonResponse['message'] ?? 'Error registrando el evento');
    }
  }

  Future<void> unRegisterEvent({
    required int userId,
    required int eventId,
  }) async {
    final token = await TokenService.getToken();
    final response = await http.post(
      Uri.parse('${baseUrl}unregisterEvent'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {'user_id': userId.toString(), 'event_id': eventId.toString()},
    );

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      return;
    } else {
      throw Exception(
        jsonResponse['message'] ?? 'Error desregistrando el evento',
      );
    }
  }

  Future<List<int>> getRegisteredEventIdsByUser(int userId) async {
    final token = await TokenService.getToken();

    final response = await http.post(
      Uri.parse('${baseUrl}eventsByUser'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {'id': userId.toString()},
    );

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      return (jsonResponse['data'] as List)
          .map<int>((event) => int.parse(event['id'].toString()))
          .toList();
    } else {
      throw Exception(
        jsonResponse['message'] ?? 'Error obteniendo eventos del usuario',
      );
    }
  }

  Future<List<EventModel>> getMyEvents(int userId) async {
    final token = await TokenService.getToken();

    final response = await http.post(
      Uri.parse('${baseUrl}eventsByUser'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {'id': userId.toString()},
    );

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      return (jsonResponse['data'] as List)
          .map((event) => EventModel.fromJson(event))
          .toList();
    } else {
      throw Exception(
        jsonResponse['message'] ?? 'Error obteniendo mis eventos',
      );
    }
  }

  Future<List<EventModel>> getEventsOrganizer(int organizerId) async {
    final token = await TokenService.getToken();

    final response = await http.post(
      Uri.parse('${baseUrl}eventsByOrganizer'),
      headers: {'Accept' : 'application/json', 'Authorization' : 'Bearer $token',},
      body: {'id': organizerId.toString()},
    );

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      return (jsonResponse['data'] as List)
          .map((event) => EventModel.fromJson(event))
          .toList();
    } else {
      throw Exception(
        jsonResponse['message'] ?? 'Error obteniendo tus eventos',
      );
    }
  }

  Future<void> deleteEventOrganizer(int eventId) async {
    final token = await TokenService.getToken();

    final response = await http.post(
      Uri.parse('${baseUrl}eventDelete'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {'id': eventId.toString()},
    );

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      return;
    } else {
      throw Exception(jsonResponse['message'] ?? 'Error al eliminar el evento');
    }
  }

  Future<EventModel> createEventOrganizer({
    required int organizerId,
    required String title,
    required String description,
    required int categoryId,
    required String startTime,
    required String endTime,
    required String location,
    required double price,
    required String imageUrl,
  }) async {
    final token = await TokenService.getToken();

    final response = await http.post(
      Uri.parse('${baseUrl}events'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {
        'organizer_id': organizerId.toString(),
        'title': title,
        'description': description,
        'category_id': categoryId.toString(),
        'start_time': startTime,
        'end_time': endTime,
        'location': location,
        'price': price.toString(),
        'image_url': imageUrl,
      },
    );

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      return EventModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception(jsonResponse['message'] ?? 'Error creando el evento');
    }
  }

  Future<EventModel> updateEventOrganizer({
    required int id,
    required int organizerId,
    required String title,
    required String description,
    required int categoryId,
    required String startTime,
    required String endTime,
    required String location,
    required double latitude,
    required double longitude,
    required int maxAttendees,
    required double price,
    required String imageUrl,
  }) async {
    final token = await TokenService.getToken();

    final response = await http.post(
      Uri.parse('${baseUrl}eventUpdate'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {
        'id': id.toString(),
        'organizer_id': organizerId.toString(),
        'title': title,
        'description': description,
        'category_id': categoryId.toString(),
        'start_time': startTime,
        'end_time': endTime,
        'location': location,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'max_attendees': maxAttendees.toString(),
        'price': price.toString(),
        'image_url': imageUrl,
      },
    );

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      return EventModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception(
        jsonResponse['message'] ?? 'Error actualizando el evento',
      );
    }
  }
}
