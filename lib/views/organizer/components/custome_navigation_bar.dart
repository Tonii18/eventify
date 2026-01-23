import 'package:eventify/config/theme.dart';
import 'package:flutter/material.dart';

class CustomeNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomeNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = size.width / 400;

    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Mis eventos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add), 
          label: 'Añadir Evento'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart),
          label: 'Estadísticas',
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
