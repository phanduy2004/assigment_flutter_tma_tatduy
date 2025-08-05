
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
}