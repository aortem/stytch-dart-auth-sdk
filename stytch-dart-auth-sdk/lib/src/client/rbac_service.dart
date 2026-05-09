library rbac_service;

import '../models/rbac.dart';
import 'stytch_client.dart';

/// RBAC service for the Stytch B2B API.
class RbacService {
  /// HTTP client for making API requests.
  final StytchHttpClient _httpClient;

  /// RbacService
  RbacService(this._httpClient);

  /// Get the active RBAC policy for the current Stytch project.
  Future<RbacPolicyResponse> getRbacPolicy() async {
    final response = await _httpClient.get('/b2b/rbac/policy');
    return RbacPolicyResponse.fromJson(response);
  }
}
