import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'logger_service.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Tải lên file và trả về URL tải xuống
  Future<String?> uploadFile(File file, String path) async {
    try {
      LoggerService.info('Bắt đầu tải file lên: $path');

      // Kiểm tra file tồn tại
      if (!file.existsSync()) {
        LoggerService.warn('File không tồn tại!');
        return null;
      }

      // Tạo reference và upload
      Reference ref = _storage.ref().child(path);
      UploadTask uploadTask = ref.putFile(file);

      // Theo dõi tiến trình tải lên
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        LoggerService.info('Tiến trình tải lên: ${progress.toStringAsFixed(2)}%');
      });

      // Hoàn tất và lấy URL
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      LoggerService.success('Tải file thành công: $downloadUrl');
      return downloadUrl;

    } on FirebaseException catch (e) {
      LoggerService.error('Lỗi Firebase khi tải file: ${e.message}');
      return null;
    } catch (e) {
      LoggerService.error('Lỗi không xác định khi tải file: $e');
      return null;
    }
  }

  // Xóa file dựa trên URL
  Future<bool> deleteFile(String fileURL) async {
    try {
      LoggerService.info('Bắt đầu xóa file: $fileURL');
      Reference ref = _storage.refFromURL(fileURL);

      await ref.delete();
      LoggerService.success('Xóa file thành công!');
      return true;

    } on FirebaseException catch (e) {
      LoggerService.error('Lỗi Firebase khi xóa file: ${e.message}');
      return false;
    } catch (e) {
      LoggerService.error('Lỗi không xác định khi xóa file: $e');
      return false;
    }
  }

  // Kiểm tra file tồn tại không
  Future<bool> checkFileExists(String path) async {
    try {
      LoggerService.info('Kiểm tra file tại: $path');
      final ref = _storage.ref().child(path);
      await ref.getDownloadURL();
      LoggerService.success('File tồn tại!');
      return true;
    } catch (e) {
      LoggerService.warn('File không tồn tại: $e');
      return false;
    }
  }
}