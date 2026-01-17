import 'package:eventify/config/measures.dart';
import 'package:eventify/config/theme.dart';
import 'package:eventify/providers/event_provider.dart';
import 'package:eventify/views/widgets/base_page.dart';
import 'package:eventify/views/widgets/date_selector.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:provider/provider.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformation();
}

class _UserInformation extends State<UserInformation> {
  DateTime? _startDate;
  DateTime? _endDate;

  final Map<String, bool> _eventTypes = {
    'cultural': false,
    'music': false,
    'sport': false,
    'technology': false,
  };

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.darkBlue),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = size.width / 400;

    return ChangeNotifierProvider<EventProvider>(
      create: (_) => EventProvider(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.greyBackground,
            body: BasePage(
              topMargin: Measures.marginTop,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Configuracion del Informe',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22 * scale,
                        fontWeight: FontWeight.w900,
                        color: AppColors.darkBlue,
                      ),
                    ),

                    SizedBox(height: 20 * scale),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: DateSelector(
                        label: 'Fecha de inicio',
                        selectedDate: _startDate,
                        onTap: () => _selectDate(context, true),
                        scale: scale,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: DateSelector(
                        label: 'Fecha final',
                        selectedDate: _endDate,
                        onTap: () => _selectDate(context, false),
                        scale: scale,
                      ),
                    ),

                    SizedBox(height: 20 * scale),

                    Text(
                      'Tipos de eventos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20 * scale,
                        fontWeight: FontWeight.w900,
                        color: AppColors.darkBlue,
                      ),
                    ),

                    SizedBox(height: 20 * scale),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Card(
                        elevation: 2 * scale,
                        child: Padding(
                          padding: EdgeInsets.all(scale),
                          child: Column(
                            children: _eventTypes.keys.map((type) {
                              return CheckboxListTile(
                                title: Text(
                                  type.toUpperCase(),
                                  style: TextStyle(fontSize: 16),
                                ),
                                value: _eventTypes[type],
                                activeColor: AppColors.darkBlue,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _eventTypes[type] = value ?? false;
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20 * scale),

                    Column(
                      children: [
                        SizedBox(
                          width: 375 * scale,
                          height: 50 * scale,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final provider = context.read<EventProvider>();

                              final success = await provider.generatePdfReport(
                                startDate: _startDate!,
                                endDate: _endDate!,
                                eventTypes: _eventTypes,
                              );

                              if (!context.mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    success
                                        ? 'PDF generado correctamente'
                                        : 'No hay eventos que cumplan los criterios',
                                  ),
                                ),
                              );

                              final file = provider.generatedPdf;

                              if (file != null) {
                                await OpenFilex.open(file.path);
                              }
                            },
                            icon: Icon(Icons.picture_as_pdf),
                            label: Text(
                              'Descargar PDF',
                              style: TextStyle(fontSize: 14),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryPurple,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 12 * scale),

                        SizedBox(
                          width: 375 * scale,
                          height: 50 * scale,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.email),
                            label: Text(
                              'Enviar PDF por email',
                              style: TextStyle(fontSize: 14),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.darkBlue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
