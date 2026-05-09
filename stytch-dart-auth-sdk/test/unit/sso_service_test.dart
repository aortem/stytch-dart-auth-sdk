library test_unit_sso_service_test;

import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() {
  group('SsoService', () {
    test('createSamlConnection posts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = SsoService(httpClient);

      final response = await service.createSamlConnection(
        'organization-test-123',
        const CreateSamlConnectionRequest(
          displayName: 'Example SAML connection',
          identityProvider: 'okta',
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/sso/saml/organization-test-123'),
      );
      expect(httpClient.lastBody, {
        'display_name': 'Example SAML connection',
        'identity_provider': 'okta',
      });
      expect(
        response.connection['connection_id'],
        equals('saml-connection-123'),
      );
    });

    test('updateSamlConnection puts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = SsoService(httpClient);

      await service.updateSamlConnection(
        'organization-test-123',
        'saml-connection-123',
        const UpdateSamlConnectionRequest(
          idpEntityId: 'entity-id',
          displayName: 'Updated SAML',
          attributeMapping: {'email': 'email'},
          x509Certificate: '-----BEGIN CERTIFICATE-----',
          idpSsoUrl: 'https://idp.example.com/sso',
          samlConnectionImplicitRoleAssignments: [
            {'role_id': 'admin'},
          ],
          samlGroupImplicitRoleAssignments: [
            {'role_id': 'viewer', 'group': 'Employees'},
          ],
          alternativeAudienceUri: 'https://legacy.example.com/audience',
          identityProvider: 'okta',
          signingPrivateKey: '-----BEGIN RSA PRIVATE KEY-----',
          nameidFormat:
              'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
          alternativeAcsUrl: 'https://legacy.example.com/acs',
          idpInitiatedAuthDisabled: true,
          samlEncryptionPrivateKey: '-----BEGIN RSA PRIVATE KEY-----',
          allowGatewayCallback: true,
        ),
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/sso/saml/organization-test-123/connections/saml-connection-123',
        ),
      );
      expect(httpClient.lastBody?['idp_entity_id'], equals('entity-id'));
      expect(httpClient.lastBody?['display_name'], equals('Updated SAML'));
      expect(httpClient.lastBody?['attribute_mapping'], {'email': 'email'});
      expect(httpClient.lastBody?['x509_certificate'], isNotNull);
      expect(httpClient.lastBody?['idp_sso_url'], contains('idp.example.com'));
      expect(
        httpClient.lastBody?['saml_connection_implicit_role_assignments'],
        [
          {'role_id': 'admin'},
        ],
      );
      expect(httpClient.lastBody?['saml_group_implicit_role_assignments'], [
        {'role_id': 'viewer', 'group': 'Employees'},
      ]);
      expect(
        httpClient.lastBody?['alternative_audience_uri'],
        equals('https://legacy.example.com/audience'),
      );
      expect(httpClient.lastBody?['identity_provider'], equals('okta'));
      expect(httpClient.lastBody?['signing_private_key'], isNotNull);
      expect(httpClient.lastBody?['nameid_format'], contains('emailAddress'));
      expect(
        httpClient.lastBody?['alternative_acs_url'],
        equals('https://legacy.example.com/acs'),
      );
      expect(httpClient.lastBody?['idp_initiated_auth_disabled'], isTrue);
      expect(httpClient.lastBody?['saml_encryption_private_key'], isNotNull);
      expect(httpClient.lastBody?['allow_gateway_callback'], isTrue);
    });

    test('updateSamlConnectionUrl puts metadata URL payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = SsoService(httpClient);

      await service.updateSamlConnectionUrl(
        'organization-test-123',
        'saml-connection-123',
        UpdateSamlConnectionUrlRequest(
          metadataUrl: 'https://idp.example.com/metadata',
        ),
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/sso/saml/organization-test-123/connections/saml-connection-123/url',
        ),
      );
      expect(httpClient.lastBody, {
        'metadata_url': 'https://idp.example.com/metadata',
      });
    });

    test('deleteVerificationCertificate deletes current Stytch route', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = SsoService(httpClient);

      final response = await service.deleteVerificationCertificate(
        'organization-test-123',
        'saml-connection-123',
        'certificate-123',
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/sso/saml/organization-test-123/connections/saml-connection-123/verification_certificates/certificate-123',
        ),
      );
      expect(response.certificateId, equals('certificate-123'));
    });

    test('createOidcConnection posts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = SsoService(httpClient);

      await service.createOidcConnection(
        'organization-test-123',
        const CreateOidcConnectionRequest(
          displayName: 'Example OIDC connection',
          identityProvider: 'google-workspace',
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/sso/oidc/organization-test-123'),
      );
      expect(httpClient.lastBody, {
        'display_name': 'Example OIDC connection',
        'identity_provider': 'google-workspace',
      });
    });

    test('updateOidcConnection puts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = SsoService(httpClient);

      final response = await service.updateOidcConnection(
        'organization-test-123',
        'oidc-connection-123',
        const UpdateOidcConnectionRequest(
          displayName: 'Updated OIDC',
          clientId: 'client-id',
          clientSecret: 'client-secret',
          issuer: 'https://issuer.example.com',
          authorizationUrl: 'https://issuer.example.com/auth',
          tokenUrl: 'https://issuer.example.com/token',
          userinfoUrl: 'https://issuer.example.com/userinfo',
          jwksUrl: 'https://issuer.example.com/jwks',
          identityProvider: 'okta',
          customScopes: 'openid email profile',
          attributeMapping: {'email': 'email'},
        ),
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/sso/oidc/organization-test-123/connections/oidc-connection-123',
        ),
      );
      expect(httpClient.lastBody, {
        'display_name': 'Updated OIDC',
        'client_id': 'client-id',
        'client_secret': 'client-secret',
        'issuer': 'https://issuer.example.com',
        'authorization_url': 'https://issuer.example.com/auth',
        'token_url': 'https://issuer.example.com/token',
        'userinfo_url': 'https://issuer.example.com/userinfo',
        'jwks_url': 'https://issuer.example.com/jwks',
        'identity_provider': 'okta',
        'custom_scopes': 'openid email profile',
        'attribute_mapping': {'email': 'email'},
      });
      expect(response.warning, equals('metadata warning'));
    });

    test('getOidcAccessToken gets member OIDC provider registrations', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = SsoService(httpClient);

      final response = await service.getOidcAccessToken(
        'organization-test-123',
        'member-123',
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/organizations/organization-test-123/members/member-123/oidc_providers',
        ),
      );
      expect(response.registrations.single['access_token'], 'access-token');
    });

    test('createExternalConnection posts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = SsoService(httpClient);

      await service.createExternalConnection(
        'organization-test-123',
        CreateExternalConnectionRequest(
          externalOrganizationId: 'external-organization-123',
          externalConnectionId: 'saml-connection-123',
          displayName: 'External SSO',
          connectionImplicitRoleAssignments: [
            {'role_id': 'admin'},
          ],
          groupImplicitRoleAssignments: [
            {'role_id': 'viewer', 'group': 'Employees'},
          ],
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/sso/external/organization-test-123'),
      );
      expect(httpClient.lastBody, {
        'external_organization_id': 'external-organization-123',
        'external_connection_id': 'saml-connection-123',
        'display_name': 'External SSO',
        'connection_implicit_role_assignments': [
          {'role_id': 'admin'},
        ],
        'group_implicit_role_assignments': [
          {'role_id': 'viewer', 'group': 'Employees'},
        ],
      });
    });

    test('updateExternalConnection puts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = SsoService(httpClient);

      await service.updateExternalConnection(
        'organization-test-123',
        'external-connection-123',
        const UpdateExternalConnectionRequest(
          displayName: 'Updated External',
          externalConnectionImplicitRoleAssignments: [
            {'role_id': 'admin'},
          ],
          externalGroupImplicitRoleAssignments: [
            {'role_id': 'viewer', 'group': 'Employees'},
          ],
        ),
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/sso/external/organization-test-123/connections/external-connection-123',
        ),
      );
      expect(httpClient.lastBody, {
        'display_name': 'Updated External',
        'external_connection_implicit_role_assignments': [
          {'role_id': 'admin'},
        ],
        'external_group_implicit_role_assignments': [
          {'role_id': 'viewer', 'group': 'Employees'},
        ],
      });
    });

    test('getSsoConnections gets organization connections', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = SsoService(httpClient);

      final response = await service.getSsoConnections('organization-test-123');

      expect(httpClient.lastPath, equals('/b2b/sso/organization-test-123'));
      expect(response.samlConnections.single['connection_id'], 'saml-1');
      expect(response.oidcConnections.single['connection_id'], 'oidc-1');
      expect(
        response.externalConnections.single['connection_id'],
        'external-1',
      );
    });

    test('deleteSsoConnection deletes shared SSO connection route', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = SsoService(httpClient);

      final response = await service.deleteSsoConnection(
        'organization-test-123',
        'saml-connection-123',
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/sso/organization-test-123/connections/saml-connection-123',
        ),
      );
      expect(response.connectionId, equals('saml-connection-123'));
    });

    test(
      'ssoAuthenticateStart builds current Stytch query parameters',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = SsoService(httpClient);

        final response = await service.ssoAuthenticateStart(
          SsoAuthenticateStartRequest(
            publicToken: 'public-token',
            connectionId: 'saml-connection-123',
            pkceCodeChallenge: 'challenge',
            loginRedirectUrl: 'https://example.com/login',
            signupRedirectUrl: 'https://example.com/signup',
            customScopes: 'openid+email',
          ),
        );

        expect(httpClient.lastPath, equals('/public/sso/start'));
        expect(httpClient.lastQueryParameters, {
          'public_token': 'public-token',
          'connection_id': 'saml-connection-123',
          'pkce_code_challenge': 'challenge',
          'login_redirect_url': 'https://example.com/login',
          'signup_redirect_url': 'https://example.com/signup',
          'custom_scopes': 'openid+email',
        });
        expect(response.redirectUrl, equals('https://idp.example.com/sso'));
      },
    );

    test('ssoAuthenticate posts current Stytch completion payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = SsoService(httpClient);

      final response = await service.ssoAuthenticate(
        SsoAuthenticateRequest(
          ssoToken: 'sso-token',
          pkceCodeVerifier: 'verifier',
          sessionToken: 'session-token',
          sessionDurationMinutes: 60,
          sessionCustomClaims: {'tier': 'gold'},
          locale: 'en',
          intermediateSessionToken: 'intermediate-session-token',
          telemetryId: 'telemetry-123',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/sso/authenticate'));
      expect(httpClient.lastBody, {
        'sso_token': 'sso-token',
        'pkce_code_verifier': 'verifier',
        'session_token': 'session-token',
        'session_duration_minutes': 60,
        'session_custom_claims': {'tier': 'gold'},
        'locale': 'en',
        'intermediate_session_token': 'intermediate-session-token',
        'telemetry_id': 'telemetry-123',
      });
      expect(response.memberId, equals('member-123'));
      expect(response.organizationId, equals('organization-test-123'));
      expect(response.memberAuthenticated, isTrue);
      expect(response.memberSession?['member_session_id'], 'session-123');
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
    if (path == '/public/sso/start') {
      return {
        'request_id': 'request-123',
        'redirect_url': 'https://idp.example.com/sso',
        'status_code': 302,
      };
    }
    if (path.endsWith('/oidc_providers')) {
      return {
        'request_id': 'request-123',
        'registrations': [
          {
            'provider_subject': 'subject-123',
            'id_token': 'id-token',
            'access_token': 'access-token',
            'access_token_expires_in': 3600,
            'scopes': ['openid', 'email'],
            'connection_id': 'oidc-connection-123',
            'refresh_token': 'refresh-token',
          },
        ],
        'status_code': 200,
      };
    }
    if (path.startsWith('/b2b/sso/')) {
      return {
        'request_id': 'request-123',
        'saml_connections': [
          {'connection_id': 'saml-1'},
        ],
        'oidc_connections': [
          {'connection_id': 'oidc-1'},
        ],
        'external_connections': [
          {'connection_id': 'external-1'},
        ],
        'status_code': 200,
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
    if (path == '/b2b/sso/authenticate') {
      return {
        'request_id': 'request-123',
        'member_id': 'member-123',
        'organization_id': 'organization-test-123',
        'member': {'member_id': 'member-123'},
        'session_token': 'session-token',
        'session_jwt': 'session-jwt',
        'reset_session': false,
        'organization': {'organization_id': 'organization-test-123'},
        'intermediate_session_token': '',
        'member_authenticated': true,
        'status_code': 200,
        'member_session': {'member_session_id': 'session-123'},
      };
    }
    return _connectionResponse(path);
  }

  @override
  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    lastPath = path;
    lastBody = body;
    return _connectionResponse(path, warning: path.contains('/oidc/'));
  }

  @override
  Future<Map<String, dynamic>> delete(String path) async {
    lastPath = path;
    if (path.contains('/verification_certificates/')) {
      return {
        'request_id': 'request-123',
        'certificate_id': 'certificate-123',
        'status_code': 200,
      };
    }
    return {
      'request_id': 'request-123',
      'connection_id': 'saml-connection-123',
      'status_code': 200,
    };
  }
}

Map<String, dynamic> _connectionResponse(String path, {bool warning = false}) {
  final connectionId = path.contains('/oidc/')
      ? 'oidc-connection-123'
      : path.contains('/external/')
      ? 'external-connection-123'
      : 'saml-connection-123';
  return {
    'request_id': 'request-123',
    'status_code': 200,
    'connection': {
      'organization_id': 'organization-test-123',
      'connection_id': connectionId,
      'status': 'active',
      'display_name': 'Connection',
    },
    if (warning) 'warning': 'metadata warning',
  };
}
