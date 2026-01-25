import 'package:eventify/models/event_model.dart';
import 'package:eventify/providers/event_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizerStats extends StatefulWidget {
  const OrganizerStats({super.key});

  @override
  State<OrganizerStats> createState() => _OrganizerStatsState();
}

class _OrganizerStatsState extends State<OrganizerStats> {
  late final EventProvider eventProvider;
  final List<String> categories = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    eventProvider = EventProvider();
    eventProvider.loadOrganizerEvents().then((_) {
      final cats = eventProvider.organizerEvents
          .map((e) => e.category)
          .toSet()
          .toList();

      if (!mounted) return;

      setState(() {
        categories
          ..clear()
          ..addAll(cats);
        if (categories.isNotEmpty) {
          selectedCategory = categories.first;
        }
      });
    });
  }

  List<DateTime> _getLast4Months() {
    final now = DateTime.now();
    return List.generate(4, (i) {
      return DateTime(now.year, now.month - (3 - i), 1);
    });
  }

  List<int> _getEventsPerMonth(String category, List<EventModel> events) {
    final months = _getLast4Months();
    return months.map((month) {
      return events.where((e) {
        final d = DateTime.parse(e.startTime);
        return e.category == category &&
            d.year == month.year &&
            d.month == month.month;
      }).length;
    }).toList();
  }

  Widget _buildChart(List<EventModel> events) {
    if (selectedCategory == null) return const SizedBox();
    final values = _getEventsPerMonth(selectedCategory!, events);
    final maxY = values.reduce((a, b) => a > b ? a : b).toDouble() + 1;

    return BarChart(
      BarChartData(
        minY: 0,
        maxY: maxY,
        barGroups: List.generate(4, (i) {
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: values[i].toDouble(),
                width: 18,
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          );
        }),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final m = _getLast4Months()[value.toInt()];
                return Text('${m.month}/${m.year}');
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventProvider>.value(
      value: eventProvider,
      child: Consumer<EventProvider>(
        builder: (context, provider, _) {
          if (provider.isLoadingOrganizerEvents) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.organizerEvents.isEmpty) {
            return const Center(child: Text('No hay eventos'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Estadísticas por categoría',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                DropdownButton<String>(
                  value: selectedCategory,
                  items: categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) {
                    setState(() => selectedCategory = v);
                  },
                ),

                const SizedBox(height: 24),
                Expanded(child: _buildChart(provider.organizerEvents)),
              ],
            ),
          );
        },
      ),
    );
  }
}
