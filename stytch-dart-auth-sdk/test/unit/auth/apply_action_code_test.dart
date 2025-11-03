import 'package:test/test.dart';
import 'package:stytch_dart_auth_sdk/stytch_auth.dart';

void main() {
  group('stytchAuth B2B Tests', () {
    late stytchAuth authClient;

    setUp(() {
      authClient = stytchAuth(
        apiKey: 'test-api-key',
        projectId: 'test-project-id',
      );
    });

    test('stytchAuth should create instance with valid config', () {
      // Arrange & Act
      final client = stytchAuth(
        apiKey: 'test-key',
        projectId: 'test-project',
      );

      // Assert
      expect(client, isA<stytchAuth>());
      expect(client.isConfigured(), true);
    });

    test('stytchAuth should validate configuration', () {
      // Arrange & Act & Assert
      expect(
        () => stytchAuth(apiKey: '', projectId: 'test'),
        throwsA(isA<StytchConfigurationException>()),
      );

      expect(
        () => stytchAuth(apiKey: 'test', projectId: ''),
        throwsA(isA<StytchConfigurationException>()),
      );
    });

    test('stytchAuth should have proper service accessors', () {
      // Arrange
      final client = stytchAuth(
        apiKey: 'test-key',
        projectId: 'test-project',
      );

      // Act & Assert
      expect(client.auth, isA<AuthService>());
      expect(client.user, isA<UserService>());
      expect(client.organization, isA<OrganizationService>());
      expect(client.invitation, isA<InvitationService>());
    });

    test('stytchAuth should provide configuration details', () {
      // Arrange
      final client = stytchAuth(
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
