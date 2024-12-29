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

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
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
        print(response.body);
        throw Exception('Login gagal: ${response.statusCode}');
      }
    } catch (e) {
      // Menangani error lainnya dan melempar exception lebih lanjut
      print('Terjadi kesalahan: $e');
      throw Exception('Terjadi kesalahan saat proses login: $e');
    }
  }
}
