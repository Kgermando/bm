import 'package:dio/dio.dart';
import 'package:e_management/resources/logging.dart';
import 'package:e_management/src/models/user_model.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.43.230:3000/api',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  )..interceptors.add(Logging());

  Future<User?> getUser() async {
    User? user;
    try {
      Response userData = await _dio.get('http://192.168.43.230:3000/api/auth/user');

      print('User Info: ${userData.data}');

      user = User.fromJson(userData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }

    return user;
  }

  Future<User?> createUser({required User userInfo}) async {
    User? retrievedUser;

    try {
      Response response = await _dio.post(
        '/auth/register',
        data: userInfo.toJson(),
      );

      print('User created: ${response.data}');

      retrievedUser = User.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedUser;
  }

  Future<User?> updateUser({
    required User userInfo,
    required String id,
  }) async {
    User? updatedUser;

    try {
      Response response = await _dio.put(
        '/users/$id',
        data: userInfo.toJson(),
      );

      print('User updated: ${response.data}');

      updatedUser = User.fromJson(response.data);
    } catch (e) {
      print('Error updating user: $e');
    }

    return updatedUser;
  }

  Future<void> deleteUser({required String id}) async {
    try {
      await _dio.delete('/users/$id');
      print('User deleted!');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}
