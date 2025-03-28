import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'logger_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Đăng ký bằng email
  Future<UserCredential?> registerWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      LoggerService.info('Đăng ký thành công: ${userCredential.user?.email}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      LoggerService.error('Lỗi đăng ký: ${e.message}');
      return null;
    }
  }

  // Đăng nhập bằng email
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      LoggerService.info('Đăng nhập thành công: ${userCredential.user?.email}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      LoggerService.error('Lỗi đăng nhập: ${e.message}');
      return null;
    }
  }

  // Đăng nhập Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        LoggerService.warn('Người dùng huỷ đăng nhập Google');
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      LoggerService.info('Đăng nhập Google thành công: ${googleUser.email}');
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      LoggerService.error('Lỗi đăng nhập Google: $e');
      return null;
    }
  }

  // Đăng xuất
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    LoggerService.info('Đăng xuất thành công');
  }

  // Kiểm tra trạng thái đăng nhập
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}