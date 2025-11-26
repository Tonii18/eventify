import 'package:eventify/models/event_model.dart';
import 'package:eventify/services/event_service.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  final EventService _eventService = EventService();
  bool _isLoading = false;
  String? _errorMessage;
  List<EventModel> _events = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<EventModel> get events => _events;

  Future<bool> loadEventsAfterDayTimeNow() async {
    _isLoading = true;
    notifyListeners();

    try {
      final List<EventModel> allEvents = await _eventService.getEvents();
      final now = DateTime.now();

      _events = allEvents.where((event) {
        final eventDate = DateTime.parse(event.startTime);
        return eventDate.isAfter(now);
      }).toList();
      _errorMessage = null;
    } catch (e) {
      _events = [];
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();

    return _events.isNotEmpty;
  }
}
