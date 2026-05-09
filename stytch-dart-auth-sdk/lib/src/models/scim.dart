library scim_models;

/// Models for Stytch B2B SCIM APIs.

void _validateRequired(String value, String fieldName) {
  if (value.trim().isEmpty) {
    throw ArgumentError('$fieldName cannot be empty.');
  }
}

/// Request model for creating a SCIM connection.
class CreateScimConnectionRequest {
  /// Human-readable display name for the connection.
  final String displayName;

  /// Stytch identity provider hint.
  final String? identityProvider;

  /// CreateScimConnectionRequest
  CreateScimConnectionRequest({
    required this.displayName,
    this.identityProvider,
  }) {
    _validateRequired(displayName, 'Display name');
  }

  /// Converts the request to the Stytch API payload.
  Map<String, dynamic> toJson() {
    return {
      'display_name': displayName.trim(),
      if (identityProvider != null) 'identity_provider': identityProvider,
    };
  }
}

/// Request model for updating a SCIM connection.
class UpdateScimConnectionRequest {
  /// Human-readable display name for the connection.
  final String? displayName;

  /// Stytch identity provider hint.
  final String? identityProvider;

  /// SCIM group implicit role assignments.
  final List<Map<String, dynamic>>? scimGroupImplicitRoleAssignments;

  /// UpdateScimConnectionRequest
  const UpdateScimConnectionRequest({
    this.displayName,
    this.identityProvider,
    this.scimGroupImplicitRoleAssignments,
  });

  /// Converts the request to the Stytch API payload.
  Map<String, dynamic> toJson() {
    return {
      if (displayName != null) 'display_name': displayName,
      if (identityProvider != null) 'identity_provider': identityProvider,
      if (scimGroupImplicitRoleAssignments != null)
        'scim_group_implicit_role_assignments':
            scimGroupImplicitRoleAssignments,
    };
  }
}

/// Response model for SCIM connection create/update/get/rotation endpoints.
class ScimConnectionResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// SCIM connection payload returned by Stytch.
  final Map<String, dynamic> connection;

  /// ScimConnectionResponse
  const ScimConnectionResponse({
    required this.requestId,
    required this.statusCode,
    required this.connection,
  });

  /// fromJson
  factory ScimConnectionResponse.fromJson(Map<String, dynamic> json) {
    return ScimConnectionResponse(
      requestId: json['request_id'] as String,
      statusCode: json['status_code'] as int,
      connection: Map<String, dynamic>.from(json['connection'] as Map),
    );
  }
}

/// Response model for deleting a SCIM connection.
class DeleteScimConnectionResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Deleted connection ID.
  final String connectionId;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// DeleteScimConnectionResponse
  const DeleteScimConnectionResponse({
    required this.requestId,
    required this.connectionId,
    required this.statusCode,
  });

  /// fromJson
  factory DeleteScimConnectionResponse.fromJson(Map<String, dynamic> json) {
    return DeleteScimConnectionResponse(
      requestId: json['request_id'] as String,
      connectionId: json['connection_id'] as String,
      statusCode: json['status_code'] as int,
    );
  }
}

/// Response model for retrieving SCIM connection groups.
class GetScimConnectionGroupsResponse {
  /// SCIM groups returned by Stytch.
  final List<Map<String, dynamic>> scimGroups;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// Pagination cursor for the next page.
  final String? nextCursor;

  /// GetScimConnectionGroupsResponse
  const GetScimConnectionGroupsResponse({
    required this.scimGroups,
    required this.statusCode,
    this.nextCursor,
  });

  /// fromJson
  factory GetScimConnectionGroupsResponse.fromJson(Map<String, dynamic> json) {
    return GetScimConnectionGroupsResponse(
      scimGroups: (json['scim_groups'] as List<dynamic>? ?? <dynamic>[])
          .map((group) => Map<String, dynamic>.from(group as Map))
          .toList(),
      statusCode: json['status_code'] as int,
      nextCursor: json['next_cursor'] as String?,
    );
  }
}
