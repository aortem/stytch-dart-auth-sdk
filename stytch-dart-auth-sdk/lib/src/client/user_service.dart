library user_service;
/// User management API service for stytch B2B
import '../models/user.dart';
import '../models/error.dart';
import 'stytch_client.dart';

/// User service for stytch B2B API
class UserService {
  /// StytchHttpClient
  final StytchHttpClient _httpClient;
  /// HTTP client for making API requests
  UserService(
    /// HTTP client instance
    this._httpClient,
  );
  /// Create a new user
  Future<CreateUserResponse> createUser(
    CreateUserRequest request,
  ) async {
  /// response
    final response = await _httpClient.post(
      '/b2b/users',
      body: request.toJson(),
    );

    return CreateUserResponse.fromJson(response);
  }

  /// Get user by ID
  Future<User> getUser(String userId) async {
  /// response
    final response = await _httpClient.get('/b2b/users/$userId');
    return User.fromJson(response);
  }

  /// Get current authenticated user
  Future<User> getCurrentUser() async {
  /// response
    final response = await _httpClient.get('/b2b/users/me');
    return User.fromJson(response);
  }

  /// Update user
  Future<UpdateUserResponse> updateUser(
  /// userId,
    String userId,
    UpdateUserRequest request,
  ) async {
  /// response
    final response = await _httpClient.put(
      '/b2b/users/$userId',
      body: request.toJson(),
    );

    return UpdateUserResponse.fromJson(response);
  }

  /// Delete user
  Future<void> deleteUser(String userId) async {
    await _httpClient.delete('/b2b/users/$userId');
  }

  /// List users with pagination
  Future<List<User>> listUsers({
  /// limit
    int limit = 100,
    String? cursor,
    String? organizationId,
  }) async {
  /// queryParams
    final queryParams = <String, String>{
      'limit': limit.toString(),
      if (cursor != null) 'cursor': cursor,
      if (organizationId != null) 'organization_id': organizationId,
    };

  /// response
    final response = await _httpClient.get('/b2b/users', queryParams);
  /// usersJson
    final usersJson = response['users'] as List<dynamic>;
    return usersJson
        .map((userJson) => User.fromJson(userJson as Map<String, dynamic>))
        .toList();
  }

  /// Search users
  Future<List<User>> searchUsers({
    required String query,
  /// limit
    int limit = 100,
    String? cursor,
  }) async {
  /// response
    final response = await _httpClient.post(
      '/b2b/users/search',
      body: {
        'query': query,
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
      },
    );

  /// usersJson
    final usersJson = response['users'] as List<dynamic>;
    return usersJson
        .map((userJson) => User.fromJson(userJson as Map<String, dynamic>))
        .toList();
  }

  /// Enable/disable MFA for user
  Future<UpdateUserResponse> setMfaEnabled(
  /// userId,
    String userId,
  /// enabled,
    bool enabled,
  ) async {
  /// response
    final response = await _httpClient.put(
      '/b2b/users/$userId',
      body: {'is_mfa_enabled': enabled},
    );

    return UpdateUserResponse.fromJson(response);
  }

  /// Get user organizations
  Future<List<String>> getUserOrganizations(String userId) async {
  /// response
    final response = await _httpClient.get('/b2b/users/$userId/organizations');
  /// orgIdsJson
    final orgIdsJson = response['organization_ids'] as List<dynamic>;
    return orgIdsJson.map((id) => id as String).toList();
  }

  /// Remove user from organization
  Future<void> removeFromOrganization(
  /// userId,
    String userId,
  /// organizationId,
    String organizationId,
  ) async {
    await _httpClient.delete('/b2b/users/$userId/organizations/$organizationId');
  }

  /// Delete user authentication factor
  Future<void> deleteAuthenticationFactor(
  /// userId,
    String userId,
  /// factorId,
    String factorId,
  ) async {
    await _httpClient.delete('/b2b/users/$userId/factors/$factorId');
  }
}