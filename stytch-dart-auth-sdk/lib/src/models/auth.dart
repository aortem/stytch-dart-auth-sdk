library auth_models;

/// Models for authentication in stytch B2B API

/// Request model for email password login
class EmailPasswordLoginRequest {
  /// String
  final String email;
  /// String
  final String password;
  /// String?
  final String? organizationId;
  /// Map<String,
  final Map<String, dynamic>? attributes;

  /// EmailPasswordLoginRequest(
  const EmailPasswordLoginRequest({
    required this.email,
    required this.password,
    this.organizationId,
    this.attributes,
  });

  /// fromJson
  factory EmailPasswordLoginRequest.fromJson(Map<String, dynamic> json) {
    return EmailPasswordLoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      organizationId: json['organization_id'] as String?,
      attributes: json['attributes'] as Map<String, dynamic>?,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      if (organizationId != null) 'organization_id': organizationId,
      if (attributes != null) 'attributes': attributes,
    };
  }
}

/// Request model for SSO login
class SsoLoginRequest {
  /// String
  final String ssoToken;
  /// String?
  final String? organizationId;
  /// Map<String,
  final Map<String, dynamic>? attributes;

  /// SsoLoginRequest(
  const SsoLoginRequest({
    required this.ssoToken,
    this.organizationId,
    this.attributes,
  });

  /// fromJson
  factory SsoLoginRequest.fromJson(Map<String, dynamic> json) {
    return SsoLoginRequest(
      ssoToken: json['sso_token'] as String,
      organizationId: json['organization_id'] as String?,
      attributes: json['attributes'] as Map<String, dynamic>?,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'sso_token': ssoToken,
      if (organizationId != null) 'organization_id': organizationId,
      if (attributes != null) 'attributes': attributes,
    };
  }
}

/// Response model for authentication
class AuthResponse {
  /// String
  final String userId;
  /// String
  final String email;
  /// String?
  final String? name;
  /// bool
  final bool isMfaEnabled;
  /// List<String>
  final List<String> organizationIds;
  /// String
  final String sessionId;
  /// String
  final String sessionToken;
  /// DateTime
  final DateTime sessionExpiresAt;
  /// Map<String,
  final Map<String, dynamic>? userAttributes;
  /// DateTime
  final DateTime createdAt;

  /// AuthResponse(
  const AuthResponse({
    required this.userId,
    required this.email,
    this.name,
    required this.isMfaEnabled,
    required this.organizationIds,
    required this.sessionId,
    required this.sessionToken,
    required this.sessionExpiresAt,
    this.userAttributes,
    required this.createdAt,
  });

