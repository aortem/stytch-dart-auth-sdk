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

  /// Converts the request to the Stytch API payload.
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

  /// Converts the response to JSON.
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

  /// `List<String>`
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

  /// `List<String>`
  final List<String> availableMethods;

  /// MfaResponse(
  const MfaResponse({required this.mfaToken, required this.availableMethods});

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
    return {'mfa_token': mfaToken, 'available_methods': availableMethods};
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

  /// `List<String>?`
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

  /// `List<String>`
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

/// Request model for exchanging a session into another organization.
class ExchangeSessionRequest {
  /// Organization to exchange the session into.
  final String organizationId;

  /// Stytch session token for the current member session.
  final String? sessionToken;

  /// Stytch session JWT for the current member session.
  final String? sessionJwt;

  /// Requested session duration in minutes.
  final int? sessionDurationMinutes;

  /// Custom claims for the resulting session.
  final Map<String, dynamic>? sessionCustomClaims;

  /// Optional locale for the exchange flow.
  final String? locale;

  /// ExchangeSessionRequest
  ExchangeSessionRequest({
    required this.organizationId,
    this.sessionToken,
    this.sessionJwt,
    this.sessionDurationMinutes,
    this.sessionCustomClaims,
    this.locale,
  }) {
    if (organizationId.trim().isEmpty) {
      throw ArgumentError('Organization ID cannot be empty.');
    }
    if ((sessionToken == null || sessionToken!.trim().isEmpty) &&
        (sessionJwt == null || sessionJwt!.trim().isEmpty)) {
      throw ArgumentError('A session token or session JWT is required.');
    }
  }

  /// fromJson
  factory ExchangeSessionRequest.fromJson(Map<String, dynamic> json) {
    return ExchangeSessionRequest(
      organizationId: json['organization_id'] as String,
      sessionToken: json['session_token'] as String?,
      sessionJwt: json['session_jwt'] as String?,
      sessionDurationMinutes: json['session_duration_minutes'] as int?,
      sessionCustomClaims:
          json['session_custom_claims'] as Map<String, dynamic>?,
      locale: json['locale'] as String?,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'organization_id': organizationId.trim(),
      if (sessionToken != null) 'session_token': sessionToken!.trim(),
      if (sessionJwt != null) 'session_jwt': sessionJwt!.trim(),
      if (sessionDurationMinutes != null)
        'session_duration_minutes': sessionDurationMinutes,
      if (sessionCustomClaims != null)
        'session_custom_claims': sessionCustomClaims,
      if (locale != null) 'locale': locale,
    };
  }
}

/// Response model for exchanging a session.
class ExchangeSessionResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Member ID returned by Stytch.
  final String? memberId;

  /// Full session token when authentication requirements are satisfied.
  final String? sessionToken;

  /// Session JWT when authentication requirements are satisfied.
  final String? sessionJwt;

  /// Member payload returned by Stytch.
  final Map<String, dynamic>? member;

  /// Organization payload returned by Stytch.
  final Map<String, dynamic>? organization;

  /// Whether the member is fully authenticated into the target organization.
  final bool memberAuthenticated;

  /// Intermediate token returned when more authentication is required.
  final String? intermediateSessionToken;

  /// Member session payload returned by Stytch.
  final Map<String, dynamic>? memberSession;

  /// MFA requirement payload returned by Stytch.
  final Map<String, dynamic>? mfaRequired;

  /// Primary auth requirement payload returned by Stytch.
  final Map<String, dynamic>? primaryRequired;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// ExchangeSessionResponse
  const ExchangeSessionResponse({
    required this.requestId,
    this.memberId,
    this.sessionToken,
    this.sessionJwt,
    this.member,
    this.organization,
    required this.memberAuthenticated,
    this.intermediateSessionToken,
    this.memberSession,
    this.mfaRequired,
    this.primaryRequired,
    required this.statusCode,
  });

  /// fromJson
  factory ExchangeSessionResponse.fromJson(Map<String, dynamic> json) {
    return ExchangeSessionResponse(
      requestId: json['request_id'] as String,
      memberId: json['member_id'] as String?,
      sessionToken: json['session_token'] as String?,
      sessionJwt: json['session_jwt'] as String?,
      member: json['member'] as Map<String, dynamic>?,
      organization: json['organization'] as Map<String, dynamic>?,
      memberAuthenticated: json['member_authenticated'] as bool? ?? false,
      intermediateSessionToken: json['intermediate_session_token'] as String?,
      memberSession: json['member_session'] as Map<String, dynamic>?,
      mfaRequired: json['mfa_required'] as Map<String, dynamic>?,
      primaryRequired: json['primary_required'] as Map<String, dynamic>?,
      statusCode: json['status_code'] as int,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      if (memberId != null) 'member_id': memberId,
      if (sessionToken != null) 'session_token': sessionToken,
      if (sessionJwt != null) 'session_jwt': sessionJwt,
      if (member != null) 'member': member,
      if (organization != null) 'organization': organization,
      'member_authenticated': memberAuthenticated,
      if (intermediateSessionToken != null)
        'intermediate_session_token': intermediateSessionToken,
      if (memberSession != null) 'member_session': memberSession,
      if (mfaRequired != null) 'mfa_required': mfaRequired,
      if (primaryRequired != null) 'primary_required': primaryRequired,
      'status_code': statusCode,
    };
  }
}

