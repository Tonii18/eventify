import 'package:eventify/config/measures.dart';
import 'package:eventify/config/theme.dart';
import 'package:eventify/providers/event_provider.dart';
import 'package:eventify/services/token_service.dart';
import 'package:eventify/views/widgets/base_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizerFormAddEvent extends StatefulWidget {
  const OrganizerFormAddEvent({super.key});

  @override
  State<OrganizerFormAddEvent> createState() => _OrganizerFormAddEventState();
}

class _OrganizerFormAddEventState extends State<OrganizerFormAddEvent> {
  late final EventProvider eventProvider;
  final _formKey = GlobalKey<FormState>();
  
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  
  int _selectedCategory = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    eventProvider = EventProvider();
  }

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

    setState(() => _isLoading = true);

    try {
      final userIdString = await TokenService.getUserId();
      
      if (userIdString == null) {
        throw Exception('No hay usuario logueado');
      }
      
      final organizerId = int.parse(userIdString);
      
      await eventProvider.createOrganizerEvent(
        organizerId: organizerId,
        title: _titleController.text,
        description: _descriptionController.text,
        categoryId: _selectedCategory,
        startTime: _startTimeController.text,
        endTime: _endTimeController.text,
        location: _locationController.text,
        price: double.parse(_priceController.text),
        imageUrl: _imageUrlController.text,
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Evento creado')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Título',
                          labelStyle: TextStyle(color: AppColors.darkBlue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.darkBlue, width: 2),
                          ),
                        ),
                        validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
                      ),
                      SizedBox(height: 16 * scale),
                      
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Descripción',
                          labelStyle: TextStyle(color: AppColors.darkBlue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.darkBlue, width: 2),
                          ),
                        ),
                        maxLines: 3,
                        validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
                      ),
                      SizedBox(height: 16 * scale),
                      
                      Text(
                        'Categoría:',
                        style: TextStyle(
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      RadioListTile(
                        title: const Text('Cultural'),
                        value: 1,
                        groupValue: _selectedCategory,
                        activeColor: AppColors.darkBlue,
                        onChanged: (v) => setState(() => _selectedCategory = v!),
                      ),
                      RadioListTile(
                        title: const Text('Music'),
                        value: 2,
                        groupValue: _selectedCategory,
                        activeColor: AppColors.darkBlue,
                        onChanged: (v) => setState(() => _selectedCategory = v!),
                      ),
                      RadioListTile(
                        title: const Text('Sport'),
                        value: 3,
                        groupValue: _selectedCategory,
                        activeColor: AppColors.darkBlue,
                        onChanged: (v) => setState(() => _selectedCategory = v!),
                      ),
                      RadioListTile(
                        title: const Text('Technology'),
                        value: 4,
                        groupValue: _selectedCategory,
                        activeColor: AppColors.darkBlue,
                        onChanged: (v) => setState(() => _selectedCategory = v!),
                      ),
                      SizedBox(height: 16 * scale),
                      
                      TextFormField(
                        controller: _startTimeController,
                        decoration: InputDecoration(
                          labelText: 'Fecha inicio (YYYY-MM-DD HH:MM:SS)',
                          labelStyle: TextStyle(color: AppColors.darkBlue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.darkBlue, width: 2),
                          ),
                        ),
                        validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
                      ),
                      SizedBox(height: 16 * scale),
                      
                      TextFormField(
                        controller: _endTimeController,
                        decoration: InputDecoration(
                          labelText: 'Fecha fin (YYYY-MM-DD HH:MM:SS)',
                          labelStyle: TextStyle(color: AppColors.darkBlue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.darkBlue, width: 2),
                          ),
                        ),
                        validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
                      ),
                      SizedBox(height: 16 * scale),
                      
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          labelText: 'Ubicación',
                          labelStyle: TextStyle(color: AppColors.darkBlue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.darkBlue, width: 2),
                          ),
                        ),
                        validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
                      ),
                      SizedBox(height: 16 * scale),
                      
                      TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'Precio',
                          labelStyle: TextStyle(color: AppColors.darkBlue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.darkBlue, width: 2),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
                      ),
                      SizedBox(height: 16 * scale),
                      
                      TextFormField(
                        controller: _imageUrlController,
                        decoration: InputDecoration(
                          labelText: 'URL Imagen',
                          labelStyle: TextStyle(color: AppColors.darkBlue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.darkBlue, width: 2),
                          ),
                        ),
                        validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
                      ),
                      SizedBox(height: 24 * scale),
                      
                      ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkBlue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16 * scale),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Crear Evento',
                                style: TextStyle(fontSize: 16 * scale),
                              ),
                      ),
                      SizedBox(height: 24 * scale),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}