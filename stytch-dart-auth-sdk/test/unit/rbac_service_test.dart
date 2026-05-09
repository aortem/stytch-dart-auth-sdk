library test_unit_rbac_service_test;

import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() {
  group('RbacService', () {
    test('getRbacPolicy gets the active project policy', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = RbacService(httpClient);

      final response = await service.getRbacPolicy();

      expect(httpClient.lastPath, equals('/b2b/rbac/policy'));
      expect(response.requestId, equals('request-123'));
      expect(response.statusCode, equals(200));
      expect(response.policy['roles'], isA<List<dynamic>>());
      expect(response.policy['resources'], isA<List<dynamic>>());
      expect(response.policy['scopes'], isA<List<dynamic>>());
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

  @override
  Future<Map<String, dynamic>> get(
    String path, [
    Map<String, String>? queryParameters,
  ]) async {
    lastPath = path;
    return {
      'request_id': 'request-123',
      'status_code': 200,
      'policy': {
        'roles': [
          {
            'role_id': 'stytch_admin',
            'description': 'Admin role',
            'permissions': [
              {
                'resource_id': 'stytch.organization',
                'actions': ['read', 'update'],
              },
            ],
          },
        ],
        'resources': [
          {
            'resource_id': 'stytch.organization',
            'description': 'Organization',
            'actions': ['read', 'update'],
          },
        ],
        'scopes': [
          {
            'scope': 'read:organization',
            'description': 'Read organization',
            'permissions': [
              {
                'resource_id': 'stytch.organization',
                'actions': ['read'],
              },
            ],
          },
        ],
      },
    };
  }
}
