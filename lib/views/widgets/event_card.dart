import 'package:eventify/models/event_model.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  final double width;
  final double height;
  final double scale;

  const EventCard({
    super.key,
    required this.event,
    required this.width,
    required this.height,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, String> mapCategoryColor = {
      'Music': 'FFD700',
      'Sport': 'FF4500',
      'Technology': '4CAF50',
      'Cultural': '3F81EA',
    };

    final dateAll = event.startTime;
    final splitter = dateAll.split(' ');
    final day = splitter[0];
    final hour = splitter[1];

    return Container(
      width: width * 0.6,
      height: height * 0.8,

      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(
              int.parse("FF${mapCategoryColor[event.category]}", radix: 16),
            )
          )
        )
      ),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: scale * 30),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Image.network(
              '$event.imageUrl',
              width: width * 0.5,
              height: height * 0.4,
            ),

            Text(
              '$event.title',
              style: TextStyle(
                fontSize: 10 * scale,
                fontWeight: FontWeight.w900,
              ),
            ),

            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.calendar_month, size: 14 * scale),
                  ),
                  TextSpan(
                    text: day,
                  ),
                ],
              ),
            ),

            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.access_time, size: 14 * scale),
                  ),
                  TextSpan(
                    text: hour,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
