// ignore_for_file: use_build_context_synchronously

import 'package:eventify/config/theme.dart';
import 'package:eventify/models/event_model.dart';
import 'package:eventify/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventEditPage extends StatefulWidget {
  final EventModel event;

  const EventEditPage({super.key, required this.event});

  @override
  State<EventEditPage> createState() => _EventEditPageState();
}

class _EventEditPageState extends State<EventEditPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late TextEditingController _locationController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;
  late TextEditingController _maxAttendeesController;
  late TextEditingController _priceController;
  late TextEditingController _imageUrlController;

  int _selectedCategoryId = 1;

  final Map<int, String> _categories = {
    1: 'Music',
    2: 'Sport',
    3: 'Technology',
    4: 'Cultural',
  };

  late Map<String, int> _categoryNameToId;

  @override
  void initState() {
    super.initState();

    _categoryNameToId = {for (var e in _categories.entries) e.value: e.key};

    _titleController = TextEditingController(text: widget.event.title);
    _descriptionController = TextEditingController(
      text: widget.event.description,
    );
    _startTimeController = TextEditingController(text: widget.event.startTime);
    _endTimeController = TextEditingController(
      text: widget.event.endTime ?? '',
    );
    _locationController = TextEditingController(
      text: widget.event.location ?? '',
    );
    _latitudeController = TextEditingController(
      text: widget.event.latitude?.toString() ?? '',
    );
    _longitudeController = TextEditingController(
      text: widget.event.longitude?.toString() ?? '',
    );
    _maxAttendeesController = TextEditingController(
      text: widget.event.maxAttendees?.toString() ?? '',
    );
    _priceController = TextEditingController(
      text: widget.event.price?.toString() ?? '',
    );
    _imageUrlController = TextEditingController(text: widget.event.imageUrl);

    _selectedCategoryId = _categoryNameToId[widget.event.category] ?? 1;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _locationController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _maxAttendeesController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveEvent() async {
    final provider = context.read<EventProvider>();

    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Título y descripción son obligatorios')),
      );
      return;
    }

    final latitude = double.tryParse(_latitudeController.text) ?? 0;
    final longitude = double.tryParse(_longitudeController.text) ?? 0;
    final maxAttendees = int.tryParse(_maxAttendeesController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0;

    try {
      await provider.updateOrganizerEvent(
        id: widget.event.id!,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        categoryId: _selectedCategoryId,
        startTime: _startTimeController.text.trim(),
        endTime: _endTimeController.text.trim(),
        location: _locationController.text.trim(),
        latitude: latitude,
        longitude: longitude,
        maxAttendees: maxAttendees,
        price: price,
        imageUrl: _imageUrlController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Evento actualizado con éxito')),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventProvider>(
      create: (_) => EventProvider(),
      child: Consumer<EventProvider>(
        builder: (context, provider, _) {
          final isLoading = provider.isUpdatingEvent;

          return Scaffold(
            appBar: AppBar(title: const Text('Editar Evento')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildTextField('Título', _titleController),
                  _buildTextField('Descripción', _descriptionController),
                  DropdownButtonFormField<int>(
                    value: _selectedCategoryId,
                    decoration: const InputDecoration(
                      labelText: 'Categoría',
                      border: OutlineInputBorder(),
                    ),
                    items: _categories.entries
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.key,
                            child: Text(e.value),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null)
                        setState(() => _selectedCategoryId = value);
                    },
                  ),
                  _buildTextField('Inicio', _startTimeController),
                  _buildTextField('Fin', _endTimeController),
                  _buildTextField('Ubicación', _locationController),
                  _buildTextField(
                    'Latitud',
                    _latitudeController,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextField(
                    'Longitud',
                    _longitudeController,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextField(
                    'Máx asistentes',
                    _maxAttendeesController,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextField(
                    'Precio',
                    _priceController,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextField('URL Imagen', _imageUrlController),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: isLoading ? null : _saveEvent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Guardar cambios',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
