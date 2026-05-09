/// Unit tests for user models
library test_unit_models_test;

import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() {
  group('User Models', () {
    test('CreateUserRequest should serialize correctly', () {
      final request = CreateUserRequest(
        email: 'test@example.com',
        name: 'Test User',
        password: 'password123',
        isMfaEnabled: true,
        attributes: {'department': 'engineering'},
        organizationId: 'org_123',
      );

      final json = request.toJson();
      expect(json['email'], equals('test@example.com'));
      expect(json['name'], equals('Test User'));
      expect(json['password'], equals('password123'));
      expect(json['is_mfa_enabled'], isTrue);
      expect(json['attributes']['department'], equals('engineering'));
      expect(json['organization_id'], equals('org_123'));
    });

    test('User should serialize and deserialize correctly', () {
      final user = User(
        userId: 'user_123',
        email: 'test@example.com',
        name: 'Test User',
        isMfaEnabled: true,
        attributes: {'department': 'engineering'},
        createdAt: DateTime(2023, 1, 1),
        updatedAt: DateTime(2023, 1, 2),
        organizationIds: ['org_123'],
      );

      final json = user.toJson();
      final deserializedUser = User.fromJson(json);

      expect(deserializedUser.userId, equals(user.userId));
      expect(deserializedUser.email, equals(user.email));
      expect(deserializedUser.name, equals(user.name));
      expect(deserializedUser.isMfaEnabled, equals(user.isMfaEnabled));
      expect(deserializedUser.organizationIds, equals(user.organizationIds));
    });

    test('UpdateUserRequest should handle null fields correctly', () {
      final request = UpdateUserRequest(
        name: 'Updated User',
        isMfaEnabled: false,
      );

      final json = request.toJson();
      expect(json.containsKey('name'), isTrue);
      expect(json.containsKey('is_mfa_enabled'), isTrue);
      expect(json.containsKey('attributes'), isFalse);
    });
  });

  group('Auth Models', () {
    test('EmailPasswordLoginRequest should serialize correctly', () {
      final request = EmailPasswordLoginRequest(
        email: 'test@example.com',
        password: 'password123',
        organizationId: 'org_123',
        attributes: {'source': 'web'},
      );

      final json = request.toJson();
      expect(json['email'], equals('test@example.com'));
      expect(json['password'], equals('password123'));
      expect(json['organization_id'], equals('org_123'));
      expect(json['attributes']['source'], equals('web'));
    });

    test('AuthResponse should handle session data correctly', () {
      final response = AuthResponse(
        userId: 'user_123',
        email: 'test@example.com',
        name: 'Test User',
        isMfaEnabled: false,
        organizationIds: ['org_123', 'org_456'],
        sessionId: 'session_123',
        sessionToken: 'token_123',
        sessionExpiresAt: DateTime(2023, 12, 31),
        userAttributes: {'role': 'admin'},
        createdAt: DateTime(2023, 1, 1),
      );

      final json = response.toJson();
      final deserializedResponse = AuthResponse.fromJson(json);

      expect(deserializedResponse.userId, equals(response.userId));
      expect(deserializedResponse.sessionId, equals(response.sessionId));
      expect(deserializedResponse.sessionToken, equals(response.sessionToken));
      expect(deserializedResponse.organizationIds.length, equals(2));
    });

    test('SendDiscoveryEmailRequest should serialize optional fields', () {
      final request = SendDiscoveryEmailRequest(
        emailAddress: ' prospect@example.com ',
        discoveryRedirectUrl: 'https://example.com/discovery/callback',
        pkceCodeChallenge: 'challenge',
        loginTemplateId: 'template_123',
        locale: 'en',
        discoveryExpirationMinutes: 60,
      );

      final json = request.toJson();

      expect(json['email_address'], equals('prospect@example.com'));
      expect(
        json['discovery_redirect_url'],
        equals('https://example.com/discovery/callback'),
      );
      expect(json['pkce_code_challenge'], equals('challenge'));
      expect(json['login_template_id'], equals('template_123'));
      expect(json['locale'], equals('en'));
      expect(json['discovery_expiration_minutes'], equals(60));
    });

    test('SendDiscoveryEmailRequest should reject invalid email values', () {
      expect(
        () => SendDiscoveryEmailRequest(emailAddress: ''),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => SendDiscoveryEmailRequest(emailAddress: 'not-an-email'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('SendDiscoveryEmailResponse should serialize and deserialize', () {
      final response = SendDiscoveryEmailResponse.fromJson({
        'request_id': 'request-123',
        'status_code': 200,
      });

      expect(response.requestId, equals('request-123'));
      expect(response.statusCode, equals(200));
      expect(response.toJson(), {
        'request_id': 'request-123',
        'status_code': 200,
      });
    });
  });
}
