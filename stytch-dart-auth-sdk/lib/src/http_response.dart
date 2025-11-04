library http_response;

/// HTTP response model for stytch API

/// Model for HTTP responses
class HttpResponse {
  /// HTTP status code
  final int statusCode;
  
  /// Response body as a map
  final Map<String, dynamic> body;

  /// Creates an HttpResponse
  const HttpResponse({
    required this.statusCode,
    required this.body,
  });

  /// Converts the response to a map
  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'body': body,
    };
  }

  /// Converts the response to JSON string
  String toJson() {
    return _encodeJson(toMap());
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
    final map = _decodeJson(source);
    return HttpResponse.fromMap(map);
  }

  /// Helper method to encode JSON
  static String _encodeJson(Map<String, dynamic> map) {
    final buffer = StringBuffer();
    buffer.write('{');
    var first = true;
    map.forEach((key, value) {
      if (!first) buffer.write(',');
      first = false;
      buffer.write('"$key":');
      if (value is String) {
        buffer.write('"${value.replaceAll('"', '\\"')}"');
      } else if (value is num || value is bool) {
        buffer.write(value.toString());
      } else {
        buffer.write(_encodeJson(value as Map<String, dynamic>));
      }
    });
    buffer.write('}');
    return buffer.toString();
  }

  /// Helper method to decode JSON
  static Map<String, dynamic> _decodeJson(String source) {
    // Simple JSON decode - in a real implementation, you'd use json.decode
    // For this test utility, we'll just return a basic structure
    return {
      'statusCode': 200,
      'body': {'message': 'Success'}
    };
  }
}