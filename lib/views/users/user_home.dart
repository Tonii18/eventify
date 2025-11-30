import 'package:eventify/config/theme.dart';
import 'package:eventify/views/users/user_events.dart';
import 'package:eventify/views/users/user_home_content.dart';
import 'package:eventify/views/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<StatefulWidget> createState() => _UserHome();
}

class _UserHome extends State<UserHome> {
  int selectedIndex = 0;

  final List<Widget> widgetsOptions = [
    UserHomeContent(),
    UserEvents(),
  ];

  void onNavTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBackground,
      body: widgetsOptions[selectedIndex],
      bottomNavigationBar: CustomeBottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onNavTapped,
      ),
    );
  }
}
