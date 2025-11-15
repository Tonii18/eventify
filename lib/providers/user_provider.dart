import 'package:eventify/models/user_model.dart';
import 'package:eventify/services/user_service.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  bool _isLoading = false;
  String? _errorMessage;
  List<UserModel> _users = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<UserModel> get users => _users;

  // Admin Provider
  
  Future<bool> loadUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _userService.getUsers();
      _errorMessage = null;
    } catch (e) {
      _users = [];
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();

    return _users.isNotEmpty;
  }

  Future<bool> activateUser(int id) async {
    _isLoading = true;
    notifyListeners();

    bool result;
    try {
      result = await _userService.activateUser(id);
      if (!result) {
        _errorMessage = 'No se puede activar el usuario';
      } else {
        _errorMessage = null;
        final index = _users.indexWhere((u) => u.id == id);
        if (index != -1) {
          _users[index].actived = 1;
        }
      }
    } catch (e) {
      _errorMessage = 'Error al activar el usuario: $e';
      result = false;
    }

    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<bool> deactivateUser(int id) async {
    _isLoading = true;
    notifyListeners();

    bool result;
    try {
      result = await _userService.deactivateUser(id);
      if (!result) {
        _errorMessage = 'No se puede desactivar el usuario';
      } else {
        _errorMessage = null;
        final index = _users.indexWhere((u) => u.id == id);
        if (index != -1) {
          _users[index].actived = 0;
        }
      }
    } catch (e) {
      _errorMessage = 'Error al desactivar el usuario: $e';
      result = false;
    }

    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<bool> deleteUser(int id) async {
    _isLoading = true;
    notifyListeners();

    bool result;
    try {
      result = await _userService.deleteUser(id);
      if (!result) {
        _errorMessage = 'No se puede eliminar el usuario';
      } else {
        _errorMessage = null;
        final index = _users.indexWhere((u) => u.id == id);
        if (index != -1) {
          _users[index].deleted = 1;
        }
      }
    } catch (e) {
      _errorMessage = 'Error al eliminar el usuario: $e';
      result = false;
    }

    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<bool> updateUser(int id, String newName) async {
    _isLoading = true;
    notifyListeners();

    bool result;
    try {
      result = await _userService.updateUser(id, newName);
      if (!result) {
        _errorMessage = 'No se puede editar el usuario';
      } else {
        _errorMessage = null;
        final index = _users.indexWhere((u) => u.id == id);
        if (index != -1) {
          _users[index].name = newName;
        }
      }
    } catch (e) {
      _errorMessage = 'Error al editar el usuario: $e';
      result = false;
    }

    _isLoading = false;
    notifyListeners();
    return result;
  }

  // TODO : User Provider

  // TODO : Organizer Provider
}
