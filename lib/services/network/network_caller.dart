import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:qma/services/network/network_response.dart';

class NetworkCaller {
  final Logger _logger = Logger();
  Future<NetworkResponse> getRequest(String url, {String? accessToken}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-type': 'application/json',
      };
      if (accessToken != null) {
        headers['token'] = accessToken;
      }
      _logRequest(url);
      final response = await http.get(uri, headers: headers);
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        final errorResponse = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorResponse['message'],
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(
      String url, Map<String, dynamic>? body) async {
    try {
      Uri uri = Uri.parse(url);
      final headers = {"Content-Type": "application/json"};
      _logRequest(url, headers, body);

      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _logResponse(url, response.statusCode, response.headers, response.body);
      final responseBody = jsonDecode(response.body);
      if (responseBody['success'] == true) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: responseBody,
        );
      } else {
        final errorResponse = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorResponse['message'],
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> patchRequest(
      String url, Map<String, dynamic>? body) async {
    try {
      Uri uri = Uri.parse(url);
      final headers = {"Content-Type": "application/json"};
      _logRequest(url, headers, body);
      final response = await http.patch(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        final errorResponse = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorResponse['message'],
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> deleteRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      final headers = {"Content-Type": "application/json"};
      _logRequest(url, headers);
      final response = await http.delete(
        uri,
        headers: headers,
      );
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        final errorResponse = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorResponse['message'],
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  void _logRequest(
    String url, [
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  ]) {
    _logger.i(
        "Request URL => $url\nRequest Header => $headers\nRequest Body => $body");
  }

  void _logResponse(
      String url, int statusCode, Map<String, dynamic>? headers, String body,
      [String? errorMessage]) {
    if (errorMessage != null) {
      _logger.e(
        "Url => $url\nResponse Status Code => $statusCode\nResponse Error Message => $errorMessage",
      );
    } else {
      _logger.i(
        "Url => $url\nResponse Status Code => $statusCode\nResponse Headers => $headers\nResponse Body => $body",
      );
    }
  }
}
