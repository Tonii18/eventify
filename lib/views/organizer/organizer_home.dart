import 'package:eventify/config/theme.dart';
import 'package:eventify/views/organizer/components/custome_navigation_bar.dart';
import 'package:eventify/views/organizer/organizer_form_add_event.dart';
import 'package:eventify/views/organizer/organizer_home_content.dart';
import 'package:eventify/views/organizer/organizer_stats.dart';
import 'package:flutter/material.dart';

class OrganizerHome extends StatefulWidget {
  const OrganizerHome({super.key});

  @override
  State<OrganizerHome> createState() => _OrganizerHomeState();
}

class _OrganizerHomeState extends State<OrganizerHome> {
  int selectedIndex = 0;

  final List<Widget> widgetsOptions = [
    OrganizerHomeContent(),
    OrganizerFormAddEvent(),
    OrganizerStats(),
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
      bottomNavigationBar: CustomeNavigationBar(
        currentIndex: selectedIndex,
        onTap: onNavTapped,
      ),
    );
  }
}