  /// fromJson
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      userId: json['user_id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      isMfaEnabled: json['is_mfa_enabled'] as bool,
      organizationIds: (json['organization_ids'] as List<dynamic>)
          .map((id) => id as String)
          .toList(),
      sessionId: json['session_id'] as String,
      sessionToken: json['session_token'] as String,
      sessionExpiresAt: DateTime.parse(json['session_expires_at'] as String),
      userAttributes: json['user_attributes'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      if (name != null) 'name': name,
      'is_mfa_enabled': isMfaEnabled,
      'organization_ids': organizationIds,
      'session_id': sessionId,
      'session_token': sessionToken,
      'session_expires_at': sessionExpiresAt.toIso8601String(),
      if (userAttributes != null) 'user_attributes': userAttributes,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

/// Request model for MFA
class MfaRequest {
  /// String
  final String mfaToken;
  /// String
  final String method;
  /// Map<String,
  final Map<String, dynamic>? attributes;

  /// MfaRequest(
  const MfaRequest({
    required this.mfaToken,
    required this.method,
    this.attributes,
  });

  /// fromJson
  factory MfaRequest.fromJson(Map<String, dynamic> json) {
    return MfaRequest(
      mfaToken: json['mfa_token'] as String,
      method: json['method'] as String,
      attributes: json['attributes'] as Map<String, dynamic>?,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'mfa_token': mfaToken,
      'method': method,
      if (attributes != null) 'attributes': attributes,
    };
  }
}

/// Response model for MFA
class MfaResponse {
  /// String
  final String mfaToken;
  /// List<String>
  final List<String> availableMethods;

  /// MfaResponse(
  const MfaResponse({
    required this.mfaToken,
    required this.availableMethods,
  });

  /// fromJson
  factory MfaResponse.fromJson(Map<String, dynamic> json) {
    return MfaResponse(
      mfaToken: json['mfa_token'] as String,
      availableMethods: (json['available_methods'] as List<dynamic>)
          .map((method) => method as String)
          .toList(),
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'mfa_token': mfaToken,
      'available_methods': availableMethods,
    };
  }
}

/// Request model for session creation
class CreateSessionRequest {
  /// String
  final String userId;
  /// Map<String,
  final Map<String, dynamic>? attributes;
  /// DateTime?
  final DateTime? expiresAt;
  /// List<String>?
  final List<String>? organizationIds;

  /// CreateSessionRequest(
  const CreateSessionRequest({
    required this.userId,
    this.attributes,
    this.expiresAt,
    this.organizationIds,
  });

  /// fromJson
  factory CreateSessionRequest.fromJson(Map<String, dynamic> json) {
    return CreateSessionRequest(
      userId: json['user_id'] as String,
      attributes: json['attributes'] as Map<String, dynamic>?,
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'] as String)
          : null,
      organizationIds: json['organization_ids'] != null
          ? (json['organization_ids'] as List<dynamic>)
              .map((id) => id as String)
              .toList()
          : null,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      if (attributes != null) 'attributes': attributes,
      if (expiresAt != null) 'expires_at': expiresAt!.toIso8601String(),
      if (organizationIds != null) 'organization_ids': organizationIds,
    };
  }
}

/// Response model for session creation
class CreateSessionResponse {
  /// String
  final String sessionId;
  /// String
  final String sessionToken;
  /// DateTime
  final DateTime sessionExpiresAt;
  /// List<String>
  final List<String> organizationIds;

  /// CreateSessionResponse(
  const CreateSessionResponse({
    required this.sessionId,
    required this.sessionToken,
    required this.sessionExpiresAt,
    required this.organizationIds,
  });

  /// fromJson
  factory CreateSessionResponse.fromJson(Map<String, dynamic> json) {
    return CreateSessionResponse(
      sessionId: json['session_id'] as String,
      sessionToken: json['session_token'] as String,
      sessionExpiresAt: DateTime.parse(json['session_expires_at'] as String),
      organizationIds: (json['organization_ids'] as List<dynamic>)
          .map((id) => id as String)
          .toList(),
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'session_token': sessionToken,
      'session_expires_at': sessionExpiresAt.toIso8601String(),
      'organization_ids': organizationIds,
    };
  }
}

/// Request model for session validation
class ValidateSessionRequest {
  /// String
  final String sessionToken;
  /// String?
  final String? organizationId;

  /// ValidateSessionRequest(
  const ValidateSessionRequest({
    required this.sessionToken,
    this.organizationId,
  });

  /// fromJson
  factory ValidateSessionRequest.fromJson(Map<String, dynamic> json) {
    return ValidateSessionRequest(
      sessionToken: json['session_token'] as String,
      organizationId: json['organization_id'] as String?,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'session_token': sessionToken,
      if (organizationId != null) 'organization_id': organizationId,
    };
  }
}

/// Response model for session validation
class ValidateSessionResponse {
  /// bool
  final bool valid;
  /// String?
  final String? userId;
  /// String?
  final String? email;
  /// String?
  final String? organizationId;
  /// DateTime?
  final DateTime? sessionExpiresAt;
  /// Map<String,
  final Map<String, dynamic>? userAttributes;

  /// ValidateSessionResponse(
  const ValidateSessionResponse({
    required this.valid,
    this.userId,
    this.email,
    this.organizationId,
    this.sessionExpiresAt,
    this.userAttributes,
  });

  /// fromJson
  factory ValidateSessionResponse.fromJson(Map<String, dynamic> json) {
    return ValidateSessionResponse(
      valid: json['valid'] as bool,
      userId: json['user_id'] as String?,
      email: json['email'] as String?,
      organizationId: json['organization_id'] as String?,
      sessionExpiresAt: json['session_expires_at'] != null
          ? DateTime.parse(json['session_expires_at'] as String)
          : null,
      userAttributes: json['user_attributes'] as Map<String, dynamic>?,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'valid': valid,
      if (userId != null) 'user_id': userId,
      if (email != null) 'email': email,
      if (organizationId != null) 'organization_id': organizationId,
      if (sessionExpiresAt != null)
        'session_expires_at': sessionExpiresAt!.toIso8601String(),
      if (userAttributes != null) 'user_attributes': userAttributes,
    };
  }
}