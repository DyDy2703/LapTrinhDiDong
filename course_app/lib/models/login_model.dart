class LoginModel {
  final String username;
  final String password;

  LoginModel({
    required this.username,
    required this.password,
  });

  // Convert UserModel to Map (for Firebase)
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  // Create UserModel from Map (from Firebase)
  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
