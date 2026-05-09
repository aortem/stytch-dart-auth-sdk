library test_unit_auth_service_test;

import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() {
  group('AuthService', () {
    test('exchangeSession posts current Stytch exchange payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.exchangeSession(
        ExchangeSessionRequest(
          organizationId: 'organization-test-123',
          sessionToken: 'session-token',
          sessionDurationMinutes: 60,
          sessionCustomClaims: {'tier': 'gold'},
          locale: 'en',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/sessions/exchange'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'session_token': 'session-token',
        'session_duration_minutes': 60,
        'session_custom_claims': {'tier': 'gold'},
        'locale': 'en',
      });
      expect(response.requestId, equals('request-123'));
      expect(response.memberId, equals('member-123'));
      expect(response.sessionToken, equals('new-session-token'));
      expect(response.memberAuthenticated, isTrue);
      expect(response.statusCode, equals(200));
    });

    test('revokeSession posts to the Stytch revoke endpoint', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.revokeSession('session-test-123');

      expect(httpClient.lastPath, equals('/b2b/sessions/revoke'));
      expect(httpClient.lastBody, {'member_session_id': 'session-test-123'});
      expect(response.requestId, equals('request-123'));
      expect(response.statusCode, equals(200));
    });

    test('revokeSessionWithRequest supports token-based revocation', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      await service.revokeSessionWithRequest(
        RevokeSessionRequest(sessionToken: 'session-token'),
      );

      expect(httpClient.lastPath, equals('/b2b/sessions/revoke'));
      expect(httpClient.lastBody, {'session_token': 'session-token'});
    });

    test('sendDiscoveryEmail posts to the Stytch discovery endpoint', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.sendDiscoveryEmail(
        SendDiscoveryEmailRequest(
          emailAddress: 'prospect@example.com',
          discoveryRedirectUrl: 'https://example.com/discovery/callback',
          pkceCodeChallenge: 'challenge',
          loginTemplateId: 'template_123',
          locale: 'en',
          discoveryExpirationMinutes: 60,
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/magic_links/email/discovery/send'),
      );
      expect(httpClient.lastBody, {
        'email_address': 'prospect@example.com',
        'discovery_redirect_url': 'https://example.com/discovery/callback',
        'pkce_code_challenge': 'challenge',
        'login_template_id': 'template_123',
        'locale': 'en',
        'discovery_expiration_minutes': 60,
      });
      expect(response.requestId, equals('request-123'));
      expect(response.statusCode, equals(200));
    });
  });
}

class _RecordingStytchHttpClient extends StytchHttpClient {
  _RecordingStytchHttpClient()
    : super(
        StytchConfig(
          apiKey: 'test-secret',
          projectId: 'project-test-123',
          environment: 'sandbox',
        ),
      );

  String? lastPath;
  Map<String, dynamic>? lastBody;

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    lastPath = path;
    lastBody = body;
    if (path == '/b2b/sessions/exchange') {
      return {
        'request_id': 'request-123',
        'member_id': 'member-123',
        'session_token': 'new-session-token',
        'session_jwt': 'session-jwt',
        'member': {
          'member_id': 'member-123',
          'email_address': 'member@example.com',
        },
        'organization': {'organization_id': 'organization-test-123'},
        'member_authenticated': true,
        'member_session': {'member_session_id': 'session-test-123'},
        'status_code': 200,
      };
    }
    return {'request_id': 'request-123', 'status_code': 200};
  }
}
