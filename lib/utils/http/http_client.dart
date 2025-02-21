import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class THttpHelper {
  static const String _baseUrlOld = 'https://nebulacard.ltmetro.com';
  static const String _baseUrl = 'https://stage.tsavaari.com';

  // Helper method to make a GET request
  static Future<Map<String, dynamic>> get(String endpoint,
      {bool newUrl = true}) async {
    final url = newUrl ? _baseUrl : _baseUrlOld;
    final response = await http.get(Uri.parse('$url/$endpoint'));
    // .timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print('------------------------------------------------------');
      print('end-point : $url/$endpoint');
      print('response: ${response.body}');
    }

    return _handleResponse(response);
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(
    String endpoint,
    dynamic data, {
    bool newUrl = true,
    dynamic headers,
  }) async {
    final url = newUrl ? _baseUrl : _baseUrlOld;

    final response = await http.post(
      Uri.parse('$url/$endpoint'),
      headers: headers ??
          {
            'Content-Type': 'application/json',
          },
      body: data != null ? json.encode(data) : null,
    );
    // .timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print('------------------------------------------------------');
      print('end-point : $url/$endpoint');
      print('headers : $headers');
      print('payload : $data');
      print('response: ${response.body}');
    }
    return _handleResponse(response);
  }

  // Helper method to make a Patch request
  static Future<Map<String, dynamic>> patch(
    String endpoint,
    dynamic data, {
    bool newUrl = true,
    dynamic headers,
  }) async {
    final url = newUrl ? _baseUrl : _baseUrlOld;
    final response = await http.patch(
      Uri.parse('$url/$endpoint'),
      headers: headers ??
          {
            'Content-Type': 'application/json',
          },
      body: data != null ? json.encode(data) : null,
    );
    // .timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print('------------------------------------------------------');
      print('end-point : $url/$endpoint');
      print('headers : $headers');
      print('payload : $data');
      print('response: ${response.body}');
    }
    return _handleResponse(response);
  }

  // Helper method to make a PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    // .timeout(const Duration(seconds: 10));
    return _handleResponse(response);
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    // .timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print('$_baseUrl/$endpoint');
      print(response.body);
    }
    return _handleResponse(response);
  }

  // Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      var res = response.body;
      if (response.body[0] == '[' || response.body[0] != '{') {
        res = '{"response": ${response.body}}';
      }

      return json.decode(res);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
