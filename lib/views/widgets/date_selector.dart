import 'package:eventify/config/theme.dart';
import 'package:flutter/material.dart';

class DateSelector extends StatefulWidget {
  final String label;
  final DateTime? selectedDate;
  final VoidCallback onTap;
  final double scale;

  const DateSelector({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onTap,
    required this.scale,
  });

  @override
  State<DateSelector> createState() => _DateSelector();
}

class _DateSelector extends State<DateSelector> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(widget.scale),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyBackground),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(fontSize: 12, color: AppColors.darkBlue),
                ),

                SizedBox(height: 4 * widget.scale),

                Text(
                  () {
                    final date = widget.selectedDate;
                    return date != null
                        ? '${date.day}/${date.month}/${date.year}'
                        : 'Seleccionar fecha';
                  }(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            Icon(Icons.calendar_today, color: AppColors.darkBlue),
          ],
        ),
      ),
    );
  }
}
