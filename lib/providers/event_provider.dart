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

  // States related to events organizer

  List<EventModel> _organizerEvents = [];
  bool _isLoadingOrganizerEvents = false;
  bool _isDeletingEvent = false;
  bool _isCreatingEvent = false;
  bool _isUpdatingEvent = false;

  List<EventModel> get organizerEvents => _organizerEvents;
  bool get isLoadingOrganizerEvents => _isLoadingOrganizerEvents;
  bool get isDeletingEvent => _isDeletingEvent;
  bool get isCreatingEvent => _isCreatingEvent;
  bool get isUpdatingEvent => _isUpdatingEvent;

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

  Future<bool> sendPdfByEmail() async {
    if (_generatedPdf == null) {
      return false;
    }

    await PdfService.sendPdfToEmail(_generatedPdf!);

    return true;
  }

  // ORGANIZER FUNCTIONS

  Future<bool> loadOrganizerEvents() async {
    _isLoadingOrganizerEvents = true;
    notifyListeners();

    try {
      final organizerIdString = await TokenService.getUserId();
      if (organizerIdString == null) {
        throw Exception('Organizador no autenticado');
      }

      final organizerId = int.parse(organizerIdString);

      final allOrganizerEvents = await _eventService.getEventsOrganizer(
        organizerId,
      );

      final now = DateTime.now();
      _organizerEvents = allOrganizerEvents.where((event) {
        final eventDate = DateTime.parse(event.startTime);
        return eventDate.isAfter(now);
      }).toList();

      _organizerEvents.sort((a, b) => a.startTime.compareTo(b.startTime));

      _errorMessage = null;
    } catch (e) {
      _organizerEvents = [];
      _errorMessage = e.toString();
    }
    _isLoadingOrganizerEvents = false;
    notifyListeners();
    return _organizerEvents.isEmpty;
  }

  Future<bool> deleteOrganizerEvent(int eventId) async {
    _isDeletingEvent = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _eventService.deleteEventOrganizer(eventId);
      await loadOrganizerEvents();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isDeletingEvent = false;
      notifyListeners();
    }
  }

  Future<EventModel?> createOrganizerEvent({
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
    _isCreatingEvent = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final organizerIdString = await TokenService.getUserId();
      if (organizerIdString == null) {
        throw Exception('Organizador no autenticado');
      }

      final organizerId = int.parse(organizerIdString);

      final newEvent = await _eventService.createEventOrganizer(
        organizerId: organizerId,
        title: title,
        description: description,
        categoryId: categoryId,
        startTime: startTime,
        endTime: endTime,
        location: location,
        price: price,
        imageUrl: imageUrl,
      );

      await loadOrganizerEvents();
      return newEvent;
    } catch (e) {
      _errorMessage = e.toString();
      return null;
    } finally {
      _isCreatingEvent = false;
      notifyListeners();
    }
  }

  Future<EventModel?> updateOrganizerEvent({
    required int id,
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
    _isUpdatingEvent = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final organizerIdString = await TokenService.getUserId();
      if (organizerIdString == null) {
        throw Exception('Organizador no autenticado');
      }

      final organizerId = int.parse(organizerIdString);

      final updatedEvent = await _eventService.updateEventOrganizer(
        id: id,
        organizerId: organizerId,
        title: title,
        description: description,
        categoryId: categoryId,
        startTime: startTime,
        endTime: endTime,
        location: location,
        latitude: latitude,
        longitude: longitude,
        maxAttendees: maxAttendees,
        price: price,
        imageUrl: imageUrl,
      );

      await loadOrganizerEvents();
      return updatedEvent;
    } catch (e) {
      _errorMessage = e.toString();
      return null;
    } finally {
      _isUpdatingEvent = false;
      notifyListeners();
    }
  }
}
