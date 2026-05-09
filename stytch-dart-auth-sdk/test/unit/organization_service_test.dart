library test_unit_organization_service_test;

import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() {
  group('OrganizationService', () {
    test(
      'getOrganization gets by ID and unwraps organization response',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = OrganizationService(httpClient);

        final organization = await service.getOrganization(
          'organization-test-123',
        );

        expect(
          httpClient.lastPath,
          equals('/b2b/organizations/organization-test-123'),
        );
        expect(organization.organizationId, equals('organization-test-123'));
        expect(organization.name, equals('Example Org'));
        expect(organization.slug, equals('example-org'));
        expect(organization.allowedDomains, equals(['example.com']));
        expect(organization.attributes, equals({'plan': 'enterprise'}));
        expect(organization.ssoMethods, equals(['saml']));
      },
    );

    test('updateOrganization sends current Stytch update payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = OrganizationService(httpClient);

      final response = await service.updateOrganization(
        'organization-test-123',
        const UpdateOrganizationRequest(
          name: 'Updated Org',
          slug: 'updated-org',
          allowedDomains: ['updated.example.com'],
          attributes: {'region': 'na'},
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/organizations/organization-test-123'),
      );
      expect(httpClient.lastBody, {
        'organization_name': 'Updated Org',
        'organization_slug': 'updated-org',
        'email_allowed_domains': ['updated.example.com'],
        'trusted_metadata': {'region': 'na'},
      });
      expect(response.organization.name, equals('Example Org'));
    });

    test(
      'searchOrganizations posts filter body and returns metadata',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = OrganizationService(httpClient);

        final response = await service.searchOrganizations(
          query: {
            'operator': 'OR',
            'operands': [
              {'filter_name': 'organization_name', 'filter_value': 'Example'},
            ],
          },
          limit: 10,
          cursor: 'cursor-1',
        );

        expect(httpClient.lastPath, equals('/b2b/organizations/search'));
        expect(httpClient.lastBody, {
          'query': {
            'operator': 'OR',
            'operands': [
              {'filter_name': 'organization_name', 'filter_value': 'Example'},
            ],
          },
          'limit': 10,
          'cursor': 'cursor-1',
        });
        expect(response.requestId, equals('request-123'));
        expect(
          response.organizations.single.organizationId,
          equals('org-search'),
        );
        expect(response.resultsMetadata.total, equals(1));
        expect(response.resultsMetadata.nextCursor, equals('cursor-2'));
        expect(response.statusCode, equals(200));
      },
    );

    test('deleteOrganization uses Stytch delete endpoint response', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = OrganizationService(httpClient);

      final response = await service.deleteOrganization(
        'organization-test-123',
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/organizations/organization-test-123'),
      );
      expect(response.requestId, equals('request-123'));
      expect(response.organizationId, equals('organization-test-123'));
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
  Future<Map<String, dynamic>> get(
    String path, [
    Map<String, String>? queryParameters,
  ]) async {
    lastPath = path;
    return {'request_id': 'request-123', 'organization': _organizationJson()};
  }

  @override
  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    lastPath = path;
    lastBody = body;
    return {'request_id': 'request-123', 'organization': _organizationJson()};
  }

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    lastPath = path;
    lastBody = body;
    return {
      'request_id': 'request-123',
      'organizations': [_organizationJson(organizationId: 'org-search')],
      'results_metadata': {'total': 1, 'next_cursor': 'cursor-2'},
      'status_code': 200,
    };
  }

  @override
  Future<Map<String, dynamic>> delete(String path) async {
    lastPath = path;
    return {
      'request_id': 'request-123',
      'organization_id': 'organization-test-123',
      'status_code': 200,
    };
  }
}

Map<String, dynamic> _organizationJson({
  String organizationId = 'organization-test-123',
}) {
  return {
    'organization_id': organizationId,
    'organization_name': 'Example Org',
    'organization_slug': 'example-org',
    'email_allowed_domains': ['example.com'],
    'trusted_metadata': {'plan': 'enterprise'},
    'sso_active_connections': [
      {
        'connection_id': 'conn-123',
        'display_name': 'SAML',
        'identity_provider': 'saml',
      },
    ],
    'created_at': '2024-01-01T00:00:00Z',
    'updated_at': '2024-01-02T00:00:00Z',
  };
}
