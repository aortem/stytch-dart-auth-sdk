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

bool _isValidEmail(String value) {
  return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim());
}

void _validateEmail(String value) {
  if (value.trim().isEmpty) {
    throw ArgumentError('Email address cannot be empty.');
  }
  if (!_isValidEmail(value)) {
    throw ArgumentError('Email address is invalid.');
  }
}

void _validateRequired(String value, String label) {
  if (value.trim().isEmpty) {
    throw ArgumentError('$label cannot be empty.');
  }
}

/// Request model for sending a login or signup Email Magic Link.
class SendLoginSignupEmailRequest {
  /// Organization to send the Email Magic Link in.
  final String organizationId;

  /// Member email address.
  final String emailAddress;

  /// Login redirect URL.
  final String? loginRedirectUrl;

  /// Signup redirect URL.
  final String? signupRedirectUrl;

  /// PKCE code challenge.
  final String? pkceCodeChallenge;

  /// Login email template ID.
  final String? loginTemplateId;

  /// Signup email template ID.
  final String? signupTemplateId;

  /// Locale for localized email copy.
  final String? locale;

  /// Login magic-link expiration in minutes.
  final int? loginExpirationMinutes;

  /// Signup magic-link expiration in minutes.
  final int? signupExpirationMinutes;

  /// SendLoginSignupEmailRequest
  SendLoginSignupEmailRequest({
    required this.organizationId,
    required this.emailAddress,
    this.loginRedirectUrl,
    this.signupRedirectUrl,
    this.pkceCodeChallenge,
    this.loginTemplateId,
    this.signupTemplateId,
    this.locale,
    this.loginExpirationMinutes,
    this.signupExpirationMinutes,
  }) {
    _validateRequired(organizationId, 'Organization ID');
    _validateEmail(emailAddress);
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'organization_id': organizationId.trim(),
      'email_address': emailAddress.trim(),
      if (loginRedirectUrl != null) 'login_redirect_url': loginRedirectUrl,
      if (signupRedirectUrl != null) 'signup_redirect_url': signupRedirectUrl,
      if (pkceCodeChallenge != null) 'pkce_code_challenge': pkceCodeChallenge,
      if (loginTemplateId != null) 'login_template_id': loginTemplateId,
      if (signupTemplateId != null) 'signup_template_id': signupTemplateId,
      if (locale != null) 'locale': locale,
      if (loginExpirationMinutes != null)
        'login_expiration_minutes': loginExpirationMinutes,
      if (signupExpirationMinutes != null)
        'signup_expiration_minutes': signupExpirationMinutes,
    };
  }
}

/// Response model for sending a login or signup Email Magic Link.
class SendLoginSignupEmailResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Member ID returned by Stytch.
  final String memberId;

  /// Whether Stytch created a member.
  final bool memberCreated;

  /// Member payload returned by Stytch.
  final Map<String, dynamic> member;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// SendLoginSignupEmailResponse
  const SendLoginSignupEmailResponse({
    required this.requestId,
    required this.memberId,
    required this.memberCreated,
    required this.member,
    required this.statusCode,
  });

  /// fromJson
  factory SendLoginSignupEmailResponse.fromJson(Map<String, dynamic> json) {
    return SendLoginSignupEmailResponse(
      requestId: json['request_id'] as String,
      memberId: json['member_id'] as String,
      memberCreated: json['member_created'] as bool,
      member: Map<String, dynamic>.from(json['member'] as Map),
      statusCode: json['status_code'] as int,
    );
  }
}

/// Request model for authenticating an Email Magic Link.
class AuthenticateMagicLinkRequest {
  /// Email Magic Link token.
  final String magicLinksToken;

  /// Requested session duration in minutes.
  final int? sessionDurationMinutes;

  /// Custom claims for the resulting session.
  final Map<String, dynamic>? sessionCustomClaims;

  /// PKCE code verifier.
  final String? pkceCodeVerifier;

  /// Locale for localized secondary auth challenges.
  final String? locale;

  /// AuthenticateMagicLinkRequest
  AuthenticateMagicLinkRequest({
    required this.magicLinksToken,
    this.sessionDurationMinutes,
    this.sessionCustomClaims,
    this.pkceCodeVerifier,
    this.locale,
  }) {
    _validateRequired(magicLinksToken, 'Magic link token');
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'magic_links_token': magicLinksToken.trim(),
      if (sessionDurationMinutes != null)
        'session_duration_minutes': sessionDurationMinutes,
      if (sessionCustomClaims != null)
        'session_custom_claims': sessionCustomClaims,
      if (pkceCodeVerifier != null) 'pkce_code_verifier': pkceCodeVerifier,
      if (locale != null) 'locale': locale,
    };
  }
}

