enum CourseLevel { beginner, intermediate, advanced }
enum CourseCategory { programming, design, marketing, language, business }

class CourseModel {
  final String id;
  final String title;
  final String description;
  final String instructorId;
  final String instructorName;
  final double price;
  final double? discountPrice;
  final String imageUrl;
  final CourseLevel level;
  final CourseCategory category;
  final double rating;
  final int totalReviews;
  final int totalEnrollments;
  final List<String> learningOutcomes;
  final List<String> requirements;
  final DateTime createdAt;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.instructorId,
    required this.instructorName,
    required this.price,
    this.discountPrice,
    required this.imageUrl,
    this.level = CourseLevel.beginner,
    required this.category,
    this.rating = 0.0,
    this.totalReviews = 0,
    this.totalEnrollments = 0,
    this.learningOutcomes = const [],
    this.requirements = const [],
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'instructorId': instructorId,
      'instructorName': instructorName,
      'price': price,
      'discountPrice': discountPrice,
      'imageUrl': imageUrl,
      'level': level.toString().split('.').last,
      'category': category.toString().split('.').last,
      'rating': rating,
      'totalReviews': totalReviews,
      'totalEnrollments': totalEnrollments,
      'learningOutcomes': learningOutcomes,
      'requirements': requirements,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create from Map
  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      instructorId: map['instructorId'] ?? '',
      instructorName: map['instructorName'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      discountPrice: (map['discountPrice'] ?? 0.0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      level: CourseLevel.values.firstWhere(
        (e) => e.toString().split('.').last == (map['level'] ?? 'beginner'),
      ),
      category: CourseCategory.values.firstWhere(
        (e) => e.toString().split('.').last == (map['category'] ?? 'programming'),
      ),
      rating: (map['rating'] ?? 0.0).toDouble(),
      totalReviews: map['totalReviews'] ?? 0,
      totalEnrollments: map['totalEnrollments'] ?? 0,
      learningOutcomes: List<String>.from(map['learningOutcomes'] ?? []),
      requirements: List<String>.from(map['requirements'] ?? []),
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  // Copywrite method
  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    String? instructorId,
    String? instructorName,
    double? price,
    double? discountPrice,
    String? imageUrl,
    CourseLevel? level,
    CourseCategory? category,
    double? rating,
    int? totalReviews,
    int? totalEnrollments,
    List<String>? learningOutcomes,
    List<String>? requirements,
    DateTime? createdAt,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      instructorId: instructorId ?? this.instructorId,
      instructorName: instructorName ?? this.instructorName,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      level: level ?? this.level,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      totalEnrollments: totalEnrollments ?? this.totalEnrollments,
      learningOutcomes: learningOutcomes ?? this.learningOutcomes,
      requirements: requirements ?? this.requirements,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}