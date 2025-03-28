class CategoryModel {
  final String id;
  final String name;
  final String iconName;
  final String description;
  final int totalCourses;

  CategoryModel({
    required this.id,
    required this.name,
    required this.iconName,
    this.description = '',
    this.totalCourses = 0,
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconName': iconName,
      'description': description,
      'totalCourses': totalCourses,
    };
  }

  // Create from Map
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      iconName: map['iconName'] ?? '',
      description: map['description'] ?? '',
      totalCourses: map['totalCourses'] ?? 0,
    );
  }

  // Copywrite method
  CategoryModel copyWith({
    String? id,
    String? name,
    String? iconName,
    String? description,
    int? totalCourses,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      description: description ?? this.description,
      totalCourses: totalCourses ?? this.totalCourses,
    );
  }
}