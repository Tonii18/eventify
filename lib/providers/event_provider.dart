import 'package:eventify/models/event_model.dart';
import 'package:eventify/services/event_service.dart';
import 'package:eventify/services/token_service.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  final EventService _eventService = EventService();
  bool _isLoading = false;
  String? _errorMessage;
  List<EventModel> _events = [];
  List<EventModel> _eventsFilter = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<EventModel> get events => _events;
  List<EventModel> get eventsFilter => _eventsFilter;

  bool _isRegistering = false;
  String? _registerError;

  bool get isRegistering => _isRegistering;
  String? get registerError => _registerError;

  // Set with reigstered events IDs

  final Set<int> _registeredEvents = {};

  Set<int> _registeredEventIds = {};
  Set<int> get registeredEventIds => _registeredEventIds;

  Future<bool> loadEventsAfterDayTimeNow() async {
    _isLoading = true;
    notifyListeners();

    try {
      final allEvents = await _eventService.getEvents();

      final userIdString = await TokenService.getUserId();
      if (userIdString == null) {
        throw Exception('Usuario no autenticado');
      }
      final userId = int.parse(userIdString);

      final registeredIds = await _eventService.getRegisteredEventIdsByUser(
        userId,
      );

      _registeredEventIds = registeredIds.toSet();

      final now = DateTime.now();
      _events = allEvents.where((event) {
        final eventDate = DateTime.parse(event.startTime);
        return eventDate.isAfter(now);
      }).toList();

      _events.sort((b, a) => b.startTime.compareTo(a.startTime));
      _errorMessage = null;
    } catch (e) {
      _events = [];
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return _events.isNotEmpty;
  }

  Future<bool> loadEventsAfterDayTimeNowByCategory(categoryFilter) async {
    _isLoading = true;
    notifyListeners();

    try {
      final List<EventModel> allEvents = await _eventService
          .getEventsByCategory(categoryFilter);
      final now = DateTime.now();

      _eventsFilter = allEvents.where((event) {
        final eventDate = DateTime.parse(event.startTime);
        return eventDate.isAfter(now);
      }).toList();
      _eventsFilter.sort((b, a) => b.startTime.compareTo(a.startTime));
      _errorMessage = null;
    } catch (e) {
      _eventsFilter = [];
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();

    return _eventsFilter.isNotEmpty;
  }

  bool isEventRegistered(int eventId) {
    return _registeredEvents.contains(eventId);
  }

  Future<bool> registerUserToEvent(int eventId) async {
    _isRegistering = true;
    notifyListeners();

    try {
      final userIdString = await TokenService.getUserId();
      if (userIdString == null) {
        throw Exception('Usuario no autenticado');
      }
      final userId = int.parse(userIdString);

      await _eventService.registerEvent(userId: userId, eventId: eventId);

      await loadEventsAfterDayTimeNow(); // 🔥 vuelve a cruzar datos
      return true;
    } catch (e) {
      _registerError = e.toString();
      return false;
    } finally {
      _isRegistering = false;
      notifyListeners();
    }
  }
}
