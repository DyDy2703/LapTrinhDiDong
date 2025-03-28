import 'package:cloud_firestore/cloud_firestore.dart';
import 'logger_service.dart';

class EnrollmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Lấy danh sách khóa học đã đăng ký của người dùng
  Future<List<String>> getUserEnrolledCourses(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        LoggerService.info('Lấy khóa học của người dùng $userId thành công');
        return List<String>.from(userData['enrolledCourses'] ?? []);
      } else {
        LoggerService.warn('Không tìm thấy thông tin người dùng: $userId');
        return [];
      }
    } catch (e) {
      LoggerService.error('Lỗi lấy khóa học đã đăng ký: $e');
      return [];
    }
  }

  // Theo dõi tiến độ bài học của người dùng trong khóa học
  Future<bool> trackCourseProgress(
      String userId, String courseId, String lessonId, bool completed) async {
    try {
      final progressRef = _firestore
          .collection('user_progress')
          .doc('${userId}_$courseId');

      if (completed) {
        await progressRef.set({
          'userId': userId,
          'courseId': courseId,
          'completedLessons': FieldValue.arrayUnion([lessonId])
        }, SetOptions(merge: true));
        LoggerService.info('Đánh dấu hoàn thành bài học: $lessonId');
      } else {
        await progressRef.update({
          'completedLessons': FieldValue.arrayRemove([lessonId])
        });
        LoggerService.warn('Gỡ bỏ bài học khỏi danh sách hoàn thành: $lessonId');
      }

      return true;
    } catch (e) {
      LoggerService.error('Lỗi cập nhật tiến độ: $e');
      return false;
    }
  }

  // Lấy tiến độ của người dùng với khóa học cụ thể
  Future<List<String>> getCourseProgress(String userId, String courseId) async {
    try {
      DocumentSnapshot progressDoc = await _firestore
          .collection('user_progress')
          .doc('${userId}_$courseId')
          .get();

      if (progressDoc.exists) {
        Map<String, dynamic> progressData =
            progressDoc.data() as Map<String, dynamic>;
        LoggerService.info('Lấy tiến độ khóa học $courseId thành công');
        return List<String>.from(progressData['completedLessons'] ?? []);
      } else {
        LoggerService.warn('Chưa có tiến độ nào cho khóa học $courseId');
        return [];
      }
    } catch (e) {
      LoggerService.error('Lỗi lấy tiến độ khóa học: $e');
      return [];
    }
  }
}