import 'package:eventify/models/user_model.dart';
import 'package:eventify/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;
  UserModel? _user;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserModel? get user => _user;

  // TODO: Login Provider
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final user = await _authService.loginUser(email, password);

    if (user != null) {
      _user = user;
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = 'Login Failed';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // TODO : Register Provider
  Future<bool> register(String name, String email, String password, String role) async {
    _isLoading = true;
    notifyListeners();

    final userModel = UserModel(
      name: name,
      email: email,
      password: password,
      role: role,
    );

    final user = await _authService.registerUser(userModel);

    if (user != null) {
      _user = user;
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = 'Login Failed';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
