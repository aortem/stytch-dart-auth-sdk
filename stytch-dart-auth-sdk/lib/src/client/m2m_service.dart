library m2m_service;

import '../models/m2m.dart';
import 'stytch_client.dart';

/// Machine-to-machine client service for the Stytch API.
class M2mService {
  /// HTTP client for making API requests.
  final StytchHttpClient _httpClient;

  /// M2mService
  M2mService(this._httpClient);

  /// Create an M2M client.
  Future<M2mClientResponse> createM2mClient(
    CreateM2mClientRequest request,
  ) async {
    final response = await _httpClient.post(
      '/m2m/clients',
      body: request.toJson(),
    );
    return M2mClientResponse.fromJson(response);
  }

  /// Get an M2M client.
  Future<M2mClientResponse> getM2mClient(String clientId) async {
    final response = await _httpClient.get('/m2m/clients/$clientId');
    return M2mClientResponse.fromJson(response);
  }

  /// Search M2M clients.
  Future<SearchM2mClientsResponse> searchM2mClients(
    SearchM2mClientsRequest request,
  ) async {
    final response = await _httpClient.post(
      '/m2m/clients/search',
      body: request.toJson(),
    );
    return SearchM2mClientsResponse.fromJson(response);
  }

  /// Update an M2M client.
  Future<M2mClientResponse> updateM2mClient(
    String clientId,
    UpdateM2mClientRequest request,
  ) async {
    final response = await _httpClient.put(
      '/m2m/clients/$clientId',
      body: request.toJson(),
    );
    return M2mClientResponse.fromJson(response);
  }

  /// Delete an M2M client.
  Future<DeleteM2mClientResponse> deleteM2mClient(String clientId) async {
    final response = await _httpClient.delete('/m2m/clients/$clientId');
    return DeleteM2mClientResponse.fromJson(response);
  }

  /// Start M2M client secret rotation.
  Future<M2mClientResponse> m2mRotateSecretStart(String clientId) async {
    final response = await _httpClient.post(
      '/m2m/clients/$clientId/secrets/rotate/start',
    );
    return M2mClientResponse.fromJson(response);
  }

  /// Complete M2M client secret rotation.
  Future<M2mClientResponse> m2mRotateSecret(String clientId) async {
    final response = await _httpClient.post(
      '/m2m/clients/$clientId/secrets/rotate',
    );
    return M2mClientResponse.fromJson(response);
  }

  /// Cancel M2M client secret rotation.
  Future<M2mClientResponse> m2mRotateSecretCancel(String clientId) async {
    final response = await _httpClient.post(
      '/m2m/clients/$clientId/secrets/rotate/cancel',
    );
    return M2mClientResponse.fromJson(response);
  }
}
