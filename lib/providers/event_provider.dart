import 'dart:io';

import 'package:eventify/models/event_model.dart';
import 'package:eventify/services/event_service.dart';
import 'package:eventify/services/pdf_service.dart';
import 'package:eventify/services/token_service.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  // States

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

  List<EventModel> _myEvents = [];
  List<EventModel> get myEvents => _myEvents;

  final Set<int> _registeredEvents = {};

  Set<int> _registeredEventIds = {};
  Set<int> get registeredEventIds => _registeredEventIds;

  // States related to PDF generation

  File? _generatedPdf;
  bool _isGeneratingPdf = false;

  File? get generatedPdf => _generatedPdf;
  bool get isGeneratingPdf => _isGeneratingPdf;
  bool get canSendPdf => _generatedPdf != null;

  // Functions

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

      await loadEventsAfterDayTimeNow();
      return true;
    } catch (e) {
      _registerError = e.toString();
      return false;
    } finally {
      _isRegistering = false;
      notifyListeners();
    }
  }

  Future<bool> unRegisterUserToEvent(int eventId) async {
    _isRegistering = true;
    notifyListeners();

    try {
      final userIdString = await TokenService.getUserId();
      if (userIdString == null) {
        throw Exception('Usuario no autenticado');
      }
      final userId = int.parse(userIdString);

      await _eventService.unRegisterEvent(userId: userId, eventId: eventId);

      await loadEventsAfterDayTimeNow();
      return true;
    } catch (e) {
      _registerError = e.toString();
      return false;
    } finally {
      _isRegistering = false;
      notifyListeners();
    }
  }

  Future<bool> loadMyEvents() async {
    _isLoading = true;
    notifyListeners();

    try {
      final userIdString = await TokenService.getUserId();
      if (userIdString == null) {
        throw Exception('Usuario no autenticado');
      }

      final userId = int.parse(userIdString);

      final allEvents = await _eventService.getEvents();

      final registeredIds = await _eventService.getRegisteredEventIdsByUser(
        userId,
      );

      _registeredEventIds = registeredIds.toSet();

      _myEvents = allEvents
          .where((event) => _registeredEventIds.contains(event.id))
          .toList();

      _myEvents.sort((b, a) => b.startTime.compareTo(a.startTime));
      _errorMessage = null;
    } catch (e) {
      _myEvents = [];
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return _myEvents.isNotEmpty;
  }

  List<EventModel> filterEventsForReport({
    required DateTime startDate,
    required DateTime endDate,
    required Map<String, bool> eventTypes,
  }) {
    return _myEvents.where((event) {
      final eventDate = DateTime.parse(event.startTime);

      final inDateRange =
          eventDate.isAfter(startDate) && eventDate.isBefore(endDate);

      final categoryAllowed = eventTypes[event.category.toLowerCase()] == true;

      return inDateRange && categoryAllowed;
    }).toList();
  }

  Future<bool> generatePdfReport({
    required DateTime startDate,
    required DateTime endDate,
    required Map<String, bool> eventTypes,
  }) async {
    _isGeneratingPdf = true;
    notifyListeners();

    try {
      if (_myEvents.isEmpty) {
        await loadMyEvents();
      }

      final filteredEvents = filterEventsForReport(
        startDate: startDate,
        endDate: endDate,
        eventTypes: eventTypes,
      );

      if (filteredEvents.isEmpty) {
        return false;
      }

      _generatedPdf = await PdfService.generateEventsPdf(filteredEvents);
      return true;
    } finally {
      _isGeneratingPdf = false;
      notifyListeners();
    }
  }
}
