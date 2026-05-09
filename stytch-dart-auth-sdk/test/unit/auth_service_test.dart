library test_unit_auth_service_test;

import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() {
  group('AuthService', () {
    test(
      'getSession gets active member sessions with query parameters',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = AuthService(httpClient);

        final response = await service.getSession(
          GetSessionsRequest(
            organizationId: 'organization-test-123',
            memberId: 'member-123',
          ),
        );

        expect(httpClient.lastPath, equals('/b2b/sessions'));
        expect(httpClient.lastQueryParameters, {
          'organization_id': 'organization-test-123',
          'member_id': 'member-123',
        });
        expect(response.requestId, equals('request-123'));
        expect(
          response.memberSessions.single['member_session_id'],
          'session-1',
        );
        expect(response.statusCode, equals(200));
      },
    );

    test(
      'authenticateSession posts token payload and parses verdict',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = AuthService(httpClient);

        final response = await service.authenticateSession(
          AuthenticateSessionRequest(
            sessionToken: 'session-token',
            sessionDurationMinutes: 60,
            sessionCustomClaims: {'tier': 'gold'},
            authorizationCheck: {
              'organization_id': 'organization-test-123',
              'resource_id': 'project',
              'action': 'read',
            },
          ),
        );

        expect(httpClient.lastPath, equals('/b2b/sessions/authenticate'));
        expect(httpClient.lastBody, {
          'session_token': 'session-token',
          'session_duration_minutes': 60,
          'session_custom_claims': {'tier': 'gold'},
          'authorization_check': {
            'organization_id': 'organization-test-123',
            'resource_id': 'project',
            'action': 'read',
          },
        });
        expect(response.requestId, equals('request-123'));
        expect(response.memberSession['member_session_id'], 'session-test-123');
        expect(response.member['member_id'], 'member-123');
        expect(
          response.organization['organization_id'],
          'organization-test-123',
        );
        expect(response.sessionToken, equals('session-token'));
        expect(response.sessionJwt, equals('session-jwt'));
        expect(response.verdict?['authorized'], isTrue);
        expect(response.statusCode, equals(200));
      },
    );

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

    test('migrateSession posts current Stytch migrate payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.migrateSession(
        MigrateSessionRequest(
          sessionToken: 'external-session-token',
          organizationId: 'organization-test-123',
          sessionDurationMinutes: 60,
          sessionCustomClaims: {'source': 'legacy'},
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/sessions/migrate'));
      expect(httpClient.lastBody, {
        'session_token': 'external-session-token',
        'organization_id': 'organization-test-123',
        'session_duration_minutes': 60,
        'session_custom_claims': {'source': 'legacy'},
      });
      expect(response.requestId, equals('request-123'));
      expect(response.memberId, equals('member-123'));
      expect(response.sessionToken, equals('migrated-session-token'));
      expect(response.sessionJwt, equals('migrated-session-jwt'));
      expect(response.memberSession?['member_session_id'], 'session-test-123');
      expect(response.statusCode, equals(200));
    });

    test(
      'authenticateImpersonationToken posts current Stytch payload',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = AuthService(httpClient);

        final response = await service.authenticateImpersonationToken(
          AuthenticateImpersonationTokenRequest(
            impersonationToken: 'impersonation-token',
          ),
        );

        expect(httpClient.lastPath, equals('/b2b/impersonation/authenticate'));
        expect(httpClient.lastBody, {
          'impersonation_token': 'impersonation-token',
        });
        expect(response.memberId, equals('member-123'));
        expect(response.organizationId, equals('organization-test-123'));
        expect(response.memberAuthenticated, isTrue);
        expect(
          response.memberSession?['member_session_id'],
          'session-test-123',
        );
      },
    );

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

    test('sendLoginSignupEmail posts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.sendLoginSignupEmail(
        SendLoginSignupEmailRequest(
          organizationId: 'organization-test-123',
          emailAddress: 'member@example.com',
          loginRedirectUrl: 'https://example.com/login',
          signupRedirectUrl: 'https://example.com/signup',
          pkceCodeChallenge: 'challenge',
          loginTemplateId: 'login-template',
          signupTemplateId: 'signup-template',
          locale: 'en',
          loginExpirationMinutes: 60,
          signupExpirationMinutes: 60,
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/magic_links/email/login_or_signup'),
      );
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'email_address': 'member@example.com',
        'login_redirect_url': 'https://example.com/login',
        'signup_redirect_url': 'https://example.com/signup',
        'pkce_code_challenge': 'challenge',
        'login_template_id': 'login-template',
        'signup_template_id': 'signup-template',
        'locale': 'en',
        'login_expiration_minutes': 60,
        'signup_expiration_minutes': 60,
      });
      expect(response.memberId, equals('member-123'));
      expect(response.memberCreated, isTrue);
    });

    test('authenticateMagicLink posts token payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.authenticateMagicLink(
        AuthenticateMagicLinkRequest(
          magicLinksToken: 'magic-link-token',
          sessionDurationMinutes: 60,
          sessionCustomClaims: {'tier': 'gold'},
          pkceCodeVerifier: 'verifier',
          locale: 'en',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/magic_links/authenticate'));
      expect(httpClient.lastBody, {
        'magic_links_token': 'magic-link-token',
        'session_duration_minutes': 60,
        'session_custom_claims': {'tier': 'gold'},
        'pkce_code_verifier': 'verifier',
        'locale': 'en',
      });
      expect(response.memberAuthenticated, isTrue);
      expect(response.sessionToken, equals('session-token'));
    });

    test('authenticateDiscoveryMagicLink posts token payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.authenticateDiscoveryMagicLink(
        AuthenticateDiscoveryMagicLinkRequest(
          discoveryMagicLinksToken: 'discovery-token',
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/magic_links/discovery/authenticate'),
      );
      expect(httpClient.lastBody, {
        'discovery_magic_links_token': 'discovery-token',
      });
      expect(response.intermediateSessionToken, equals('intermediate-token'));
      expect(response.discoveredOrganizations, hasLength(1));
    });

    test('sendLoginSignupEmailOtp posts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.sendLoginSignupEmailOtp(
        SendLoginSignupEmailOtpRequest(
          organizationId: 'organization-test-123',
          emailAddress: 'member@example.com',
          loginTemplateId: 'login-template',
          signupTemplateId: 'signup-template',
          locale: 'en',
          loginExpirationMinutes: 10,
          signupExpirationMinutes: 10,
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/otps/email/login_or_signup'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'email_address': 'member@example.com',
        'login_template_id': 'login-template',
        'signup_template_id': 'signup-template',
        'locale': 'en',
        'login_expiration_minutes': 10,
        'signup_expiration_minutes': 10,
      });
      expect(response.memberId, equals('member-123'));
    });

    test('authenticateEmailOtp posts code payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.authenticateEmailOtp(
        AuthenticateEmailOtpRequest(
          organizationId: 'organization-test-123',
          emailAddress: 'member@example.com',
          code: '123456',
          sessionDurationMinutes: 60,
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/otps/email/authenticate'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'email_address': 'member@example.com',
        'code': '123456',
        'session_duration_minutes': 60,
      });
      expect(response.memberAuthenticated, isTrue);
    });

    test('sendDiscoveryEmailOtp posts discovery OTP payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.sendDiscoveryEmailOtp(
        SendDiscoveryEmailOtpRequest(
          emailAddress: 'prospect@example.com',
          loginTemplateId: 'login-template',
          locale: 'en',
          discoveryExpirationMinutes: 10,
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/otps/email/discovery/send'));
      expect(httpClient.lastBody, {
        'email_address': 'prospect@example.com',
        'login_template_id': 'login-template',
        'locale': 'en',
        'discovery_expiration_minutes': 10,
      });
      expect(response.statusCode, equals(200));
    });

    test(
      'authenticateDiscoveryEmailOtp posts discovery code payload',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = AuthService(httpClient);

        final response = await service.authenticateDiscoveryEmailOtp(
          AuthenticateDiscoveryEmailOtpRequest(
            emailAddress: 'prospect@example.com',
            code: '123456',
          ),
        );

        expect(
          httpClient.lastPath,
          equals('/b2b/otps/email/discovery/authenticate'),
        );
        expect(httpClient.lastBody, {
          'email_address': 'prospect@example.com',
          'code': '123456',
        });
        expect(response.emailAddress, equals('prospect@example.com'));
      },
    );

    test('oauth discovery start builds provider query parameters', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.oauthGoogleDiscoveryStart(
        OAuthDiscoveryStartRequest(
          publicToken: 'public-token',
          discoveryRedirectUrl: 'https://example.com/authenticate',
          customScopes: 'openid email profile',
          pkceCodeChallenge: 'challenge',
          providerParams: {'login_hint': 'member@example.com'},
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/public/oauth/google/discovery/start'),
      );
      expect(httpClient.lastQueryParameters, {
        'public_token': 'public-token',
        'discovery_redirect_url': 'https://example.com/authenticate',
        'custom_scopes': 'openid email profile',
        'pkce_code_challenge': 'challenge',
        'provider_login_hint': 'member@example.com',
      });
      expect(response.redirectUrl, startsWith('https://accounts.google.com'));
    });

    test('oauthMicrosoftDiscoveryStart uses Microsoft provider path', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      await service.oauthMicrosoftDiscoveryStart(
        OAuthDiscoveryStartRequest(publicToken: 'public-token'),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/public/oauth/microsoft/discovery/start'),
      );
    });

    test('getJWKS gets project JWKS', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.getJWKS();

      expect(httpClient.lastPath, equals('/sessions/jwks/project-test-123'));
      expect(response.keys.single['kid'], equals('key-1'));
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
  Map<String, String>? lastQueryParameters;

  @override
  Future<Map<String, dynamic>> get(
    String path, [
    Map<String, String>? queryParameters,
  ]) async {
    lastPath = path;
    lastQueryParameters = queryParameters;
    if (path == '/b2b/sessions') {
      return {
        'request_id': 'request-123',
        'member_sessions': [
          {'member_session_id': 'session-1', 'member_id': 'member-123'},
        ],
        'status_code': 200,
      };
    }
    if (path.contains('/oauth/google/')) {
      return {
        'request_id': 'request-123',
        'redirect_url': 'https://accounts.google.com/oauth',
        'status_code': 302,
      };
    }
    if (path.contains('/oauth/microsoft/')) {
      return {
        'request_id': 'request-123',
        'redirect_url': 'https://login.microsoftonline.com/oauth',
        'status_code': 302,
      };
    }
    if (path == '/sessions/jwks/project-test-123') {
      return {
        'request_id': 'request-123',
        'status_code': 200,
        'keys': [
          {'kid': 'key-1', 'kty': 'RSA', 'alg': 'RS256'},
        ],
      };
    }
    return {'request_id': 'request-123', 'status_code': 200};
  }

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    lastPath = path;
    lastBody = body;
    if (path == '/b2b/sessions/authenticate') {
      return {
        'request_id': 'request-123',
        'member_session': {'member_session_id': 'session-test-123'},
        'session_token': 'session-token',
        'session_jwt': 'session-jwt',
        'member': {
          'member_id': 'member-123',
          'email_address': 'member@example.com',
        },
        'organization': {'organization_id': 'organization-test-123'},
        'status_code': 200,
        'verdict': {
          'authorized': true,
          'granting_roles': ['admin'],
        },
      };
    }
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
    if (path == '/b2b/sessions/migrate') {
      return {
        'request_id': 'request-123',
        'member_id': 'member-123',
        'session_token': 'migrated-session-token',
        'session_jwt': 'migrated-session-jwt',
        'member': {
          'member_id': 'member-123',
          'email_address': 'member@example.com',
        },
        'organization': {'organization_id': 'organization-test-123'},
        'member_session': {'member_session_id': 'session-test-123'},
        'status_code': 200,
      };
    }
    if (path == '/b2b/impersonation/authenticate') {
      return {
        'request_id': 'request-123',
        'member_id': 'member-123',
        'organization_id': 'organization-test-123',
        'member': {
          'member_id': 'member-123',
          'email_address': 'member@example.com',
        },
        'session_token': 'session-token',
        'session_jwt': 'session-jwt',
        'organization': {'organization_id': 'organization-test-123'},
        'member_session': {'member_session_id': 'session-test-123'},
        'member_authenticated': true,
        'status_code': 200,
      };
    }
    if (path == '/b2b/magic_links/email/login_or_signup' ||
        path == '/b2b/otps/email/login_or_signup') {
      return {
        'request_id': 'request-123',
        'member_id': 'member-123',
        'member_created': true,
        'member': {
          'member_id': 'member-123',
          'email_address': 'member@example.com',
        },
        'status_code': 200,
      };
    }
    if (path == '/b2b/magic_links/authenticate' ||
        path == '/b2b/otps/email/authenticate') {
      return {
        'request_id': 'request-123',
        'member_id': 'member-123',
        'organization_id': 'organization-test-123',
        'method_id': 'email-test-123',
        'session_token': 'session-token',
        'session_jwt': 'session-jwt',
        'member_authenticated': true,
        'member': {
          'member_id': 'member-123',
          'email_address': 'member@example.com',
        },
        'organization': {'organization_id': 'organization-test-123'},
        'member_session': {'member_session_id': 'member-session-123'},
        'status_code': 200,
      };
    }
    if (path == '/b2b/magic_links/discovery/authenticate' ||
        path == '/b2b/otps/email/discovery/authenticate') {
      return {
        'request_id': 'request-123',
        'intermediate_session_token': 'intermediate-token',
        'email_address': body?['email_address'] ?? 'prospect@example.com',
        'discovered_organizations': [
          {
            'organization': {'organization_id': 'organization-test-123'},
            'membership': {'type': 'active_member'},
          },
        ],
        'status_code': 200,
      };
    }
    return {'request_id': 'request-123', 'status_code': 200};
  }
}
