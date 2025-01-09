import 'dart:convert';
import 'package:consulin_mobile_dev/app/utils/storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:io'; // Untuk file
import 'package:http_parser/http_parser.dart'; // Untuk content-type file

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

  // Function to perform Multipart POST request for file upload
  static Future<http.Response> postMultipartRequest(
    String endpoint, {
    Map<String, String>? fields, // Form fields
    List<Map<String, dynamic>>? files, // List of files
    bool includeBearer = false,
  }) async {
    try {
      final Uri url = Uri.parse('${dotenv.env["API_URL"]}$endpoint');
      var request = http.MultipartRequest('POST', url);

      // Add form fields to the request
      if (fields != null) {
        fields.forEach((key, value) {
          request.fields[key] = value;
        });
      }

      // Add files to the request
      if (files != null) {
        for (var file in files) {
          if (file['fieldName'] != null && file['filePath'] != null) {
            var filePath = file['filePath'];
            var fileName = file['fileName'];
            request.files.add(await http.MultipartFile.fromPath(
              file['fieldName'],
              filePath,
              filename: fileName,
              contentType: MediaType('application',
                  'octet-stream'), // Optionally specify content type
            ));
          }
        }
      }

      // Add Authorization header if required
      if (includeBearer) {
        final token = await StorageService.getToken("auth_token");
        if (token != null) {
          request.headers['Authorization'] = 'Bearer $token';
        }
      }

      // Send the request
      final response = await request.send();
      return await http.Response.fromStream(response);
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
