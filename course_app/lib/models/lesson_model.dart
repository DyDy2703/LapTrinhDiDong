enum LessonType { video, text, quiz }

class LessonModel {
  final String id;
  final String courseId;
  final String title;
  final String description;
  final LessonType type;
  final String contentUrl;
  final int duration; // in seconds
  final bool isFree;
  final int orderIndex;

  LessonModel({
    required this.id,
    required this.courseId,
    required this.title,
    this.description = '',
    this.type = LessonType.video,
    required this.contentUrl,
    this.duration = 0,
    this.isFree = false,
    this.orderIndex = 0,
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'type': type.toString().split('.').last,
      'contentUrl': contentUrl,
      'duration': duration,
      'isFree': isFree,
      'orderIndex': orderIndex,
    };
  }

  // Create from Map
  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      id: map['id'] ?? '',
      courseId: map['courseId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      type: LessonType.values.firstWhere(
        (e) => e.toString().split('.').last == (map['type'] ?? 'video'),
      ),
      contentUrl: map['contentUrl'] ?? '',
      duration: map['duration'] ?? 0,
      isFree: map['isFree'] ?? false,
      orderIndex: map['orderIndex'] ?? 0,
    );
  }

  // Copywrite method
  LessonModel copyWith({
    String? id,
    String? courseId,
    String? title,
    String? description,
    LessonType? type,
    String? contentUrl,
    int? duration,
    bool? isFree,
    int? orderIndex,
  }) {
    return LessonModel(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      contentUrl: contentUrl ?? this.contentUrl,
      duration: duration ?? this.duration,
      isFree: isFree ?? this.isFree,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }
}