import 'package:eventify/models/category_model.dart';
import 'package:eventify/services/category_service.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  bool _isLoading = false;
  String? _errorMessage;
  List<CategoryModel> _categories = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<CategoryModel> get categories => _categories;

  Future<bool> getCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await _categoryService.getCategories();
      _errorMessage = null;
    } catch (e) {
      _categories = [];
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();

    return _categories.isNotEmpty;
  }
}
