/// User management API service for stytch B2B
import '../models/user.dart';
import '../models/error.dart';
import 'stytch_client.dart';

/// User service for stytch B2B API
class UserService {
  final StytchHttpClient _httpClient;

  UserService(this._httpClient);

  /// Create a new user
  Future<CreateUserResponse> createUser(
    CreateUserRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/users',
      body: request.toJson(),
    );

    return CreateUserResponse.fromJson(response);
  }

  /// Get user by ID
  Future<User> getUser(String userId) async {
    final response = await _httpClient.get('/b2b/users/$userId');
    return User.fromJson(response);
  }

  /// Get current authenticated user
  Future<User> getCurrentUser() async {
    final response = await _httpClient.get('/b2b/users/me');
    return User.fromJson(response);
  }

  /// Update user
  Future<UpdateUserResponse> updateUser(
    String userId,
    UpdateUserRequest request,
  ) async {
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
    int limit = 100,
    String? cursor,
    String? organizationId,
  }) async {
    final queryParams = <String, String>{
      'limit': limit.toString(),
      if (cursor != null) 'cursor': cursor,
      if (organizationId != null) 'organization_id': organizationId,
    };

    final response = await _httpClient.get('/b2b/users', queryParams);
    final usersJson = response['users'] as List<dynamic>;
    return usersJson
        .map((userJson) => User.fromJson(userJson as Map<String, dynamic>))
        .toList();
  }

  /// Search users
  Future<List<User>> searchUsers({
    required String query,
    int limit = 100,
    String? cursor,
  }) async {
    final response = await _httpClient.post(
      '/b2b/users/search',
      body: {
        'query': query,
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
      },
    );

    final usersJson = response['users'] as List<dynamic>;
    return usersJson
        .map((userJson) => User.fromJson(userJson as Map<String, dynamic>))
        .toList();
  }

  /// Enable/disable MFA for user
  Future<UpdateUserResponse> setMfaEnabled(
    String userId,
    bool enabled,
  ) async {
    final response = await _httpClient.put(
      '/b2b/users/$userId',
      body: {'is_mfa_enabled': enabled},
    );

    return UpdateUserResponse.fromJson(response);
  }

  /// Get user organizations
  Future<List<String>> getUserOrganizations(String userId) async {
    final response = await _httpClient.get('/b2b/users/$userId/organizations');
    final orgIdsJson = response['organization_ids'] as List<dynamic>;
    return orgIdsJson.map((id) => id as String).toList();
  }

  /// Remove user from organization
  Future<void> removeFromOrganization(
    String userId,
    String organizationId,
  ) async {
    await _httpClient.delete('/b2b/users/$userId/organizations/$organizationId');
  }

  /// Delete user authentication factor
  Future<void> deleteAuthenticationFactor(
    String userId,
    String factorId,
  ) async {
    await _httpClient.delete('/b2b/users/$userId/factors/$factorId');
  }
}