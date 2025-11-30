import 'package:eventify/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SpeedDialFab extends StatefulWidget {
  final Function(String?) onFilterSelected;

  const SpeedDialFab({super.key, required this.onFilterSelected,});

  @override
  State<SpeedDialFab> createState() => _SpeedDialFabState();
}

class _SpeedDialFabState extends State<SpeedDialFab> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final scale = size.width / 400;

    return SpeedDial(
      icon: Icons.filter_alt_outlined,
      animatedIconTheme: IconThemeData(size: 30 * scale),
      backgroundColor: AppColors.primaryPurple,
      foregroundColor: AppColors.white,
      visible: true,
      curve: Curves.bounceInOut,
      children: [
        SpeedDialChild(
          child: Icon(Icons.music_note, color: AppColors.darkBlue),
          backgroundColor: AppColors.white,
          onTap: () => widget.onFilterSelected('music'),
          shape: CircleBorder()
        ),
        SpeedDialChild(
          child: Icon(Icons.sports_gymnastics_rounded, color: AppColors.darkBlue),
          backgroundColor: AppColors.white,
          onTap: () => widget.onFilterSelected('sport'),
          shape: CircleBorder()
        ),
        SpeedDialChild(
          child: Icon(Icons.cell_tower, color: AppColors.darkBlue),
          backgroundColor: AppColors.white,
          onTap: () => widget.onFilterSelected('technology'),
          shape: CircleBorder()
        ),
      ],
    );
  }
}
