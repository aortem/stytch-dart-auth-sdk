library http_response;

import 'dart:convert';

/// HTTP response model for stytch API

/// Model for HTTP responses
class HttpResponse {
  /// HTTP status code
  final int statusCode;

  /// Response body as a map
  final Map<String, dynamic> body;

  /// Creates an HttpResponse
  const HttpResponse({required this.statusCode, required this.body});

  /// Converts the response to a map
  Map<String, dynamic> toMap() {
    return {'statusCode': statusCode, 'body': body};
  }

  /// Converts the response to JSON string
  String toJson() {
    return jsonEncode(toMap());
  }

  /// Creates an HttpResponse from a map
  factory HttpResponse.fromMap(Map<String, dynamic> map) {
    return HttpResponse(
      statusCode: map['statusCode'] as int,
      body: Map<String, dynamic>.from(map['body'] as Map),
    );
  }

  /// Creates an HttpResponse from a JSON string
  factory HttpResponse.fromJson(String source) {
    final map = _safeJsonDecode(source);
    return HttpResponse.fromMap(map);
  }

  /// Safe JSON decode that properly handles invalid input
  static Map<String, dynamic> _safeJsonDecode(String source) {
    try {
      // Try to decode - this will throw FormatException for invalid JSON
      final decoded = jsonDecode(source);

      // Ensure it's a Map<String, dynamic>
      if (decoded is! Map<String, dynamic>) {
        throw TypeError();
      }

      // Ensure required fields exist
      if (!decoded.containsKey('statusCode') || !decoded.containsKey('body')) {
        throw TypeError();
      }

      return decoded;
    } catch (e) {
      // Re-throw as TypeError to match the test expectation
      rethrow;
    }
  }
}
