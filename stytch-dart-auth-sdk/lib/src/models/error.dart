library error_models;

/// Error models for stytch B2B API

/// Base exception class for stytch SDK
class StytchException implements Exception {
  /// String
  final String message;

  /// String?
  final String? code;

  /// int?
  final int? statusCode;

  /// Map<String,
  final Map<String, dynamic>? details;

  /// StytchException(
  const StytchException(
    this.message, {
    this.code,
    this.statusCode,
    this.details,
  });

  @override
  /// toString()
  String toString() => 'StytchException: $message';
}

/// Exception thrown for authentication errors
class StytchAuthException extends StytchException {
  /// StytchAuthException(
  const StytchAuthException(
    /// super.message,
    String super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

/// Exception thrown for validation errors
class StytchValidationException extends StytchException {
  /// StytchValidationException(
  const StytchValidationException(
    /// super.message,
    String super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

/// Exception thrown for rate limit errors
class StytchRateLimitException extends StytchException {
  /// StytchRateLimitException(
  const StytchRateLimitException(
    /// super.message,
    String super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

/// Exception thrown for configuration errors
class StytchConfigurationException extends StytchException {
  /// StytchConfigurationException(
  const StytchConfigurationException(
    /// super.message,
    String super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

/// API error response model
class ApiErrorResponse {
  /// String
  final String errorType;

  /// String
  final String errorMessage;

  /// String?
  final String? errorCode;

  /// String?
  final String? requestId;

  /// Map<String,
  final Map<String, dynamic>? metadata;

  /// ApiErrorResponse(
  const ApiErrorResponse({
    required this.errorType,
    required this.errorMessage,
    this.errorCode,
    this.requestId,
    this.metadata,
  });

  /// fromJson
  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(
      errorType: json['error_type'] as String,
      errorMessage: json['error_message'] as String,
      errorCode: json['error_code'] as String?,
      requestId: json['request_id'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'error_type': errorType,
      'error_message': errorMessage,
      if (errorCode != null) 'error_code': errorCode,
      if (requestId != null) 'request_id': requestId,
      if (metadata != null) 'metadata': metadata,
    };
  }

  /// Convert to exception
  StytchException toException() {
    switch (errorType.toLowerCase()) {
      case 'auth_error':
        return StytchAuthException(
          errorMessage,
          code: errorCode,
          details: metadata,
        );
      case 'validation_error':
        return StytchValidationException(
          errorMessage,
          code: errorCode,
          details: metadata,
        );
      case 'rate_limit_error':
        return StytchRateLimitException(
          errorMessage,
          code: errorCode,
          details: metadata,
        );
      case 'configuration_error':
        return StytchConfigurationException(
          errorMessage,
          code: errorCode,
          details: metadata,
        );
      default:
        return StytchException(
          errorMessage,
          code: errorCode,
          details: metadata,
        );
    }
  }
}

/// Generic API response wrapper
class ApiResponse<T> {
  /// T?
  final T? data;

  /// ApiErrorResponse?
  final ApiErrorResponse? error;

  /// ApiResponse(
  const ApiResponse({this.data, this.error});

  /// Create from JSON
  factory ApiResponse.fromJson(
    /// dynamic>
    Map<String, dynamic> json,
    T Function(Object?)? fromJsonT,
  ) {
    /// errorJson
    final errorJson = json['error'];

    /// dataJson
    final dataJson = json['data'];

    return ApiResponse<T>(
      data: dataJson != null && fromJsonT != null ? fromJsonT(dataJson) : null,
      error: errorJson != null
          ? ApiErrorResponse.fromJson(errorJson as Map<String, dynamic>)
          : null,
    );
  }

  /// Whether the response has an error
  bool get hasError => error != null;

  /// Whether the response is successful
  bool get isSuccessful => !hasError && data != null;

  /// Get required data, throwing error if present
  T get requireData {
    if (hasError) {
      throw error!.toException();
    }
    if (data == null) {
      throw const StytchException('No data in response');
    }
    return data!;
  }
}
