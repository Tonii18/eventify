import 'package:eventify/config/theme.dart';
import 'package:eventify/models/event_model.dart';
import 'package:eventify/views/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  final double width;
  final double height;
  final double scale;
  final VoidCallback onRegister;
  final bool isRegistering;

  const EventCard({
    super.key,
    required this.event,
    required this.width,
    required this.height,
    required this.scale, 
    required this.onRegister, 
    required this.isRegistering,
  });

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
                          text: '\t ${event.startTime.split(' ')[0]}',
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
                          text: '\t ${event.startTime.split(' ')[1]}',
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
                backgroundColor: Color(
                  int.parse(
                    'FF${mapCategoryColor[event.category] ?? '000000'}',
                    radix: 16,
                  ),
                ),
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                textStyle: TextStyle(
                  fontSize: 20 * scale,
                  fontWeight: FontWeight.w900,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.info_sharp)),
                  CustomeElevatedButton(
                    width: width * 0.25,
                    height: height * 0.05,
                    scale: scale,
                    borderRadius: 5,
                    text: isRegistering ? 'Registrandome...' : 'Registrarme',
                    textColor: AppColors.white,
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w900,
                    onPressed: (){
                      print('Has pulsado el boton');
                      isRegistering ? null : onRegister();
                      
                    },
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.cancel)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
