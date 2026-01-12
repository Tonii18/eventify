import 'package:eventify/config/theme.dart';
import 'package:flutter/material.dart';

class CustomeBottomNavigationBar extends StatelessWidget {

  final int currentIndex;
  final Function(int) onTap;

  const CustomeBottomNavigationBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final scale = size.width / 400;

    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Mis eventos'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          label: 'Eventos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_chart_rounded),
          label: 'Informes',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
      iconSize: 40 * scale,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primaryPurple,
      unselectedItemColor: AppColors.lightGrey,
    );
  }
}