import 'package:hello/core/datasource/auth_remote_datasource.dart';

import '../../sqlite/database_helper.dart';
import '../repository/auth_reporsitory.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final DatabaseHelper databaseHelper;
  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.databaseHelper,
  });

  @override
  Future<Map<String, dynamic>> login({required String username, required String password}) async {
    try {
      // Kiểm tra đăng nhập qua SQLite
      final user = await databaseHelper.getUser(username);
      if (user != null && user['password'] == password) {
        return user;
      }
      // Nếu không tìm thấy trong SQLite, thử API
      final response = await authRemoteDatasource.login(username, password);
      await databaseHelper.saveUser(
        username: response['username'],
        password: password,
        email: response['email'],
        fullName: response['fullName'],
      );
      return response;
    } catch (e) {
      throw Exception('Đăng nhập thất bại: $e');
    }
  }
}