/// Response model for organization auth endpoints returning a member session.
class AuthenticateMagicLinkResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Member ID returned by Stytch.
  final String memberId;

  /// Organization ID returned by Stytch.
  final String? organizationId;

  /// Authentication method ID.
  final String? methodId;

  /// Full session token when authentication requirements are satisfied.
  final String? sessionToken;

  /// Session JWT when authentication requirements are satisfied.
  final String? sessionJwt;

  /// Member payload returned by Stytch.
  final Map<String, dynamic>? member;

  /// Organization payload returned by Stytch.
  final Map<String, dynamic>? organization;

  /// Member session payload returned by Stytch.
  final Map<String, dynamic>? memberSession;

  /// Whether the member is fully authenticated.
  final bool memberAuthenticated;

  /// Intermediate session token when more authentication is required.
  final String? intermediateSessionToken;

  /// Provider values returned by OAuth authenticate endpoints.
  final Map<String, dynamic>? providerValues;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// AuthenticateMagicLinkResponse
  const AuthenticateMagicLinkResponse({
    required this.requestId,
    required this.memberId,
    this.organizationId,
    this.methodId,
    this.sessionToken,
    this.sessionJwt,
    this.member,
    this.organization,
    this.memberSession,
    required this.memberAuthenticated,
    this.intermediateSessionToken,
    this.providerValues,
    required this.statusCode,
  });

  /// fromJson
  factory AuthenticateMagicLinkResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticateMagicLinkResponse(
      requestId: json['request_id'] as String,
      memberId: json['member_id'] as String,
      organizationId: json['organization_id'] as String?,
      methodId: json['method_id'] as String?,
      sessionToken: json['session_token'] as String?,
      sessionJwt: json['session_jwt'] as String?,
      member: json['member'] != null
          ? Map<String, dynamic>.from(json['member'] as Map)
          : null,
      organization: json['organization'] != null
          ? Map<String, dynamic>.from(json['organization'] as Map)
          : null,
      memberSession: json['member_session'] != null
          ? Map<String, dynamic>.from(json['member_session'] as Map)
          : null,
      memberAuthenticated: json['member_authenticated'] as bool? ?? false,
      intermediateSessionToken: json['intermediate_session_token'] as String?,
      providerValues: json['provider_values'] != null
          ? Map<String, dynamic>.from(json['provider_values'] as Map)
          : null,
      statusCode: json['status_code'] as int,
    );
  }
}

/// Request model for authenticating a discovery Email Magic Link.
class AuthenticateDiscoveryMagicLinkRequest {
  /// Discovery Email Magic Link token.
  final String discoveryMagicLinksToken;

  /// AuthenticateDiscoveryMagicLinkRequest
  AuthenticateDiscoveryMagicLinkRequest({
    required this.discoveryMagicLinksToken,
  }) {
    _validateRequired(discoveryMagicLinksToken, 'Discovery magic link token');
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {'discovery_magic_links_token': discoveryMagicLinksToken.trim()};
  }
}

/// Response model for Stytch discovery authentication endpoints.
class AuthenticateDiscoveryResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Intermediate session token returned by Stytch.
  final String intermediateSessionToken;

  /// Authenticated email address.
  final String emailAddress;

  /// Discovered organizations returned by Stytch.
  final List<Map<String, dynamic>> discoveredOrganizations;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// AuthenticateDiscoveryResponse
  const AuthenticateDiscoveryResponse({
    required this.requestId,
    required this.intermediateSessionToken,
    required this.emailAddress,
    required this.discoveredOrganizations,
    required this.statusCode,
  });

  /// fromJson
  factory AuthenticateDiscoveryResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticateDiscoveryResponse(
      requestId: json['request_id'] as String,
      intermediateSessionToken: json['intermediate_session_token'] as String,
      emailAddress: json['email_address'] as String,
      discoveredOrganizations:
          (json['discovered_organizations'] as List<dynamic>)
              .map((item) => Map<String, dynamic>.from(item as Map))
              .toList(),
      statusCode: json['status_code'] as int,
    );
  }
}

/// Request model for sending a login or signup Email OTP.
class SendLoginSignupEmailOtpRequest {
  /// Organization to send the OTP in.
  final String organizationId;

  /// Member email address.
  final String emailAddress;

  /// Login email template ID.
  final String? loginTemplateId;

  /// Signup email template ID.
  final String? signupTemplateId;

  /// Locale for localized email copy.
  final String? locale;

  /// Login OTP expiration in minutes.
  final int? loginExpirationMinutes;

