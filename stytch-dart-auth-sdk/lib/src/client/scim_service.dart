library scim_service;

import '../models/scim.dart';
import 'stytch_client.dart';

/// SCIM service for the Stytch B2B API.
class ScimService {
  /// HTTP client for making API requests.
  final StytchHttpClient _httpClient;

  /// ScimService
  ScimService(this._httpClient);

  /// Create a SCIM connection for an organization.
  Future<ScimConnectionResponse> createScimConnection(
    String organizationId,
    CreateScimConnectionRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/scim/$organizationId/connection',
      body: request.toJson(),
    );
    return ScimConnectionResponse.fromJson(response);
  }

  /// Update a SCIM connection for an organization.
  Future<ScimConnectionResponse> updateScimConnection(
    String organizationId,
    String connectionId,
    UpdateScimConnectionRequest request,
  ) async {
    final response = await _httpClient.put(
      '/b2b/scim/$organizationId/connection/$connectionId',
      body: request.toJson(),
    );
    return ScimConnectionResponse.fromJson(response);
  }

  /// Delete a SCIM connection for an organization.
  Future<DeleteScimConnectionResponse> deleteScimConnection(
    String organizationId,
    String connectionId,
  ) async {
    final response = await _httpClient.delete(
      '/b2b/scim/$organizationId/connection/$connectionId',
    );
    return DeleteScimConnectionResponse.fromJson(response);
  }

  /// Start SCIM bearer token rotation.
  Future<ScimConnectionResponse> scimRotateTokenStart(
    String organizationId,
    String connectionId,
  ) async {
    final response = await _httpClient.post(
      '/b2b/scim/$organizationId/connection/$connectionId/rotate/start',
    );
    return ScimConnectionResponse.fromJson(response);
  }

  /// Complete SCIM bearer token rotation.
  Future<ScimConnectionResponse> scimRotateTokenComplete(
    String organizationId,
    String connectionId,
  ) async {
    final response = await _httpClient.post(
      '/b2b/scim/$organizationId/connection/$connectionId/rotate/complete',
    );
    return ScimConnectionResponse.fromJson(response);
  }

  /// Cancel SCIM bearer token rotation.
  Future<ScimConnectionResponse> scimRotateTokenCancel(
    String organizationId,
    String connectionId,
  ) async {
    final response = await _httpClient.post(
      '/b2b/scim/$organizationId/connection/$connectionId/rotate/cancel',
    );
    return ScimConnectionResponse.fromJson(response);
  }

  /// Retrieve SCIM groups for a connection.
  Future<GetScimConnectionGroupsResponse> getScimConnectionGroups(
    String organizationId,
    String connectionId, {
    int? limit,
    String? cursor,
  }) async {
    final response = await _httpClient
        .get('/b2b/scim/$organizationId/connection/$connectionId', {
          if (limit != null) 'limit': limit.toString(),
          if (cursor != null) 'cursor': cursor,
        });
    return GetScimConnectionGroupsResponse.fromJson(response);
  }
}
