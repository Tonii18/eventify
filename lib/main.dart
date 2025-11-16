import 'package:eventify/providers/auth_provider.dart';
import 'package:eventify/views/admin/admin_menu.dart';
import 'package:eventify/views/login/login_page.dart';
import 'package:flutter/material.dart';

// This is the entry point of the application

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final auth = AuthProvider();
  final logged = await auth.loadUserFromStorage();

  runApp(MyApp(logged: logged, auth: auth));
}

// Main Widget

class MyApp extends StatelessWidget {
  final bool logged;
  final AuthProvider auth;
  const MyApp({super.key, required this.logged, required this.auth});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eventify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      home: logged ? _redirectUser(auth) : const LoginPage(),
    );
  }

  Widget _redirectUser(AuthProvider auth) {
    if (auth.user?.role == 'a') {
      return AdminMenu();
    } else if (auth.user?.role == 'u') {
      //return UserMenu();
    } else if (auth.user?.role == 'o') {
      //return OrganizerMenu();
    }

    return const LoginPage();
  }
}
