import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventify/config/measures.dart';
import 'package:eventify/config/theme.dart';
import 'package:eventify/providers/event_provider.dart';
import 'package:eventify/views/widgets/base_page.dart';
import 'package:eventify/views/widgets/organizer_event_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizerHomeContent extends StatefulWidget {
  const OrganizerHomeContent({super.key});

  @override
  State<OrganizerHomeContent> createState() => _OrganizerHomeContentState();
}

class _OrganizerHomeContentState extends State<OrganizerHomeContent> {
  late final EventProvider eventProvider;

  @override
  void initState() {
    super.initState();
    eventProvider = EventProvider();
    eventProvider.loadOrganizerEvents();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = size.width / 400;

    return ChangeNotifierProvider<EventProvider>.value(
      value: eventProvider,
      child: Scaffold(
        backgroundColor: AppColors.greyBackground,
        body: BasePage(
          topMargin: Measures.marginTop,
          child: Consumer<EventProvider>(
            builder: (context, provider, child) {
              if (provider.isLoadingOrganizerEvents) {
                return const Center(child: CircularProgressIndicator());
              }

              if (provider.errorMessage != null) {
                return Center(child: Text('Error: ${provider.errorMessage}'));
              }

              final events = provider.organizerEvents;

              return Column(
                children: [
                  Text(
                    'Mis eventos',
                    style: TextStyle(
                      fontSize: 22 * scale,
                      fontWeight: FontWeight.w900,
                      color: AppColors.darkBlue,
                    ),
                  ),

                  SizedBox(height: 20 * scale),

                  Expanded(
                    child: events.isEmpty
                        ? const Center(
                            child: Text('No has creado ningun Evento'),
                          )
                        : CarouselSlider.builder(
                            itemCount: events.length,
                            itemBuilder: (context, index, realIndex) {
                              final ev = events[index];
                              return OrganizerEventCard(
                                event: ev,
                                width: size.width,
                                height: size.height,
                                scale: scale,
                              );
                            },
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.75,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              viewportFraction: 0.7,
                            ),
                          ),
                  ),

                  SizedBox(height: 20 * scale),

                  FilledButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    label: Text("Añadir nuevo evento"),
                    iconAlignment: IconAlignment.start,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
