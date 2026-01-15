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
  final VoidCallback onUnRegister;
  final bool isRegistering;
  final bool isRegistered;

  const EventCard({
    super.key,
    required this.event,
    required this.width,
    required this.height,
    required this.scale,
    required this.onRegister,
    required this.onUnRegister,
    required this.isRegistering,
    required this.isRegistered,
  });

  void _dialogInfoEvent(
    BuildContext context,
    EventModel event,
    Map<String, String> mapCategoryColor,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      isScrollControlled: true, // Permite controlar mejor el tamaño
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          height:
              MediaQuery.of(context).size.height * 0.7, // 70% de la pantalla
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barra superior para cerrar
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Imagen del evento
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: event.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),

              SizedBox(height: 20),

              // Título del evento
              Text(
                event.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue,
                ),
              ),

              SizedBox(height: 10),

              // Categoría con color
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(
                    int.parse(
                      'FF${mapCategoryColor[event.category] ?? '000000'}',
                      radix: 16,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  event.category,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Fecha
              Row(
                children: [
                  Icon(Icons.calendar_month, color: AppColors.darkBlue),
                  SizedBox(width: 10),
                  Text(
                    'Fecha: ${event.startTime.split(' ')[0]}',
                    style: TextStyle(fontSize: 16, color: AppColors.darkBlue),
                  ),
                ],
              ),

              SizedBox(height: 15),

              // Hora
              Row(
                children: [
                  Icon(Icons.access_time, color: AppColors.darkBlue),
                  SizedBox(width: 10),
                  Text(
                    'Hora: ${event.startTime.split(' ')[1]}',
                    style: TextStyle(fontSize: 16, color: AppColors.darkBlue),
                  ),
                ],
              ),

              SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> mapCategoryColor = {
      'Music': 'FFD700',
      'Sport': 'FF4500',
      'Technology': '4CAF50',
      'Cultural': '3F81EA',
    };

    final Color registerBackgroundColor = isRegistered
        ? const Color.fromARGB(255, 212, 212, 212)
        : Color(
            int.parse(
              'FF${mapCategoryColor[event.category] ?? '000000'}',
              radix: 16,
            ),
          );

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
              onPressed: null,
              style: TextButton.styleFrom(
                backgroundColor: registerBackgroundColor,
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
                  IconButton(
                    onPressed: () =>
                        _dialogInfoEvent(context, event, mapCategoryColor),
                    icon: Icon(Icons.info_sharp),
                  ),
                  CustomeElevatedButton(
                    width: width * 0.25,
                    height: height * 0.05,
                    scale: scale,
                    borderRadius: 5,
                    text: isRegistering
                        ? (isRegistered ? 'Desregistrando...' : 'Registrando...')
                        : (isRegistered ? 'Registrado' : 'Registrarme'),
                    textColor: AppColors.white,
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w900,
                    onPressed: (isRegistering || isRegistered) ? null : onRegister,
                  ),
                  IconButton(
                    onPressed: (isRegistered && !isRegistering) ? onUnRegister : null,
                    icon: Icon(Icons.cancel),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
