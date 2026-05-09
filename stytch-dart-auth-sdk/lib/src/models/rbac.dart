library rbac_models;

/// Models for Stytch B2B RBAC.

/// Response model for the active RBAC policy.
class RbacPolicyResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// RBAC policy document returned by Stytch.
  final Map<String, dynamic> policy;

  /// RbacPolicyResponse
  const RbacPolicyResponse({
    required this.requestId,
    required this.statusCode,
    required this.policy,
  });

  /// fromJson
  factory RbacPolicyResponse.fromJson(Map<String, dynamic> json) {
    return RbacPolicyResponse(
      requestId: json['request_id'] as String,
      statusCode: json['status_code'] as int,
      policy: json['policy'] as Map<String, dynamic>,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'status_code': statusCode,
      'policy': policy,
    };
  }
}
