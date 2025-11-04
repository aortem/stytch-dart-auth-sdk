library apply_action_code_test;

import 'package:test/test.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() {
  group('StytchAuth B2B Tests', () {
    test('StytchAuth should create instance with valid config', () {
      // Arrange & Act
      final client = StytchAuth(
        apiKey: 'test-key',
        projectId: 'test-project',
      );

      // Assert
      expect(client, isA<StytchAuth>());
      expect(client.isConfigured(), true);
    });

    test('StytchAuth should validate configuration', () {
      // Arrange & Act & Assert
      expect(
        () => StytchAuth(apiKey: '', projectId: 'test'),
        throwsA(isA<StytchConfigurationException>()),
      );

      expect(
        () => StytchAuth(apiKey: 'test', projectId: ''),
        throwsA(isA<StytchConfigurationException>()),
      );
    });

    test('StytchAuth should have proper service accessors', () {
      // Arrange
      final client = StytchAuth(
        apiKey: 'test-key',
        projectId: 'test-project',
      );

      // Act & Assert
      expect(client.auth, isA<AuthService>());
      expect(client.user, isA<UserService>());
      expect(client.organization, isA<OrganizationService>());
      expect(client.invitation, isA<InvitationService>());
    });

    test('StytchAuth should provide configuration details', () {
      // Arrange
      final client = StytchAuth(
        apiKey: 'test-key',
        projectId: 'test-project',
        environment: 'sandbox',
      );

      // Act
      final config = client.getConfiguration();

      // Assert
      expect(config['projectId'], equals('test-project'));
      expect(config['environment'], equals('sandbox'));
      expect(config['isConfigured'], true);
    });
  });
}