/// Request model for revoking a session.
class RevokeSessionRequest {
  /// Member session ID to revoke.
  final String? memberSessionId;

  /// Session token to revoke.
  final String? sessionToken;

  /// Session JWT to revoke.
  final String? sessionJwt;

  /// Member ID whose sessions should all be revoked.
  final String? memberId;

  /// RevokeSessionRequest
  RevokeSessionRequest({
    this.memberSessionId,
    this.sessionToken,
    this.sessionJwt,
    this.memberId,
  }) {
    final hasIdentifier = [
      memberSessionId,
      sessionToken,
      sessionJwt,
      memberId,
    ].any((value) => value != null && value.trim().isNotEmpty);
    if (!hasIdentifier) {
      throw ArgumentError('A session or member identifier is required.');
    }
  }

  /// fromJson
  factory RevokeSessionRequest.fromJson(Map<String, dynamic> json) {
    return RevokeSessionRequest(
      memberSessionId: json['member_session_id'] as String?,
      sessionToken: json['session_token'] as String?,
      sessionJwt: json['session_jwt'] as String?,
      memberId: json['member_id'] as String?,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      if (memberSessionId != null) 'member_session_id': memberSessionId!.trim(),
      if (sessionToken != null) 'session_token': sessionToken!.trim(),
      if (sessionJwt != null) 'session_jwt': sessionJwt!.trim(),
      if (memberId != null) 'member_id': memberId!.trim(),
    };
  }
}

/// Response model for revoking a session.
class RevokeSessionResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// RevokeSessionResponse
  const RevokeSessionResponse({
    required this.requestId,
    required this.statusCode,
  });

  /// fromJson
  factory RevokeSessionResponse.fromJson(Map<String, dynamic> json) {
    return RevokeSessionResponse(
      requestId: json['request_id'] as String,
      statusCode: json['status_code'] as int,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {'request_id': requestId, 'status_code': statusCode};
  }
}

/// Request model for sending a discovery Email Magic Link.
class SendDiscoveryEmailRequest {
  /// Email address of the member starting discovery.
  final String emailAddress;

  /// Redirect URL used after the discovery magic link is clicked.
  final String? discoveryRedirectUrl;

  /// PKCE code challenge for same-device validation.
  final String? pkceCodeChallenge;

  /// Optional custom email template ID.
  final String? loginTemplateId;

  /// Optional IETF BCP 47 locale such as `en`, `es`, `fr`, or `pt-br`.
  final String? locale;

  /// Discovery magic-link expiration in minutes.
  final int? discoveryExpirationMinutes;

  /// SendDiscoveryEmailRequest
  SendDiscoveryEmailRequest({
    required this.emailAddress,
    this.discoveryRedirectUrl,
    this.pkceCodeChallenge,
    this.loginTemplateId,
    this.locale,
    this.discoveryExpirationMinutes,
  }) {
    final trimmedEmail = emailAddress.trim();
    if (trimmedEmail.isEmpty) {
      throw ArgumentError('Email address cannot be empty.');
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(trimmedEmail)) {
      throw ArgumentError('Email address is invalid.');
    }
    if (discoveryExpirationMinutes != null && discoveryExpirationMinutes! < 0) {
      throw ArgumentError('Discovery expiration minutes cannot be negative.');
    }
  }

  /// fromJson
  factory SendDiscoveryEmailRequest.fromJson(Map<String, dynamic> json) {
    return SendDiscoveryEmailRequest(
      emailAddress: json['email_address'] as String,
      discoveryRedirectUrl: json['discovery_redirect_url'] as String?,
      pkceCodeChallenge: json['pkce_code_challenge'] as String?,
      loginTemplateId: json['login_template_id'] as String?,
      locale: json['locale'] as String?,
      discoveryExpirationMinutes: json['discovery_expiration_minutes'] as int?,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'email_address': emailAddress.trim(),
      if (discoveryRedirectUrl != null)
        'discovery_redirect_url': discoveryRedirectUrl,
      if (pkceCodeChallenge != null) 'pkce_code_challenge': pkceCodeChallenge,
      if (loginTemplateId != null) 'login_template_id': loginTemplateId,
      if (locale != null) 'locale': locale,
      if (discoveryExpirationMinutes != null)
        'discovery_expiration_minutes': discoveryExpirationMinutes,
    };
  }
}

/// Response model for sending a discovery Email Magic Link.
class SendDiscoveryEmailResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// SendDiscoveryEmailResponse
  const SendDiscoveryEmailResponse({
    required this.requestId,
    required this.statusCode,
  });

  /// fromJson
  factory SendDiscoveryEmailResponse.fromJson(Map<String, dynamic> json) {
    return SendDiscoveryEmailResponse(
      requestId: json['request_id'] as String,
      statusCode: json['status_code'] as int,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {'request_id': requestId, 'status_code': statusCode};
  }
}
