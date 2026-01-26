import 'package:eventify/config/measures.dart';
import 'package:eventify/config/theme.dart';
import 'package:eventify/providers/event_provider.dart';
import 'package:eventify/views/widgets/base_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizerFormAddEvent extends StatefulWidget {
  const OrganizerFormAddEvent({super.key});

  @override
  State<OrganizerFormAddEvent> createState() => _OrganizerFormAddEventState();
}

class _OrganizerFormAddEventState extends State<OrganizerFormAddEvent> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  int _selectedCategory = 1;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final price = double.tryParse(_priceController.text);
    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Precio inválido')),
      );
      return;
    }

    final eventProvider = context.read<EventProvider>();

    final event = await eventProvider.createOrganizerEvent(
      title: _titleController.text,
      description: _descriptionController.text,
      categoryId: _selectedCategory,
      startTime: _startTimeController.text,
      endTime: _endTimeController.text,
      location: _locationController.text,
      price: price,
      imageUrl: _imageUrlController.text,
    );

    if (!mounted) return;

    if (event != null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Evento creado')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            eventProvider.errorMessage ?? 'Error al crear el evento',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = size.width / 400;

    final isLoading = context.watch<EventProvider>().isCreatingEvent;

    return Scaffold(
      backgroundColor: AppColors.greyBackground,
      body: BasePage(
        topMargin: Measures.marginTop,
        child: Column(
          children: [
            Text(
              'Crear Nuevo Evento',
              style: TextStyle(
                fontSize: 22 * scale,
                fontWeight: FontWeight.w900,
                color: AppColors.darkBlue,
              ),
            ),
            SizedBox(height: 20 * scale),

            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                  children: [
                    _buildTextField(
                      controller: _titleController,
                      label: 'Título',
                    ),
                    _buildTextField(
                      controller: _descriptionController,
                      label: 'Descripción',
                      maxLines: 3,
                    ),

                    SizedBox(height: 12 * scale),
                    Text(
                      'Categoría',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),

                    _buildCategoryRadio('Cultural', 1),
                    _buildCategoryRadio('Music', 2),
                    _buildCategoryRadio('Sport', 3),
                    _buildCategoryRadio('Technology', 4),

                    _buildTextField(
                      controller: _startTimeController,
                      label: 'Fecha inicio (YYYY-MM-DD HH:MM:SS)',
                    ),
                    _buildTextField(
                      controller: _endTimeController,
                      label: 'Fecha fin (YYYY-MM-DD HH:MM:SS)',
                    ),
                    _buildTextField(
                      controller: _locationController,
                      label: 'Ubicación',
                    ),
                    _buildTextField(
                      controller: _priceController,
                      label: 'Precio',
                      keyboardType: TextInputType.number,
                    ),
                    _buildTextField(
                      controller: _imageUrlController,
                      label: 'URL Imagen',
                    ),

                    SizedBox(height: 24 * scale),

                    ElevatedButton(
                      onPressed: isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16 * scale),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Crear Evento'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRadio(String text, int value) {
    return RadioListTile<int>(
      title: Text(text),
      value: value,
      groupValue: _selectedCategory,
      onChanged: (v) => setState(() => _selectedCategory = v!),
      activeColor: AppColors.darkBlue,
    );
  }
}
