library test_unit_scim_service_test;

import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() {
  group('ScimService', () {
    test('createScimConnection posts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = ScimService(httpClient);

      final response = await service.createScimConnection(
        'organization-test-123',
        CreateScimConnectionRequest(
          displayName: 'Okta SCIM',
          identityProvider: 'okta',
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/scim/organization-test-123/connection'),
      );
      expect(httpClient.lastBody, {
        'display_name': 'Okta SCIM',
        'identity_provider': 'okta',
      });
      expect(response.connection['connection_id'], 'scim-connection-123');
      expect(response.connection['bearer_token'], 'scim-token');
    });

    test('updateScimConnection puts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = ScimService(httpClient);

      final response = await service.updateScimConnection(
        'organization-test-123',
        'scim-connection-123',
        const UpdateScimConnectionRequest(
          displayName: 'Updated SCIM',
          identityProvider: 'microsoft-entra',
          scimGroupImplicitRoleAssignments: [
            {'group_id': 'group-123', 'role_id': 'role-123'},
          ],
        ),
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/scim/organization-test-123/connection/scim-connection-123',
        ),
      );
      expect(httpClient.lastBody, {
        'display_name': 'Updated SCIM',
        'identity_provider': 'microsoft-entra',
        'scim_group_implicit_role_assignments': [
          {'group_id': 'group-123', 'role_id': 'role-123'},
        ],
      });
      expect(
        response.connection['next_bearer_token_last_four'],
        equals('wxyz'),
      );
    });

    test('deleteScimConnection deletes current Stytch route', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = ScimService(httpClient);

      final response = await service.deleteScimConnection(
        'organization-test-123',
        'scim-connection-123',
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/scim/organization-test-123/connection/scim-connection-123',
        ),
      );
      expect(response.connectionId, 'scim-connection-123');
      expect(response.statusCode, 200);
    });

    test('scimRotateTokenStart posts current Stytch route', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = ScimService(httpClient);

      final response = await service.scimRotateTokenStart(
        'organization-test-123',
        'scim-connection-123',
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/scim/organization-test-123/connection/scim-connection-123/rotate/start',
        ),
      );
      expect(response.connection['next_bearer_token'], 'next-scim-token');
    });

    test('scimRotateTokenComplete posts current Stytch route', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = ScimService(httpClient);

      final response = await service.scimRotateTokenComplete(
        'organization-test-123',
        'scim-connection-123',
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/scim/organization-test-123/connection/scim-connection-123/rotate/complete',
        ),
      );
      expect(response.connection['bearer_token_last_four'], '1234');
    });

    test('scimRotateTokenCancel posts current Stytch route', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = ScimService(httpClient);

      final response = await service.scimRotateTokenCancel(
        'organization-test-123',
        'scim-connection-123',
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/scim/organization-test-123/connection/scim-connection-123/rotate/cancel',
        ),
      );
      expect(response.connection['connection_id'], 'scim-connection-123');
    });

    test('getScimConnectionGroups gets paginated groups', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = ScimService(httpClient);

      final response = await service.getScimConnectionGroups(
        'organization-test-123',
        'scim-connection-123',
        limit: 10,
        cursor: 'cursor-1',
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/scim/organization-test-123/connection/scim-connection-123',
        ),
      );
      expect(httpClient.lastQueryParameters, {
        'limit': '10',
        'cursor': 'cursor-1',
      });
      expect(response.scimGroups.single['group_id'], 'group-123');
      expect(response.nextCursor, 'cursor-2');
    });

    test('StytchAuth exposes the SCIM service', () {
      final auth = StytchAuth(
        apiKey: 'test-secret',
        projectId: 'project-test-123',
        environment: 'sandbox',
      );

      expect(auth.scim, isA<ScimService>());
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
    return {
      'scim_groups': [
        {
          'group_id': 'group-123',
          'group_name': 'Employees',
          'organization_id': 'organization-test-123',
          'connection_id': 'scim-connection-123',
        },
      ],
      'status_code': 200,
      'next_cursor': 'cursor-2',
    };
  }

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    lastPath = path;
    lastBody = body;
    return _connectionResponse(path);
  }

  @override
  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    lastPath = path;
    lastBody = body;
    return _connectionResponse(path);
  }

  @override
  Future<Map<String, dynamic>> delete(String path) async {
    lastPath = path;
    return {
      'request_id': 'request-123',
      'connection_id': 'scim-connection-123',
      'status_code': 200,
    };
  }
}

Map<String, dynamic> _connectionResponse(String path) {
  return {
    'request_id': 'request-123',
    'status_code': 200,
    'connection': {
      'organization_id': 'organization-test-123',
      'connection_id': 'scim-connection-123',
      'status': 'active',
      'display_name': 'SCIM connection',
      'identity_provider': 'okta',
      'base_url': 'https://api.stytch.com/v1/b2b/scim/base',
      if (path.endsWith('/connection')) 'bearer_token': 'scim-token',
      'bearer_token_last_four': '1234',
      'next_bearer_token': 'next-scim-token',
      'next_bearer_token_last_four': 'wxyz',
      'scim_group_implicit_role_assignments': [
        {
          'group_id': 'group-123',
          'group_name': 'Employees',
          'role_id': 'role-123',
        },
      ],
    },
  };
}
