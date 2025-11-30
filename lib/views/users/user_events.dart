import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventify/config/measures.dart';
import 'package:eventify/config/theme.dart';
import 'package:eventify/models/event_model.dart';
import 'package:eventify/providers/event_provider.dart';
import 'package:eventify/views/users/components/speed_dial_fab.dart';
import 'package:eventify/views/widgets/base_page.dart';
import 'package:eventify/views/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserEvents extends StatefulWidget {
  final String? categoryFilter;
  final Function(String?)? onFilterChanged;

  const UserEvents({
    super.key,
    this.categoryFilter,
    this.onFilterChanged,
  });

  @override
  State<StatefulWidget> createState() => _UserEvents();
}

class _UserEvents extends State<UserEvents> {
  late final EventProvider eventProvider;
  String? currentFilter;

  @override
  void initState() {
    super.initState();
    // Creamos el provider UNA SOLA VEZ
    eventProvider = EventProvider();
    _loadEvents();
  }

  void _loadEvents() {
    if (currentFilter != null) {
      eventProvider.loadEventsAfterDayTimeNowByCategory(currentFilter);
    } else {
      eventProvider.loadEventsAfterDayTimeNow();
    }
  }

  void _updateFilter(String? newFilter) {
    setState(() {
      currentFilter = newFilter;
      _loadEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    // DONT DELETE

    final size = MediaQuery.of(context).size;
    final scale = size.width / 400;

    // Provide EventProvider

    return ChangeNotifierProvider<EventProvider>.value(
      value: eventProvider,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.greyBackground,

        body: BasePage(
          topMargin: Measures.marginTop,
          child: Consumer<EventProvider>(
            builder: (context, provider, child) {
              
              if (provider.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (provider.errorMessage != null) {
                return Center(child: Text('Error: ${provider.errorMessage}'));
              }

              List<EventModel> events = currentFilter != null ? provider.eventsFilter : provider.events;

              if (events.isEmpty) {
                return Center(child: Text('No hay eventos disponibles'));
              }

              // Build the carousel

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentFilter != null ? 'Filtrado: $currentFilter' : 'Explorar',
                        style: TextStyle(
                          fontSize: 20 * scale,
                          fontWeight: FontWeight.w900,
                          color: AppColors.darkBlue,
                        ),
                      ),

                      if(currentFilter != null)
                        IconButton(
                          onPressed: () => _updateFilter(null),
                          icon: Icon(Icons.filter_alt_off),
                          color: AppColors.darkBlue,
                          iconSize: scale * 40,
                        ),
                    ],
                  ),

                  SizedBox(height: 20 * scale),

                  CarouselSlider.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index, realIndex) {
                      final ev = events[index];
                      return EventCard(
                        event: ev,
                        width: size.width,
                        height: size.height,
                        scale: scale,
                      );
                    },
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.55,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.7,
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        floatingActionButton: SpeedDialFab(
          onFilterSelected: _updateFilter,
        ),
      ),
    );
  }
}
