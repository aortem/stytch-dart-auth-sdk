library test_unit_m2m_service_test;

import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() {
  group('M2mService', () {
    test('createM2mClient posts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = M2mService(httpClient);

      final response = await service.createM2mClient(
        CreateM2mClientRequest(
          scopes: ['read:users', 'write:users'],
          clientId: 'm2m-client-test-123',
          clientSecret: 'client-secret',
          clientName: 'Backend service',
          clientDescription: 'Service credentials',
          trustedMetadata: {'tier': 'internal'},
        ),
      );

      expect(httpClient.lastPath, equals('/m2m/clients'));
      expect(httpClient.lastBody, {
        'scopes': ['read:users', 'write:users'],
        'client_id': 'm2m-client-test-123',
        'client_secret': 'client-secret',
        'client_name': 'Backend service',
        'client_description': 'Service credentials',
        'trusted_metadata': {'tier': 'internal'},
      });
      expect(response.m2mClient['client_id'], equals('m2m-client-test-123'));
    });

    test('getM2mClient gets client by ID', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = M2mService(httpClient);

      await service.getM2mClient('m2m-client-test-123');

      expect(httpClient.lastPath, equals('/m2m/clients/m2m-client-test-123'));
    });

    test('searchM2mClients posts query payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = M2mService(httpClient);

      final response = await service.searchM2mClients(
        const SearchM2mClientsRequest(
          query: {
            'operator': 'AND',
            'operands': [
              {
                'filter_name': 'client_name',
                'filter_value': ['Backend service'],
              },
            ],
          },
          limit: 10,
          cursor: 'cursor-1',
        ),
      );

      expect(httpClient.lastPath, equals('/m2m/clients/search'));
      expect(httpClient.lastBody?['limit'], equals(10));
      expect(response.m2mClients.single['client_id'], 'm2m-client-test-123');
      expect(response.resultsMetadata?['next_cursor'], 'cursor-2');
    });

    test('updateM2mClient puts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = M2mService(httpClient);

      await service.updateM2mClient(
        'm2m-client-test-123',
        const UpdateM2mClientRequest(
          scopes: ['read:users'],
          clientName: 'Updated service',
          clientDescription: 'Updated description',
          trustedMetadata: {'tier': 'updated'},
        ),
      );

      expect(httpClient.lastPath, equals('/m2m/clients/m2m-client-test-123'));
      expect(httpClient.lastBody, {
        'scopes': ['read:users'],
        'client_name': 'Updated service',
        'client_description': 'Updated description',
        'trusted_metadata': {'tier': 'updated'},
      });
    });

    test('deleteM2mClient deletes client by ID', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = M2mService(httpClient);

      final response = await service.deleteM2mClient('m2m-client-test-123');

      expect(httpClient.lastPath, equals('/m2m/clients/m2m-client-test-123'));
      expect(response.clientId, equals('m2m-client-test-123'));
    });

    test('m2mRotateSecretStart posts start route', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = M2mService(httpClient);

      await service.m2mRotateSecretStart('m2m-client-test-123');

      expect(
        httpClient.lastPath,
        equals('/m2m/clients/m2m-client-test-123/secrets/rotate/start'),
      );
    });

    test('m2mRotateSecret posts completion route', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = M2mService(httpClient);

      await service.m2mRotateSecret('m2m-client-test-123');

      expect(
        httpClient.lastPath,
        equals('/m2m/clients/m2m-client-test-123/secrets/rotate'),
      );
    });

    test('m2mRotateSecretCancel posts cancel route', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = M2mService(httpClient);

      await service.m2mRotateSecretCancel('m2m-client-test-123');

      expect(
        httpClient.lastPath,
        equals('/m2m/clients/m2m-client-test-123/secrets/rotate/cancel'),
      );
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
    return _clientResponse();
  }

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    lastPath = path;
    lastBody = body;
    if (path == '/m2m/clients/search') {
      return {
        'request_id': 'request-123',
        'm2m_clients': [_clientJson()],
        'results_metadata': {'next_cursor': 'cursor-2'},
        'status_code': 200,
      };
    }
    return _clientResponse();
  }

  @override
  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    lastPath = path;
    lastBody = body;
    return _clientResponse();
  }

  @override
  Future<Map<String, dynamic>> delete(String path) async {
    lastPath = path;
    return {
      'request_id': 'request-123',
      'client_id': 'm2m-client-test-123',
      'status_code': 200,
    };
  }
}

Map<String, dynamic> _clientResponse() {
  return {
    'request_id': 'request-123',
    'm2m_client': _clientJson(),
    'status_code': 200,
  };
}

Map<String, dynamic> _clientJson() {
  return {
    'client_id': 'm2m-client-test-123',
    'client_secret': 'client-secret',
    'client_name': 'Backend service',
    'client_description': 'Service credentials',
    'status': 'active',
    'scopes': ['read:users'],
    'client_secret_last_four': 'cret',
    'trusted_metadata': {'tier': 'internal'},
    'next_client_secret_last_four': null,
  };
}
