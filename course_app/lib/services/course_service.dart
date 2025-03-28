import 'package:cloud_firestore/cloud_firestore.dart';
import 'logger_service.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Thêm khóa học mới
  Future<void> addCourse(Map<String, dynamic> courseData) async {
    try {
      await _firestore.collection('courses').add(courseData);
      LoggerService.info('Thêm khóa học thành công: ${courseData['title']}');
    } catch (e) {
      LoggerService.error('Lỗi thêm khóa học: $e');
    }
  }

  // Lấy danh sách khóa học
  Future<List<Map<String, dynamic>>> getCourses() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('courses').get();
      LoggerService.info('Lấy danh sách khóa học thành công (${querySnapshot.size} khóa học)');
      return querySnapshot.docs
          .map((doc) => {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id, // Thêm ID khóa học vào luôn
              })
          .toList();
    } catch (e) {
      LoggerService.error('Lỗi lấy khóa học: $e');
      return [];
    }
  }

  // Cập nhật khóa học
  Future<void> updateCourse(String courseId, Map<String, dynamic> updateData) async {
    try {
      await _firestore.collection('courses').doc(courseId).update(updateData);
      LoggerService.info('Cập nhật khóa học $courseId thành công');
    } catch (e) {
      LoggerService.error('Lỗi cập nhật khóa học: $e');
    }
  }

  // Xóa khóa học
  Future<void> deleteCourse(String courseId) async {
    try {
      await _firestore.collection('courses').doc(courseId).delete();
      LoggerService.warn('Đã xóa khóa học $courseId');
    } catch (e) {
      LoggerService.error('Lỗi xóa khóa học: $e');
    }
  }
}