  /// Signup OTP expiration in minutes.
  final int? signupExpirationMinutes;

  /// SendLoginSignupEmailOtpRequest
  SendLoginSignupEmailOtpRequest({
    required this.organizationId,
    required this.emailAddress,
    this.loginTemplateId,
    this.signupTemplateId,
    this.locale,
    this.loginExpirationMinutes,
    this.signupExpirationMinutes,
  }) {
    _validateRequired(organizationId, 'Organization ID');
    _validateEmail(emailAddress);
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'organization_id': organizationId.trim(),
      'email_address': emailAddress.trim(),
      if (loginTemplateId != null) 'login_template_id': loginTemplateId,
      if (signupTemplateId != null) 'signup_template_id': signupTemplateId,
      if (locale != null) 'locale': locale,
      if (loginExpirationMinutes != null)
        'login_expiration_minutes': loginExpirationMinutes,
      if (signupExpirationMinutes != null)
        'signup_expiration_minutes': signupExpirationMinutes,
    };
  }
}

/// Response model for sending a login or signup Email OTP.
class SendLoginSignupEmailOtpResponse extends SendLoginSignupEmailResponse {
  /// SendLoginSignupEmailOtpResponse
  const SendLoginSignupEmailOtpResponse({
    required super.requestId,
    required super.memberId,
    required super.memberCreated,
    required super.member,
    required super.statusCode,
  });

  /// fromJson
  factory SendLoginSignupEmailOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendLoginSignupEmailOtpResponse(
      requestId: json['request_id'] as String,
      memberId: json['member_id'] as String,
      memberCreated: json['member_created'] as bool,
      member: Map<String, dynamic>.from(json['member'] as Map),
      statusCode: json['status_code'] as int,
    );
  }
}

/// Request model for authenticating an Email OTP.
class AuthenticateEmailOtpRequest {
  /// Organization containing the member.
  final String organizationId;

  /// Member email address.
  final String emailAddress;

  /// OTP code.
  final String code;

  /// Requested session duration in minutes.
  final int? sessionDurationMinutes;

  /// Custom claims for the resulting session.
  final Map<String, dynamic>? sessionCustomClaims;

  /// Session token for step-up or MFA contexts.
  final String? sessionToken;

  /// Session JWT for step-up or MFA contexts.
  final String? sessionJwt;

  /// Intermediate session token for MFA contexts.
  final String? intermediateSessionToken;

  /// AuthenticateEmailOtpRequest
  AuthenticateEmailOtpRequest({
    required this.organizationId,
    required this.emailAddress,
    required this.code,
    this.sessionDurationMinutes,
    this.sessionCustomClaims,
    this.sessionToken,
    this.sessionJwt,
    this.intermediateSessionToken,
  }) {
    _validateRequired(organizationId, 'Organization ID');
    _validateEmail(emailAddress);
    _validateRequired(code, 'OTP code');
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'organization_id': organizationId.trim(),
      'email_address': emailAddress.trim(),
      'code': code.trim(),
      if (sessionDurationMinutes != null)
        'session_duration_minutes': sessionDurationMinutes,
      if (sessionCustomClaims != null)
        'session_custom_claims': sessionCustomClaims,
      if (sessionToken != null) 'session_token': sessionToken,
      if (sessionJwt != null) 'session_jwt': sessionJwt,
      if (intermediateSessionToken != null)
        'intermediate_session_token': intermediateSessionToken,
    };
  }
}

/// Response model for authenticating an Email OTP.
class AuthenticateEmailOtpResponse extends AuthenticateMagicLinkResponse {
  /// AuthenticateEmailOtpResponse
  const AuthenticateEmailOtpResponse({
    required super.requestId,
    required super.memberId,
    super.organizationId,
    super.methodId,
    super.sessionToken,
    super.sessionJwt,
    super.member,
    super.organization,
    super.memberSession,
    required super.memberAuthenticated,
    super.intermediateSessionToken,
    required super.statusCode,
  });

  /// fromJson
  factory AuthenticateEmailOtpResponse.fromJson(Map<String, dynamic> json) {
    final response = AuthenticateMagicLinkResponse.fromJson(json);
    return AuthenticateEmailOtpResponse(
      requestId: response.requestId,
      memberId: response.memberId,
      organizationId: response.organizationId,
      methodId: response.methodId,
      sessionToken: response.sessionToken,
      sessionJwt: response.sessionJwt,
      member: response.member,
      organization: response.organization,
      memberSession: response.memberSession,
      memberAuthenticated: response.memberAuthenticated,
      intermediateSessionToken: response.intermediateSessionToken,
      statusCode: response.statusCode,
    );
  }
}

