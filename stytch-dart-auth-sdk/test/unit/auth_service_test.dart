library test_unit_auth_service_test;

import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() {
  group('AuthService', () {
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
    return {'request_id': 'request-123', 'status_code': 200};
  }
}
