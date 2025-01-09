import 'dart:convert';

import 'package:consulin_mobile_dev/app/utils/api/http_service.dart';
import 'package:consulin_mobile_dev/app/utils/storage_service.dart';

class AuthService {
  Future<String> login(String email, String password) async {
    try {
      final body = {
        'email': email,
        'password': password,
      };

      final response = await HttpService.postRequest('/login', body: body);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data['data']['role'] == "admin") {
          throw Exception('Credentials not valid');
        }
        var token = data['data']['access_token'];
        var role = data['data']['role'];
        var user_id = data['data']['user_id'];

        if (token != null) {
          StorageService.saveToken('auth_token', token);
          StorageService.saveToken('role', role);
          StorageService.saveToken('user_id', user_id);
          print('Token berhasil disimpan: $token');
          return role;
        } else {
          throw Exception('Token not found');
        }
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> formData) async {
    try {
      final body = {
        'firstname': formData['firstname'],
        'lastname': formData['lastname'],
        'phone_number': formData['phone_number'],
        'email': formData['email'],
        'gender': formData['gender'],
        'password': formData['password'],
      };

      // Kirim data ke API
      final response = await HttpService.postRequest('/register', body: body);
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {'success': data['status']};
      } else {
        if (data['status'] == 'error') {
          return {'errors': data['errors']['email'][0]};
        }
        print('Register gagal: ${response.body}');
        throw Exception('Register gagal dengan status: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
