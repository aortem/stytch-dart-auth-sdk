library organization_service;

/// Organization management API service for stytch B2B
import '../models/organization.dart';
import '../models/error.dart';
import 'stytch_client.dart';

/// Organization service for stytch B2B API
class OrganizationService {
  /// StytchHttpClient
  final StytchHttpClient _httpClient;

  /// HTTP client for making API requests
  OrganizationService(
    /// HTTP client instance
    this._httpClient,
  );

  /// Create a new organization
  Future<CreateOrganizationResponse> createOrganization(
    CreateOrganizationRequest request,
  ) async {
    /// response
    final response = await _httpClient.post(
      '/b2b/organizations',
      body: request.toJson(),
    );

    return CreateOrganizationResponse.fromJson(response);
  }

  /// Get organization by ID
  Future<Organization> getOrganization(String organizationId) async {
    /// response
    final response = await _httpClient.get(
      '/b2b/organizations/$organizationId',
    );
    return Organization.fromJson(
      response['organization'] as Map<String, dynamic>,
    );
  }

  /// Get organization by slug
  Future<Organization> getOrganizationBySlug(String slug) async {
    /// response
    final response = await _httpClient.get('/b2b/organizations/slug/$slug');
    return Organization.fromJson(
      response['organization'] as Map<String, dynamic>,
    );
  }

  /// Update organization
  Future<UpdateOrganizationResponse> updateOrganization(
    /// organizationId,
    String organizationId,
    UpdateOrganizationRequest request,
  ) async {
    /// response
    final response = await _httpClient.put(
      '/b2b/organizations/$organizationId',
      body: request.toJson(),
    );

    return UpdateOrganizationResponse.fromJson(response);
  }

  /// Delete organization
  Future<DeleteOrganizationResponse> deleteOrganization(
    String organizationId,
  ) async {
    final response = await _httpClient.delete(
      '/b2b/organizations/$organizationId',
    );
    return DeleteOrganizationResponse.fromJson(response);
  }

  /// List organizations with pagination
  Future<List<Organization>> listOrganizations({
    /// limit
    int limit = 100,
    String? cursor,
  }) async {
    /// queryParams
    final queryParams = <String, String>{
      'limit': limit.toString(),
      if (cursor != null) 'cursor': cursor,
    };

    /// response
    final response = await _httpClient.get('/b2b/organizations', queryParams);

    /// orgsJson
    final orgsJson = response['organizations'] as List<dynamic>;
    return orgsJson
        .map(
          (orgJson) => Organization.fromJson(orgJson as Map<String, dynamic>),
        )
        .toList();
  }

  /// Search organizations
  Future<SearchOrganizationsResponse> searchOrganizations({
    Map<String, dynamic>? query,

    /// limit
    int limit = 100,
    String? cursor,
  }) async {
    /// response
    final response = await _httpClient.post(
      '/b2b/organizations/search',
      body: {
        if (query != null) 'query': query,
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
      },
    );

    return SearchOrganizationsResponse.fromJson(response);
  }

  /// Get organization members
  Future<List<String>> getOrganizationMembers(
    /// organizationId,
    String organizationId, {

    /// limit
    int limit = 100,
    String? cursor,
  }) async {
    /// queryParams
    final queryParams = <String, String>{
      'limit': limit.toString(),
      if (cursor != null) 'cursor': cursor,
    };

    /// response
    final response = await _httpClient.get(
      '/b2b/organizations/$organizationId/members',
      queryParams,
    );

    /// membersJson
    final membersJson = response['member_ids'] as List<dynamic>;
    return membersJson.map((id) => id as String).toList();
  }

  /// Add user to organization
  Future<void> addUserToOrganization(
    /// organizationId,
    String organizationId,

    /// userId,
    String userId,

    /// dynamic>?
    Map<String, dynamic>? attributes,
  ) async {
    /// body
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
    /// organizationId,
    String organizationId,

    /// userId,
    String userId,
  ) async {
    await _httpClient.delete(
      '/b2b/organizations/$organizationId/members/$userId',
    );
  }

  /// Update organization member
  Future<void> updateOrganizationMember(
    /// organizationId,
    String organizationId,

    /// userId,
    String userId,

    /// dynamic>?
    Map<String, dynamic>? attributes,
  ) async {
    /// body
    final body = <String, dynamic>{};
    if (attributes != null) body['attributes'] = attributes;

    await _httpClient.put(
      '/b2b/organizations/$organizationId/members/$userId',
      body: body.isEmpty ? null : body,
    );
  }
}
