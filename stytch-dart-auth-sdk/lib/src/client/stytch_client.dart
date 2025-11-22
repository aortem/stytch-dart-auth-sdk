library stytch_client;

/// Base API client for stytch B2B API
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/error.dart';

/// Configuration for the stytch API client
class StytchConfig {
  /// Base URL for the stytch B2B API
  static const String baseUrl = 'https://api.stytch.com/v1';

  /// The API key for authentication
  final String apiKey;

  /// The project ID
  final String projectId;

  /// Environment (sandbox, development, production)
  final String environment;

  /// Base URL (optional override)
  final String baseUrlOverride;

  /// HTTP timeout duration
  final Duration timeout;

  /// Private computed environment base URL
  final String _environmentBaseUrl;

  /// Configuration
  StytchConfig({
    required this.apiKey,
    required this.projectId,
    this.environment = 'production',
    this.baseUrlOverride = '',
    this.timeout = const Duration(seconds: 30),
  }) : _environmentBaseUrl = _getEnvironmentBaseUrl(
         environment,
         baseUrlOverride,
       ) {
    validate();
  }

  /// Get the full base URL for the current environment
  String get fullBaseUrl =>
      baseUrlOverride.isNotEmpty ? baseUrlOverride : baseUrl;

  /// Get the appropriate base URL for the environment
  String get environmentBaseUrl => _environmentBaseUrl;

  /// Helper method to get environment base URL
  static String _getEnvironmentBaseUrl(
    String environment,
    String baseUrlOverride,
  ) {
    if (baseUrlOverride.isNotEmpty) return baseUrlOverride;

    switch (environment.toLowerCase()) {
      case 'sandbox':
        return 'https://api.sandbox.stytch.com/v1';
      case 'development':
        return 'https://api.development.stytch.com/v1';
      case 'production':
      default:
        return 'https://api.stytch.com/v1';
    }
  }

  /// Validate the configuration
  void validate() {
    if (apiKey.isEmpty) {
      throw StytchConfigurationException('API key cannot be empty');
    }
    if (projectId.isEmpty) {
      throw StytchConfigurationException('Project ID cannot be empty');
    }

    /// validEnvironments
    final validEnvironments = ['sandbox', 'development', 'production'];
    if (!validEnvironments.contains(environment.toLowerCase())) {
      throw StytchConfigurationException(
        'Environment must be one of: sandbox, development, production',
      );
    }
  }
}

/// HTTP client wrapper with proper headers and error handling
class StytchHttpClient {
  /// StytchConfig
  final StytchConfig config;

  /// HTTP client configuration
  StytchHttpClient(this.config) {
    config.validate();
  }

  /// Create authenticated headers
  Map<String, String> _createHeaders() {
    /// credentials
    final credentials = base64Encode(
      utf8.encode('${config.projectId}:${config.apiKey}'),
    );
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $credentials',
      'User-Agent': 'stytch-dart-auth-sdk/0.1.0',
    };
  }

  /// Parse error response
  StytchException _parseError(int statusCode, String responseBody) {
    try {
      /// json
      final json = jsonDecode(responseBody) as Map<String, dynamic>;
      if (json.containsKey('error')) {
        /// error
        final error = ApiErrorResponse.fromJson(
          json['error'] as Map<String, dynamic>,
        );
        return error.toException();
      }
    } catch (e) {
      // If we can't parse the error, return a generic one
    }

    // Fallback to status code based error
    switch (statusCode) {
      case 400:
        return const StytchValidationException('Bad request');
      case 401:
        return const StytchAuthException('Unauthorized');
      case 403:
        return const StytchAuthException('Forbidden');
      case 404:
        return const StytchException('Not found');
      case 429:
        return const StytchRateLimitException('Rate limit exceeded');
      case 500:
        return const StytchException('Internal server error');
      default:
        return StytchException('HTTP $statusCode: $responseBody');
    }
  }

  /// Make GET request
  Future<Map<String, dynamic>> get(
    String path, [
    Map<String, String>? queryParameters,
  ]) async {
    /// uri
    final uri = Uri.parse(
      '${config.environmentBaseUrl}$path',
    ).replace(queryParameters: queryParameters);

    /// response
    final response = await http
        .get(uri, headers: _createHeaders())
        .timeout(config.timeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw _parseError(response.statusCode, response.body);
    }
  }

  /// Make POST request
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    /// uri
    final uri = Uri.parse('${config.environmentBaseUrl}$path');

    /// response
    final response = await http
        .post(
          uri,
          headers: _createHeaders(),
          body: body != null ? jsonEncode(body) : null,
        )
        .timeout(config.timeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw _parseError(response.statusCode, response.body);
    }
  }

  /// Make PUT request
  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    /// uri
    final uri = Uri.parse('${config.environmentBaseUrl}$path');

    /// response
    final response = await http
        .put(
          uri,
          headers: _createHeaders(),
          body: body != null ? jsonEncode(body) : null,
        )
        .timeout(config.timeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw _parseError(response.statusCode, response.body);
    }
  }

  /// Make DELETE request
  Future<Map<String, dynamic>> delete(String path) async {
    /// uri
    final uri = Uri.parse('${config.environmentBaseUrl}$path');

    /// response
    final response = await http
        .delete(uri, headers: _createHeaders())
        .timeout(config.timeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw _parseError(response.statusCode, response.body);
    }
  }

  /// Make PATCH request
  Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    /// uri
    final uri = Uri.parse('${config.environmentBaseUrl}$path');

    /// response
    final response = await http
        .patch(
          uri,
          headers: _createHeaders(),
          body: body != null ? jsonEncode(body) : null,
        )
        .timeout(config.timeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw _parseError(response.statusCode, response.body);
    }
  }
}
