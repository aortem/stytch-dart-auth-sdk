/// Error models for stytch B2B API

/// Base exception class for stytch SDK
class StytchException implements Exception {
  final String message;
  final String? code;
  final int? statusCode;
  final Map<String, dynamic>? details;

  const StytchException(
    this.message, {
    this.code,
    this.statusCode,
    this.details,
  });

  @override
  String toString() => 'StytchException: $message';
}

/// Exception thrown for authentication errors
class StytchAuthException extends StytchException {
  const StytchAuthException(
    String super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

/// Exception thrown for validation errors
class StytchValidationException extends StytchException {
  const StytchValidationException(
    String super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

/// Exception thrown for rate limit errors
class StytchRateLimitException extends StytchException {
  const StytchRateLimitException(
    String super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

/// Exception thrown for configuration errors
class StytchConfigurationException extends StytchException {
  const StytchConfigurationException(
    String super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

/// API error response model
class ApiErrorResponse {
  final String errorType;
  final String errorMessage;
  final String? errorCode;
  final String? requestId;
  final Map<String, dynamic>? metadata;

  const ApiErrorResponse({
    required this.errorType,
    required this.errorMessage,
    this.errorCode,
    this.requestId,
    this.metadata,
  });

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(
      errorType: json['error_type'] as String,
      errorMessage: json['error_message'] as String,
      errorCode: json['error_code'] as String?,
      requestId: json['request_id'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error_type': errorType,
      'error_message': errorMessage,
      if (errorCode != null) 'error_code': errorCode,
      if (requestId != null) 'request_id': requestId,
      if (metadata != null) 'metadata': metadata,
    };
  }

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
  final T? data;
  final ApiErrorResponse? error;

  const ApiResponse({
    this.data,
    this.error,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?)? fromJsonT,
  ) {
    final errorJson = json['error'];
    final dataJson = json['data'];

    return ApiResponse<T>(
      data: dataJson != null && fromJsonT != null ? fromJsonT(dataJson) : null,
      error: errorJson != null
          ? ApiErrorResponse.fromJson(errorJson as Map<String, dynamic>)
          : null,
    );
  }

  bool get hasError => error != null;

  bool get isSuccessful => !hasError && data != null;

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