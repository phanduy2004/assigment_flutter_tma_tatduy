import '../../sqlite/database_helper.dart';

class AuthRemoteDatasource {
  final DatabaseHelper _databaseHelper;

  AuthRemoteDatasource({required DatabaseHelper databaseHelper})
      : _databaseHelper = databaseHelper;

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      // Gọi hàm login từ DatabaseHelper
      final userData = await _databaseHelper.login(username, password);
      return userData;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<Map<String, dynamic>> register(String username, String? fullname,
      String email, String password, String confirmPassword) async {
    try {
      final userData = await _databaseHelper.register(
          username: username,
          password: password,
          confirmPassword: confirmPassword,
          email: email,
          fullName: fullname);
      return userData;
    } catch (e) {
      throw Exception('Register failed: $e');
    }
  }
}
