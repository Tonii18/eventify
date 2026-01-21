import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventify/config/measures.dart';
import 'package:eventify/config/theme.dart';
import 'package:eventify/providers/event_provider.dart';
import 'package:eventify/views/users/components/home_header.dart';
import 'package:eventify/views/widgets/base_page.dart';
import 'package:eventify/views/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserHomeContent extends StatefulWidget {
  const UserHomeContent({super.key});

  @override
  State<UserHomeContent> createState() => _UserHomeContentState();
}

class _UserHomeContentState extends State<UserHomeContent> {
  late final EventProvider eventProvider;

  @override
  void initState() {
    super.initState();
    eventProvider = EventProvider();
    eventProvider.loadMyEvents();
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
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (provider.errorMessage != null) {
                return Center(child: Text('Error: ${provider.errorMessage}'));
              }

              final events = provider.myEvents;

              if (events.isEmpty) {
                return const Center(
                  child: Text('No estás registrado en ningún evento'),
                );
              }

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

                  CarouselSlider.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index, realIndex) {
                      final ev = events[index];

                      return EventCard(
                        event: ev,
                        width: size.width,
                        height: size.height,
                        scale: scale,
                        isRegistering: false,
                        isRegistered: true,
                        onRegister: () {},
                        onUnRegister: () {},
                      );
                    },
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.75,
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
      ),
    );
  }
}
