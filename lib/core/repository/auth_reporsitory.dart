abstract class AuthRepository {
  Future<Map<String, dynamic>> login({required String username, required String password});
  Future<Map<String, dynamic>> register({required String username, String fullname,required String email,required String password,required String confirmPassword});
}
