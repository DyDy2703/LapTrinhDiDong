import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userId;
  String? _name;
  String? _email;

  bool get isAuthenticated => _isAuthenticated;
  String? get userId => _userId;
  String? get name => _name;
  String? get email => _email;

  Future<bool> login(String email, String password) async {
    // Mô phỏng đăng nhập - sau này sẽ thay bằng Firebase Auth
    await Future.delayed(const Duration(seconds: 1));
    
    // Giả lập đăng nhập thành công
    _isAuthenticated = true;
    _userId = "user123";
    _name = "Test User";
    _email = email;
    
    notifyListeners();
    return _isAuthenticated;
  }
  
  Future<void> logout() async {
    // Mô phỏng đăng xuất
    await Future.delayed(const Duration(milliseconds: 500));
    
    _isAuthenticated = false;
    _userId = null;
    _name = null;
    _email = null;
    
    notifyListeners();
  }
  
  Future<bool> register(String name, String email, String password) async {
    // Mô phỏng đăng ký - sau này sẽ thay bằng Firebase Auth
    await Future.delayed(const Duration(seconds: 1));
    
    // Giả lập đăng ký thành công
    _isAuthenticated = true;
    _userId = "user${DateTime.now().millisecondsSinceEpoch}";
    _name = name;
    _email = email;
    
    notifyListeners();
    return true;
  }
  
  Future<void> updateProfile({String? name, String? email}) async {
    // Mô phỏng cập nhật thông tin người dùng
    await Future.delayed(const Duration(milliseconds: 800));
    
    if (name != null) _name = name;
    if (email != null) _email = email;
    
    notifyListeners();
  }
}