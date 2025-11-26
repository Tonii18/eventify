class CategoryModel {
  String? id;
  String name;
  String descripcion;

  CategoryModel({
    this.id, 
    required this.name, 
    required this.descripcion
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'], 
      descripcion: json['descripcion']
    );
  }
}
