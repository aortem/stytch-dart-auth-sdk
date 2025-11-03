/// Organization management API service for stytch B2B
import '../models/organization.dart';
import '../models/error.dart';
import 'stytch_client.dart';

/// Organization service for stytch B2B API
class OrganizationService {
  final StytchHttpClient _httpClient;

  OrganizationService(this._httpClient);

  /// Create a new organization
  Future<CreateOrganizationResponse> createOrganization(
    CreateOrganizationRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/organizations',
      body: request.toJson(),
    );

    return CreateOrganizationResponse.fromJson(response);
  }

  /// Get organization by ID
  Future<Organization> getOrganization(String organizationId) async {
    final response = await _httpClient.get('/b2b/organizations/$organizationId');
    return Organization.fromJson(response);
  }

  /// Get organization by slug
  Future<Organization> getOrganizationBySlug(String slug) async {
    final response = await _httpClient.get('/b2b/organizations/slug/$slug');
    return Organization.fromJson(response);
  }

  /// Update organization
  Future<UpdateOrganizationResponse> updateOrganization(
    String organizationId,
    UpdateOrganizationRequest request,
  ) async {
    final response = await _httpClient.put(
      '/b2b/organizations/$organizationId',
      body: request.toJson(),
    );

    return UpdateOrganizationResponse.fromJson(response);
  }

  /// Delete organization
  Future<void> deleteOrganization(String organizationId) async {
    await _httpClient.delete('/b2b/organizations/$organizationId');
  }

  /// List organizations with pagination
  Future<List<Organization>> listOrganizations({
    int limit = 100,
    String? cursor,
  }) async {
    final queryParams = <String, String>{
      'limit': limit.toString(),
      if (cursor != null) 'cursor': cursor,
    };

    final response = await _httpClient.get('/b2b/organizations', queryParams);
    final orgsJson = response['organizations'] as List<dynamic>;
    return orgsJson
        .map((orgJson) => Organization.fromJson(orgJson as Map<String, dynamic>))
        .toList();
  }

  /// Search organizations
  Future<List<Organization>> searchOrganizations({
    required String query,
    int limit = 100,
    String? cursor,
  }) async {
    final response = await _httpClient.post(
      '/b2b/organizations/search',
      body: {
        'query': query,
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
      },
    );

    final orgsJson = response['organizations'] as List<dynamic>;
    return orgsJson
        .map((orgJson) => Organization.fromJson(orgJson as Map<String, dynamic>))
        .toList();
  }

  /// Get organization members
  Future<List<String>> getOrganizationMembers(
    String organizationId, {
    int limit = 100,
    String? cursor,
  }) async {
    final queryParams = <String, String>{
      'limit': limit.toString(),
      if (cursor != null) 'cursor': cursor,
    };

    final response = await _httpClient.get(
      '/b2b/organizations/$organizationId/members',
      queryParams,
    );

    final membersJson = response['member_ids'] as List<dynamic>;
    return membersJson.map((id) => id as String).toList();
  }

  /// Add user to organization
  Future<void> addUserToOrganization(
    String organizationId,
    String userId,
    Map<String, dynamic>? attributes,
  ) async {
    final body = <String, dynamic>{
      'user_id': userId,
      if (attributes != null) 'attributes': attributes,
    };

    await _httpClient.post(
      '/b2b/organizations/$organizationId/members',
      body: body,
    );
  }

  /// Remove user from organization
  Future<void> removeUserFromOrganization(
    String organizationId,
    String userId,
  ) async {
    await _httpClient.delete(
      '/b2b/organizations/$organizationId/members/$userId',
    );
  }

  /// Update organization member
  Future<void> updateOrganizationMember(
    String organizationId,
    String userId,
    Map<String, dynamic>? attributes,
  ) async {
    final body = <String, dynamic>{};
    if (attributes != null) body['attributes'] = attributes;

    await _httpClient.put(
      '/b2b/organizations/$organizationId/members/$userId',
      body: body.isEmpty ? null : body,
    );
  }
}