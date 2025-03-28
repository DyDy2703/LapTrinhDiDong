enum OrderStatus { pending, completed, failed, refunded }

class OrderModel {
  final String id;
  final String userId;
  final String courseId;
  final String courseName;
  final double totalAmount;
  final OrderStatus status;
  final DateTime createdAt;
  final String paymentMethod;
  final String transactionId;

  OrderModel({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.courseName,
    required this.totalAmount,
    this.status = OrderStatus.pending,
    DateTime? createdAt,
    this.paymentMethod = '',
    this.transactionId = '',
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'courseId': courseId,
      'courseName': courseName,
      'totalAmount': totalAmount,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'paymentMethod': paymentMethod,
      'transactionId': transactionId,
    };
  }

  // Create from Map
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      courseId: map['courseId'] ?? '',
      courseName: map['courseName'] ?? '',
      totalAmount: (map['totalAmount'] ?? 0.0).toDouble(),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString().split('.').last == (map['status'] ?? 'pending'),
      ),
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      paymentMethod: map['paymentMethod'] ?? '',
      transactionId: map['transactionId'] ?? '',
    );
  }

  // Copywrite method
  OrderModel copyWith({
    String? id,
    String? userId,
    String? courseId,
    String? courseName,
    double? totalAmount,
    OrderStatus? status,
    DateTime? createdAt,
    String? paymentMethod,
    String? transactionId,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
      courseName: courseName ?? this.courseName,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionId: transactionId ?? this.transactionId,
    );
  }
}