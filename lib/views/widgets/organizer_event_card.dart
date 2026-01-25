// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventify/config/theme.dart';
import 'package:eventify/models/event_model.dart';
import 'package:eventify/providers/event_provider.dart';
import 'package:eventify/views/organizer/event_edit_page.dart';
import 'package:eventify/views/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizerEventCard extends StatelessWidget {
  final EventModel event;
  final double width;
  final double height;
  final double scale;

  const OrganizerEventCard({
    super.key,
    required this.event,
    required this.width,
    required this.height,
    required this.scale,
  });

  String _getDate(String dateTime) {
    try {
      final dt = DateTime.parse(dateTime);
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (e) {
      return dateTime.split(' ').first;
    }
  }

  String _getTime(String dateTime) {
    try {
      final dt = DateTime.parse(dateTime);
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      final parts = dateTime.split(' ');
      return parts.length > 1 ? parts[1] : 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> mapCategoryColor = {
      'Music': 'FFD700',
      'Sport': 'FF4500',
      'Technology': '4CAF50',
      'Cultural': '3F81EA',
    };

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: width * 0.6,
            height: height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(
                  width: 3,
                  color: Color(
                    int.parse(
                      'FF${mapCategoryColor[event.category] ?? '000000'}',
                      radix: 16,
                    ),
                  ),
                ),
              ),
            ),

            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: scale * 30),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: event.imageUrl,
                    width: width * 0.5,
                    height: height * 0.3,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),

                  SizedBox(height: 10 * scale),

                  Text(
                    event.title,
                    style: TextStyle(
                      fontSize: 15 * scale,
                      fontWeight: FontWeight.w900,
                      color: AppColors.darkBlue,
                    ),
                  ),

                  SizedBox(height: 20 * scale),

                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.calendar_month, size: 15 * scale),
                        ),
                        TextSpan(
                          text: '\t ${_getDate(event.startTime)}',
                          style: TextStyle(
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.w100,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10 * scale),

                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.access_time, size: 14 * scale),
                        ),
                        TextSpan(
                          text: '\t ${_getTime(event.startTime)}',
                          style: TextStyle(
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.w100,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 10 * scale),

          SizedBox(
            width: width * 0.6,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: AppColors.darkBlue,
                foregroundColor: AppColors.white,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: TextStyle(
                  fontSize: 20 * scale,
                  fontWeight: FontWeight.w900,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomeElevatedButton(
                    width: width * 0.25,
                    height: height * 0.05,
                    scale: scale,
                    borderRadius: 5,
                    text: "Editar",
                    textColor: AppColors.greyBackground,
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w900,
                    onPressed: () async {
                      final updated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                            create: (_) => EventProvider(),
                            child: EventEditPage(event: event),
                          ),
                        ),
                      );

                      if (updated == true) {
                        // recargar lista de eventos
                        final provider = context.read<EventProvider>();
                        provider.loadOrganizerEvents();
                      }
                    },
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
