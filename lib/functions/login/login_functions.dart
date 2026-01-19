import 'package:eventify/providers/auth_provider.dart';
import 'package:eventify/views/admin/admin_dashboard.dart';
import 'package:eventify/views/organizer/organizer_home.dart';
import 'package:eventify/views/users/user_home.dart';
import 'package:eventify/views/users/user_home_content.dart';
import 'package:flutter/material.dart';

class LoginFunctions {
  AuthProvider authProvider = AuthProvider();

  Future<void> loginUser(String email, String password, context) async {
    if (await authProvider.login(email, password)) {
      if (authProvider.user?.role == 'a') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminMenu()),
        );
      }

      if (authProvider.user?.role == 'u') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserHome()),
        );
      }

      if (authProvider.user?.role == 'o'){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrganizerHome()),
        );
      }
    }
  }
}
