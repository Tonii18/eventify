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
      _events = await _eventService.getEvents();
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
