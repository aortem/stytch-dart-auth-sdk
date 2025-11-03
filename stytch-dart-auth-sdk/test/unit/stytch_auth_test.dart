/// Unit tests for stytch_auth.dart
import 'package:test/test.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() {
  group('stytchAuth', () {
    test('should create instance with valid config', () {
      final auth = stytchAuth(
        apiKey: 'test_api_key',
        projectId: 'test_project_id',
        environment: 'sandbox',
      );

      expect(auth.isConfigured(), isTrue);
      expect(auth.auth, isNotNull);
      expect(auth.user, isNotNull);
      expect(auth.organization, isNotNull);
      expect(auth.invitation, isNotNull);
    });

    test('should validate configuration', () {
      expect(
        () => stytchAuth(
          apiKey: '',
          projectId: 'test_project_id',
        ),
        throwsA(isA<StytchConfigurationException>()),
      );

      expect(
        () => stytchAuth(
          apiKey: 'test_api_key',
          projectId: '',
        ),
        throwsA(isA<StytchConfigurationException>()),
      );

      expect(
        () => stytchAuth(
          apiKey: 'test_api_key',
          projectId: 'test_project_id',
          environment: 'invalid_env',
        ),
        throwsA(isA<StytchConfigurationException>()),
      );
    });

    test('should return configuration details', () {
      final auth = stytchAuth(
        apiKey: 'test_api_key',
        projectId: 'test_project_id',
        environment: 'development',
      );

      final config = auth.getConfiguration();
      expect(config['projectId'], equals('test_project_id'));
      expect(config['environment'], equals('development'));
      expect(config['isConfigured'], isTrue);
      expect(config['timeout'], equals(30));
    });

    test('should access individual services', () {
      final auth = stytchAuth(
        apiKey: 'test_api_key',
        projectId: 'test_project_id',
      );

      expect(auth.auth, isA<AuthService>());
      expect(auth.user, isA<UserService>());
      expect(auth.organization, isA<OrganizationService>());
      expect(auth.invitation, isA<InvitationService>());
    });
  });

  group('Global initialization', () {
    test('should initialize global instance', () {
      initializeStytch(
        apiKey: 'test_api_key',
        projectId: 'test_project_id',
      );

      expect(() => stytchApp, returnsNormally);
      expect(stytchApp.isConfigured(), isTrue);
    });
  });
}