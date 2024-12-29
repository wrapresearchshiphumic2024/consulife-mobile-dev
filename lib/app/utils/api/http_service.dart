import 'dart:convert';
import 'package:consulin_mobile_dev/app/utils/storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class HttpService {
  // Function to create request headers
  static Map<String, String> getHeaders({bool includeBearer = false}) {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add Bearer token if needed
    if (includeBearer) {
      headers['Authorization'] =
          'Bearer ${StorageService.getToken("auth_token")}';
    }

    return headers;
  }

  // Function to perform POST request
  static Future<http.Response> postRequest(
    String endpoint, {
    Map<String, dynamic>? body,
    bool includeBearer = false,
  }) async {
    try {
      final Uri url = Uri.parse('${dotenv.env["API_URL"]}$endpoint');
      final headers = getHeaders(includeBearer: includeBearer);
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Function to perform PUT request
  static Future<http.Response> putRequest(
    String endpoint, {
    Map<String, dynamic>? body,
    bool includeBearer = false,
  }) async {
    try {
      final Uri url = Uri.parse('${dotenv.env["API_URL"]}$endpoint');
      final headers = getHeaders(includeBearer: includeBearer);
      final response = await http.put(
        url,
        headers: headers,
        body: json.encode(body),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Function to perform GET request
  static Future<http.Response> getRequest(String endpoint,
      {bool includeBearer = false}) async {
    try {
      final Uri url = Uri.parse('${dotenv.env["API_URL"]}$endpoint');
      final headers = getHeaders(includeBearer: includeBearer);
      final response = await http.get(
        url,
        headers: headers,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