/// Request model for sending a discovery Email OTP.
class SendDiscoveryEmailOtpRequest {
  /// Email address to start discovery for.
  final String emailAddress;

  /// Login email template ID.
  final String? loginTemplateId;

  /// Locale for localized email copy.
  final String? locale;

  /// Discovery OTP expiration in minutes.
  final int? discoveryExpirationMinutes;

  /// SendDiscoveryEmailOtpRequest
  SendDiscoveryEmailOtpRequest({
    required this.emailAddress,
    this.loginTemplateId,
    this.locale,
    this.discoveryExpirationMinutes,
  }) {
    _validateEmail(emailAddress);
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'email_address': emailAddress.trim(),
      if (loginTemplateId != null) 'login_template_id': loginTemplateId,
      if (locale != null) 'locale': locale,
      if (discoveryExpirationMinutes != null)
        'discovery_expiration_minutes': discoveryExpirationMinutes,
    };
  }
}

/// Response model for sending a discovery Email OTP.
class SendDiscoveryEmailOtpResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// SendDiscoveryEmailOtpResponse
  const SendDiscoveryEmailOtpResponse({
    required this.requestId,
    required this.statusCode,
  });

  /// fromJson
  factory SendDiscoveryEmailOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendDiscoveryEmailOtpResponse(
      requestId: json['request_id'] as String,
      statusCode: json['status_code'] as int,
    );
  }
}

/// Request model for authenticating a discovery Email OTP.
class AuthenticateDiscoveryEmailOtpRequest {
  /// Email address to authenticate.
  final String emailAddress;

  /// OTP code.
  final String code;

  /// AuthenticateDiscoveryEmailOtpRequest
  AuthenticateDiscoveryEmailOtpRequest({
    required this.emailAddress,
    required this.code,
  }) {
    _validateEmail(emailAddress);
    _validateRequired(code, 'OTP code');
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {'email_address': emailAddress.trim(), 'code': code.trim()};
  }
}

/// Request model for starting an OAuth discovery flow.
class OAuthDiscoveryStartRequest {
  /// Stytch public token.
  final String publicToken;

  /// Redirect URL after provider authentication.
  final String? discoveryRedirectUrl;

  /// Space-separated provider scopes.
  final String? customScopes;

  /// PKCE code challenge.
  final String? pkceCodeChallenge;

  /// Provider-specific parameters, without the `provider_` prefix.
  final Map<String, String>? providerParams;

  /// OAuthDiscoveryStartRequest
  OAuthDiscoveryStartRequest({
    required this.publicToken,
    this.discoveryRedirectUrl,
    this.customScopes,
    this.pkceCodeChallenge,
    this.providerParams,
  }) {
    _validateRequired(publicToken, 'Public token');
  }

  /// String>
  Map<String, String> toQueryParameters() {
    return {
      'public_token': publicToken.trim(),
      if (discoveryRedirectUrl != null)
        'discovery_redirect_url': discoveryRedirectUrl!,
      if (customScopes != null) 'custom_scopes': customScopes!,
      if (pkceCodeChallenge != null) 'pkce_code_challenge': pkceCodeChallenge!,
      for (final entry
          in providerParams?.entries ?? <MapEntry<String, String>>[])
        'provider_${entry.key}': entry.value,
    };
  }
}

/// Response model for starting an OAuth discovery flow.
class OAuthDiscoveryStartResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Provider redirect URL.
  final String redirectUrl;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// OAuthDiscoveryStartResponse
  const OAuthDiscoveryStartResponse({
    required this.requestId,
    required this.redirectUrl,
    required this.statusCode,
  });

  /// fromJson
  factory OAuthDiscoveryStartResponse.fromJson(Map<String, dynamic> json) {
    return OAuthDiscoveryStartResponse(
      requestId: json['request_id'] as String,
      redirectUrl: json['redirect_url'] as String,
      statusCode: json['status_code'] as int,
    );
  }
}

/// Response model for Stytch JWKS.
class JwksResponse {
  /// JSON Web Keys returned by Stytch.
  final List<Map<String, dynamic>> keys;

  /// Globally unique request ID returned by Stytch.
  final String? requestId;

  /// HTTP status code returned by Stytch.
  final int? statusCode;

  /// JwksResponse
  const JwksResponse({required this.keys, this.requestId, this.statusCode});

  /// fromJson
  factory JwksResponse.fromJson(Map<String, dynamic> json) {
    return JwksResponse(
      keys: (json['keys'] as List<dynamic>)
          .map((key) => Map<String, dynamic>.from(key as Map))
          .toList(),
      requestId: json['request_id'] as String?,
      statusCode: json['status_code'] as int?,
    );
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
