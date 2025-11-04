/// Working unit tests for stytch Dart B2B Auth SDK
/// These tests verify core functionality without JSON serialization
library test_unit_stytch_working_test;


import 'package:test/test.dart';
import 'package:stytch_dart_auth_sdk/src/client/stytch_client.dart';
import 'package:stytch_dart_auth_sdk/src/models/error.dart';

void main() {
  group('StytchConfig', () {
    test('should create config with valid parameters', () {
      final config = StytchConfig(
        apiKey: 'test-api-key',
        projectId: 'test-project-id',
        environment: 'sandbox',
      );

      expect(config.apiKey, equals('test-api-key'));
      expect(config.projectId, equals('test-project-id'));
      expect(config.environment, equals('sandbox'));
    });

    test('should throw exception for empty API key', () {
      expect(
        () => StytchConfig(
          apiKey: '',
          projectId: 'test-project-id',
        ),
        throwsA(isA<StytchConfigurationException>()),
      );
    });

    test('should throw exception for empty project ID', () {
      expect(
        () => StytchConfig(
          apiKey: 'test-api-key',
          projectId: '',
        ),
        throwsA(isA<StytchConfigurationException>()),
      );
    });

    test('should throw exception for invalid environment', () {
      expect(
        () => StytchConfig(
          apiKey: 'test-api-key',
          projectId: 'test-project-id',
          environment: 'invalid',
        ),
        throwsA(isA<StytchConfigurationException>()),
      );
    });

    test('should return correct base URLs for different environments', () {
      final sandboxConfig = StytchConfig(
        apiKey: 'test-api-key',
        projectId: 'test-project-id',
        environment: 'sandbox',
      );

      final productionConfig = StytchConfig(
        apiKey: 'test-api-key',
        projectId: 'test-project-id',
        environment: 'production',
      );

      expect(
        sandboxConfig.environmentBaseUrl,
        contains('sandbox.stytch.com'),
      );
      expect(
        productionConfig.environmentBaseUrl,
        contains('api.stytch.com'),
      );
    });
  });

  group('StytchHttpClient', () {
    test('should create HTTP client with valid config', () {
      final config = StytchConfig(
        apiKey: 'test-api-key',
        projectId: 'test-project-id',
      );

      final client = StytchHttpClient(config);
      expect(client, isNotNull);
    });
  });

  group('StytchException Hierarchy', () {
    test('should create StytchException with all parameters', () {
      final exception = StytchException(
        'Test message',
        code: 'TEST_CODE',
        statusCode: 400,
        details: {'key': 'value'},
      );

      expect(exception.message, equals('Test message'));
      expect(exception.code, equals('TEST_CODE'));
      expect(exception.statusCode, equals(400));
      expect(exception.details, equals({'key': 'value'}));
    });

    test('should create StytchAuthException', () {
      final exception = StytchAuthException(
        'Auth error',
        code: 'AUTH_ERROR',
        statusCode: 401,
      );

      expect(exception, isA<StytchAuthException>());
      expect(exception.message, equals('Auth error'));
      expect(exception.code, equals('AUTH_ERROR'));
    });

    test('should create StytchValidationException', () {
      final exception = StytchValidationException(
        'Validation error',
        code: 'VALIDATION_ERROR',
        statusCode: 400,
      );

      expect(exception, isA<StytchValidationException>());
      expect(exception.message, equals('Validation error'));
    });

    test('should create StytchRateLimitException', () {
      final exception = StytchRateLimitException(
        'Rate limit exceeded',
        code: 'RATE_LIMIT',
        statusCode: 429,
      );

      expect(exception, isA<StytchRateLimitException>());
      expect(exception.message, equals('Rate limit exceeded'));
    });

    test('should create StytchConfigurationException', () {
      final exception = StytchConfigurationException(
        'Configuration error',
        code: 'CONFIG_ERROR',
      );

      expect(exception, isA<StytchConfigurationException>());
      expect(exception.message, equals('Configuration error'));
    });
  });

  group('ApiErrorResponse', () {
    test('should create ApiErrorResponse with required fields', () {
      final error = ApiErrorResponse(
        errorType: 'auth_error',
        errorMessage: 'Invalid credentials',
        errorCode: 'INVALID_CREDENTIALS',
        requestId: 'req-123',
        metadata: {'user_id': 'user-123'},
      );

      expect(error.errorType, equals('auth_error'));
      expect(error.errorMessage, equals('Invalid credentials'));
      expect(error.errorCode, equals('INVALID_CREDENTIALS'));
      expect(error.requestId, equals('req-123'));
      expect(error.metadata, equals({'user_id': 'user-123'}));
    });

    test('should convert to appropriate exception type', () {
      final authError = ApiErrorResponse(
        errorType: 'auth_error',
        errorMessage: 'Auth failed',
      );
      final validationError = ApiErrorResponse(
        errorType: 'validation_error',
        errorMessage: 'Validation failed',
      );
      final rateLimitError = ApiErrorResponse(
        errorType: 'rate_limit_error',
        errorMessage: 'Too many requests',
      );

      expect(
        authError.toException(),
        isA<StytchAuthException>(),
      );
      expect(
        validationError.toException(),
        isA<StytchValidationException>(),
      );
      expect(
        rateLimitError.toException(),
        isA<StytchRateLimitException>(),
      );
    });
  });
}
