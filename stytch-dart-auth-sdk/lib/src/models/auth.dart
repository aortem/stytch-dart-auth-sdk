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

/// Request model for authenticating a member with a password.
class PasswordAuthenticateRequest {
  /// Organization to authenticate into.
  final String organizationId;

  /// Member email address.
  final String emailAddress;

  /// Member password.
  final String password;

  /// Existing session token to extend.
  final String? sessionToken;

  /// Existing session JWT to extend.
  final String? sessionJwt;

  /// Requested session duration in minutes.
  final int? sessionDurationMinutes;

  /// Custom claims for the resulting session.
  final Map<String, dynamic>? sessionCustomClaims;

  /// Locale for MFA SMS copy, when MFA is required.
  final String? locale;

  /// Intermediate session token to add this primary factor to.
  final String? intermediateSessionToken;

  /// Device telemetry ID.
  final String? telemetryId;

  /// PasswordAuthenticateRequest
  PasswordAuthenticateRequest({
    required this.organizationId,
    required this.emailAddress,
    required this.password,
    this.sessionToken,
    this.sessionJwt,
    this.sessionDurationMinutes,
    this.sessionCustomClaims,
    this.locale,
    this.intermediateSessionToken,
    this.telemetryId,
  }) {
    _validateRequired(organizationId, 'Organization ID');
    _validateEmail(emailAddress);
    _validateRequired(password, 'Password');
  }

  /// Converts the request to the Stytch API payload.
  Map<String, dynamic> toJson() {
    return {
      'organization_id': organizationId.trim(),
      'email_address': emailAddress.trim(),
      'password': password,
      if (sessionToken != null) 'session_token': sessionToken!.trim(),
      if (sessionJwt != null) 'session_jwt': sessionJwt!.trim(),
      if (sessionDurationMinutes != null)
        'session_duration_minutes': sessionDurationMinutes,
      if (sessionCustomClaims != null)
        'session_custom_claims': sessionCustomClaims,
      if (locale != null) 'locale': locale,
      if (intermediateSessionToken != null)
        'intermediate_session_token': intermediateSessionToken!.trim(),
      if (telemetryId != null) 'telemetry_id': telemetryId,
    };
  }
}

/// Request model for authenticating a discovery password.
class PasswordDiscoveryAuthenticateRequest {
  /// Member email address.
  final String emailAddress;

  /// Member password.
  final String password;

  /// PasswordDiscoveryAuthenticateRequest
  PasswordDiscoveryAuthenticateRequest({
    required this.emailAddress,
    required this.password,
  }) {
    _validateEmail(emailAddress);
    _validateRequired(password, 'Password');
  }

  /// Converts the request to the Stytch API payload.
  Map<String, dynamic> toJson() {
    return {'email_address': emailAddress.trim(), 'password': password};
  }
}

/// Request model for checking password strength.
class PasswordStrengthCheckRequest {
  /// Password to check.
  final String password;

  /// Optional member email address.
  final String? emailAddress;

  /// PasswordStrengthCheckRequest
  PasswordStrengthCheckRequest({required this.password, this.emailAddress}) {
    _validateRequired(password, 'Password');
    if (emailAddress != null) _validateEmail(emailAddress!);
  }

  /// Converts the request to the Stytch API payload.
  Map<String, dynamic> toJson() {
    return {
      'password': password,
      if (emailAddress != null) 'email_address': emailAddress!.trim(),
    };
  }
}

/// Response model for checking password strength.
class PasswordStrengthCheckResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Whether the password passes validation.
  final bool validPassword;

  /// zxcvbn score returned by Stytch.
  final int score;

  /// Whether the password has appeared in a breach dataset.
  final bool breachedPassword;

  /// Password policy type enforced by the project.
  final String strengthPolicy;

  /// Whether breach detection is enabled on create.
  final bool breachDetectionOnCreate;

  /// LUDS feedback payload.
  final Map<String, dynamic>? ludsFeedback;

  /// zxcvbn feedback payload.
  final Map<String, dynamic>? zxcvbnFeedback;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// PasswordStrengthCheckResponse
  const PasswordStrengthCheckResponse({
    required this.requestId,
    required this.validPassword,
    required this.score,
    required this.breachedPassword,
    required this.strengthPolicy,
    required this.breachDetectionOnCreate,
    this.ludsFeedback,
    this.zxcvbnFeedback,
    required this.statusCode,
  });

  /// fromJson
  factory PasswordStrengthCheckResponse.fromJson(Map<String, dynamic> json) {
    return PasswordStrengthCheckResponse(
      requestId: json['request_id'] as String,
      validPassword: json['valid_password'] as bool,
      score: json['score'] as int,
      breachedPassword: json['breached_password'] as bool,
      strengthPolicy: json['strength_policy'] as String,
      breachDetectionOnCreate: json['breach_detection_on_create'] as bool,
      ludsFeedback: json['luds_feedback'] != null
          ? Map<String, dynamic>.from(json['luds_feedback'] as Map)
          : null,
      zxcvbnFeedback: json['zxcvbn_feedback'] != null
          ? Map<String, dynamic>.from(json['zxcvbn_feedback'] as Map)
          : null,
      statusCode: json['status_code'] as int,
    );
  }
}

/// Request model for migrating an existing password hash to Stytch.
class PasswordMigrateRequest {
  /// Member email address.
  final String emailAddress;

  /// Existing password hash.
  final String hash;

  /// Hash type accepted by Stytch.
  final String hashType;

  /// Organization to migrate the password into.
  final String organizationId;

  /// Optional MD-5 hash configuration.
  final Map<String, dynamic>? md5Config;

  /// Optional Argon2 hash configuration.
  final Map<String, dynamic>? argon2Config;

  /// Optional SHA-1 hash configuration.
  final Map<String, dynamic>? sha1Config;

  /// Optional SHA-512 hash configuration.
  final Map<String, dynamic>? sha512Config;

  /// Optional scrypt hash configuration.
  final Map<String, dynamic>? scryptConfig;

  /// Optional PBKDF2 hash configuration.
  final Map<String, dynamic>? pbkdf2Config;

  /// Member name.
  final String? name;

  /// Trusted metadata for the member.
  final Map<String, dynamic>? trustedMetadata;

  /// Untrusted metadata for the member.
  final Map<String, dynamic>? untrustedMetadata;

  /// Explicit role assignments.
  final List<String>? roles;

  /// Whether to preserve existing SSO sessions when role assignments change.
  final bool? preserveExistingSessions;

  /// Member phone number.
  final String? mfaPhoneNumber;

  /// Whether to mark the phone number as verified.
  final bool? setPhoneNumberVerified;

  /// External member ID.
  final String? externalId;

  /// PasswordMigrateRequest
  PasswordMigrateRequest({
    required this.emailAddress,
    required this.hash,
    required this.hashType,
    required this.organizationId,
    this.md5Config,
    this.argon2Config,
    this.sha1Config,
    this.sha512Config,
    this.scryptConfig,
    this.pbkdf2Config,
    this.name,
    this.trustedMetadata,
    this.untrustedMetadata,
    this.roles,
    this.preserveExistingSessions,
    this.mfaPhoneNumber,
    this.setPhoneNumberVerified,
    this.externalId,
  }) {
    _validateEmail(emailAddress);
    _validateRequired(hash, 'Password hash');
    _validateRequired(hashType, 'Hash type');
    _validateRequired(organizationId, 'Organization ID');
  }

  /// Converts the request to the Stytch API payload.
  Map<String, dynamic> toJson() {
    return {
      'email_address': emailAddress.trim(),
      'hash': hash,
      'hash_type': hashType,
      'organization_id': organizationId.trim(),
      if (md5Config != null) 'md_5_config': md5Config,
      if (argon2Config != null) 'argon_2_config': argon2Config,
      if (sha1Config != null) 'sha_1_config': sha1Config,
      if (sha512Config != null) 'sha_512_config': sha512Config,
      if (scryptConfig != null) 'scrypt_config': scryptConfig,
      if (pbkdf2Config != null) 'pbkdf_2_config': pbkdf2Config,
      if (name != null) 'name': name,
      if (trustedMetadata != null) 'trusted_metadata': trustedMetadata,
      if (untrustedMetadata != null) 'untrusted_metadata': untrustedMetadata,
      if (roles != null) 'roles': roles,
      if (preserveExistingSessions != null)
        'preserve_existing_sessions': preserveExistingSessions,
      if (mfaPhoneNumber != null) 'mfa_phone_number': mfaPhoneNumber,
      if (setPhoneNumberVerified != null)
        'set_phone_number_verified': setPhoneNumberVerified,
      if (externalId != null) 'external_id': externalId,
    };
  }
}

/// Response model for migrating an existing password hash to Stytch.
class PasswordMigrateResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Member ID returned by Stytch.
  final String memberId;

  /// Whether Stytch created a member.
  final bool memberCreated;

  /// Member payload returned by Stytch.
  final Map<String, dynamic> member;

  /// Organization payload returned by Stytch.
  final Map<String, dynamic> organization;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// PasswordMigrateResponse
  const PasswordMigrateResponse({
    required this.requestId,
    required this.memberId,
    required this.memberCreated,
    required this.member,
    required this.organization,
    required this.statusCode,
  });

  /// fromJson
  factory PasswordMigrateResponse.fromJson(Map<String, dynamic> json) {
    return PasswordMigrateResponse(
      requestId: json['request_id'] as String,
      memberId: json['member_id'] as String,
      memberCreated: json['member_created'] as bool,
      member: Map<String, dynamic>.from(json['member'] as Map),
      organization: Map<String, dynamic>.from(json['organization'] as Map),
      statusCode: json['status_code'] as int,
    );
  }
}

/// Request model for starting an organization password reset by email.
class PasswordEmailResetStartRequest {
  /// Organization to send the reset email in.
  final String organizationId;

  /// Member email address.
  final String emailAddress;

  /// Redirect URL for the reset-password magic link.
  final String? resetPasswordRedirectUrl;

  /// Reset-password link expiration in minutes.
  final int? resetPasswordExpirationMinutes;

  /// PKCE code challenge.
  final String? codeChallenge;

  /// Login redirect URL for "Log in without password".
  final String? loginRedirectUrl;

  /// Locale for localized email copy.
  final String? locale;

  /// Reset-password email template ID.
  final String? resetPasswordTemplateId;

  /// Verification email template ID.
  final String? verifyEmailTemplateId;

  /// PasswordEmailResetStartRequest
  PasswordEmailResetStartRequest({
    required this.organizationId,
    required this.emailAddress,
    this.resetPasswordRedirectUrl,
    this.resetPasswordExpirationMinutes,
    this.codeChallenge,
    this.loginRedirectUrl,
    this.locale,
    this.resetPasswordTemplateId,
    this.verifyEmailTemplateId,
  }) {
    _validateRequired(organizationId, 'Organization ID');
    _validateEmail(emailAddress);
  }

  /// Converts the request to the Stytch API payload.
  Map<String, dynamic> toJson() {
    return {
      'organization_id': organizationId.trim(),
      'email_address': emailAddress.trim(),
      if (resetPasswordRedirectUrl != null)
        'reset_password_redirect_url': resetPasswordRedirectUrl,
      if (resetPasswordExpirationMinutes != null)
        'reset_password_expiration_minutes': resetPasswordExpirationMinutes,
      if (codeChallenge != null) 'code_challenge': codeChallenge,
      if (loginRedirectUrl != null) 'login_redirect_url': loginRedirectUrl,
      if (locale != null) 'locale': locale,
      if (resetPasswordTemplateId != null)
        'reset_password_template_id': resetPasswordTemplateId,
      if (verifyEmailTemplateId != null)
        'verify_email_template_id': verifyEmailTemplateId,
    };
  }
}

/// Response model for starting an organization password reset by email.
class PasswordEmailResetStartResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Member ID returned by Stytch.
  final String memberId;

  /// Member email ID returned by Stytch.
  final String memberEmailId;

  /// Member payload returned by Stytch.
  final Map<String, dynamic> member;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// PasswordEmailResetStartResponse
  const PasswordEmailResetStartResponse({
    required this.requestId,
    required this.memberId,
    required this.memberEmailId,
    required this.member,
    required this.statusCode,
  });

  /// fromJson
  factory PasswordEmailResetStartResponse.fromJson(Map<String, dynamic> json) {
    return PasswordEmailResetStartResponse(
      requestId: json['request_id'] as String,
      memberId: json['member_id'] as String,
      memberEmailId: json['member_email_id'] as String,
      member: Map<String, dynamic>.from(json['member'] as Map),
      statusCode: json['status_code'] as int,
    );
  }
}

/// Request model for resetting a password with an email reset token.
class PasswordEmailResetRequest {
  /// Password reset token.
  final String passwordResetToken;

  /// New password.
  final String password;

  /// Existing session token to extend.
  final String? sessionToken;

  /// Existing session JWT to extend.
  final String? sessionJwt;

  /// Requested session duration in minutes.
  final int? sessionDurationMinutes;

  /// PKCE code verifier.
  final String? codeVerifier;

  /// Custom claims for the resulting session.
  final Map<String, dynamic>? sessionCustomClaims;

  /// Locale for MFA SMS copy, when MFA is required.
  final String? locale;

  /// Intermediate session token to add this primary factor to.
  final String? intermediateSessionToken;

  /// Device telemetry ID.
  final String? telemetryId;

  /// PasswordEmailResetRequest
  PasswordEmailResetRequest({
    required this.passwordResetToken,
    required this.password,
    this.sessionToken,
    this.sessionJwt,
    this.sessionDurationMinutes,
    this.codeVerifier,
    this.sessionCustomClaims,
    this.locale,
    this.intermediateSessionToken,
    this.telemetryId,
  }) {
    _validateRequired(passwordResetToken, 'Password reset token');
    _validateRequired(password, 'Password');
  }

  /// Converts the request to the Stytch API payload.
  Map<String, dynamic> toJson() {
    return {
      'password_reset_token': passwordResetToken.trim(),
      'password': password,
      if (sessionToken != null) 'session_token': sessionToken!.trim(),
      if (sessionJwt != null) 'session_jwt': sessionJwt!.trim(),
      if (sessionDurationMinutes != null)
        'session_duration_minutes': sessionDurationMinutes,
      if (codeVerifier != null) 'code_verifier': codeVerifier,
      if (sessionCustomClaims != null)
        'session_custom_claims': sessionCustomClaims,
      if (locale != null) 'locale': locale,
      if (intermediateSessionToken != null)
        'intermediate_session_token': intermediateSessionToken!.trim(),
      if (telemetryId != null) 'telemetry_id': telemetryId,
    };
  }
}

/// Request model for resetting a password with an existing password.
class PasswordExistingPasswordResetRequest {
  /// Member email address.
  final String emailAddress;

  /// Member's existing password.
  final String existingPassword;

  /// New password.
  final String newPassword;

  /// Organization to reset in.
  final String organizationId;

  /// Existing session token to extend.
  final String? sessionToken;

  /// Existing session JWT to extend.
  final String? sessionJwt;

  /// Requested session duration in minutes.
  final int? sessionDurationMinutes;

  /// Custom claims for the resulting session.
  final Map<String, dynamic>? sessionCustomClaims;

  /// Locale for MFA SMS copy, when MFA is required.
  final String? locale;

  /// Device telemetry ID.
  final String? telemetryId;

  /// PasswordExistingPasswordResetRequest
  PasswordExistingPasswordResetRequest({
    required this.emailAddress,
    required this.existingPassword,
    required this.newPassword,
    required this.organizationId,
    this.sessionToken,
    this.sessionJwt,
    this.sessionDurationMinutes,
    this.sessionCustomClaims,
    this.locale,
    this.telemetryId,
  }) {
    _validateEmail(emailAddress);
    _validateRequired(existingPassword, 'Existing password');
    _validateRequired(newPassword, 'New password');
    _validateRequired(organizationId, 'Organization ID');
  }

  /// Converts the request to the Stytch API payload.
  Map<String, dynamic> toJson() {
    return {
      'email_address': emailAddress.trim(),
      'existing_password': existingPassword,
      'new_password': newPassword,
      'organization_id': organizationId.trim(),
      if (sessionToken != null) 'session_token': sessionToken!.trim(),
      if (sessionJwt != null) 'session_jwt': sessionJwt!.trim(),
      if (sessionDurationMinutes != null)
        'session_duration_minutes': sessionDurationMinutes,
      if (sessionCustomClaims != null)
        'session_custom_claims': sessionCustomClaims,
      if (locale != null) 'locale': locale,
      if (telemetryId != null) 'telemetry_id': telemetryId,
    };
  }
}

/// Request model for resetting a password with a recent member session.
class PasswordSessionResetRequest {
  /// Organization to reset in.
  final String organizationId;

  /// New password.
  final String password;

  /// Existing session token.
  final String? sessionToken;

  /// Existing session JWT.
  final String? sessionJwt;

  /// Requested session duration in minutes.
  final int? sessionDurationMinutes;

  /// Custom claims for the resulting session.
  final Map<String, dynamic>? sessionCustomClaims;

  /// Locale for localized messages.
  final String? locale;

  /// Device telemetry ID.
  final String? telemetryId;

  /// PasswordSessionResetRequest
  PasswordSessionResetRequest({
    required this.organizationId,
    required this.password,
    this.sessionToken,
    this.sessionJwt,
    this.sessionDurationMinutes,
    this.sessionCustomClaims,
    this.locale,
    this.telemetryId,
  }) {
    _validateRequired(organizationId, 'Organization ID');
    _validateRequired(password, 'Password');
    final hasSession = [
      sessionToken,
      sessionJwt,
    ].any((value) => value != null && value.trim().isNotEmpty);
    if (!hasSession) {
      throw ArgumentError('A session token or session JWT is required.');
    }
  }

  /// Converts the request to the Stytch API payload.
  Map<String, dynamic> toJson() {
    return {
      'organization_id': organizationId.trim(),
      'password': password,
      if (sessionToken != null) 'session_token': sessionToken!.trim(),
      if (sessionJwt != null) 'session_jwt': sessionJwt!.trim(),
      if (sessionDurationMinutes != null)
        'session_duration_minutes': sessionDurationMinutes,
      if (sessionCustomClaims != null)
        'session_custom_claims': sessionCustomClaims,
      if (locale != null) 'locale': locale,
      if (telemetryId != null) 'telemetry_id': telemetryId,
    };
  }
}

/// Request model for starting a discovery password reset by email.
class PasswordDiscoveryEmailResetStartRequest {
  /// Member email address.
  final String emailAddress;

  /// Redirect URL for the reset-password magic link.
  final String? resetPasswordRedirectUrl;

  /// Discovery redirect URL.
  final String? discoveryRedirectUrl;

  /// Reset-password email template ID.
  final String? resetPasswordTemplateId;

  /// Reset-password link expiration in minutes.
  final int? resetPasswordExpirationMinutes;

  /// PKCE code challenge.
  final String? pkceCodeChallenge;

  /// Locale for localized email copy.
  final String? locale;

  /// PasswordDiscoveryEmailResetStartRequest
  PasswordDiscoveryEmailResetStartRequest({
    required this.emailAddress,
    this.resetPasswordRedirectUrl,
    this.discoveryRedirectUrl,
    this.resetPasswordTemplateId,
    this.resetPasswordExpirationMinutes,
    this.pkceCodeChallenge,
    this.locale,
  }) {
    _validateEmail(emailAddress);
  }

  /// Converts the request to the Stytch API payload.
  Map<String, dynamic> toJson() {
    return {
      'email_address': emailAddress.trim(),
      if (resetPasswordRedirectUrl != null)
        'reset_password_redirect_url': resetPasswordRedirectUrl,
      if (discoveryRedirectUrl != null)
        'discovery_redirect_url': discoveryRedirectUrl,
      if (resetPasswordTemplateId != null)
        'reset_password_template_id': resetPasswordTemplateId,
      if (resetPasswordExpirationMinutes != null)
        'reset_password_expiration_minutes': resetPasswordExpirationMinutes,
      if (pkceCodeChallenge != null) 'pkce_code_challenge': pkceCodeChallenge,
      if (locale != null) 'locale': locale,
    };
  }
}

/// Response model for starting a discovery password reset by email.
class PasswordDiscoveryEmailResetStartResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// PasswordDiscoveryEmailResetStartResponse
  const PasswordDiscoveryEmailResetStartResponse({
    required this.requestId,
    required this.statusCode,
  });

  /// fromJson
  factory PasswordDiscoveryEmailResetStartResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return PasswordDiscoveryEmailResetStartResponse(
      requestId: json['request_id'] as String,
      statusCode: json['status_code'] as int,
    );
  }
}

/// Request model for resetting a discovery password with an email token.
class PasswordDiscoveryEmailResetRequest {
  /// Password reset token.
  final String passwordResetToken;

  /// New password.
  final String password;

  /// PKCE code verifier.
  final String? pkceCodeVerifier;

  /// PasswordDiscoveryEmailResetRequest
  PasswordDiscoveryEmailResetRequest({
    required this.passwordResetToken,
    required this.password,
    this.pkceCodeVerifier,
  }) {
    _validateRequired(passwordResetToken, 'Password reset token');
    _validateRequired(password, 'Password');
  }

  /// Converts the request to the Stytch API payload.
  Map<String, dynamic> toJson() {
    return {
      'password_reset_token': passwordResetToken.trim(),
      'password': password,
      if (pkceCodeVerifier != null) 'pkce_code_verifier': pkceCodeVerifier,
    };
  }
}

/// Request model for requiring a password reset by email.
class PasswordRequireResetByEmailRequest {
  /// Member email address.
  final String emailAddress;

  /// Optional organization ID.
  final String? organizationId;

  /// Optional member ID.
  final String? memberId;

  /// PasswordRequireResetByEmailRequest
  PasswordRequireResetByEmailRequest({
    required this.emailAddress,
    this.organizationId,
    this.memberId,
  }) {
    _validateEmail(emailAddress);
  }

  /// Converts the request to the Stytch API payload.
  Map<String, dynamic> toJson() {
    return {
      'email_address': emailAddress.trim(),
      if (organizationId != null) 'organization_id': organizationId!.trim(),
      if (memberId != null) 'member_id': memberId!.trim(),
    };
  }
}

/// Response model for requiring a password reset by email.
class PasswordRequireResetByEmailResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// Member ID returned by Stytch, when available.
  final String? memberId;

  /// Member payload returned by Stytch, when available.
  final Map<String, dynamic>? member;

  /// Organization payload returned by Stytch, when available.
  final Map<String, dynamic>? organization;

  /// PasswordRequireResetByEmailResponse
  const PasswordRequireResetByEmailResponse({
    required this.requestId,
    required this.statusCode,
    this.memberId,
    this.member,
    this.organization,
  });

  /// fromJson
  factory PasswordRequireResetByEmailResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return PasswordRequireResetByEmailResponse(
      requestId: json['request_id'] as String,
      statusCode: json['status_code'] as int,
      memberId: json['member_id'] as String?,
      member: json['member'] != null
          ? Map<String, dynamic>.from(json['member'] as Map)
          : null,
      organization: json['organization'] != null
          ? Map<String, dynamic>.from(json['organization'] as Map)
          : null,
    );
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

/// Request model for retrieving active sessions for a member.
class GetSessionsRequest {
  /// Organization containing the member.
  final String organizationId;

  /// Member ID whose sessions should be returned.
  final String memberId;

  /// GetSessionsRequest
  GetSessionsRequest({required this.organizationId, required this.memberId}) {
    _validateRequired(organizationId, 'Organization ID');
    _validateRequired(memberId, 'Member ID');
  }

  /// String>
  Map<String, String> toQueryParameters() {
    return {
      'organization_id': organizationId.trim(),
      'member_id': memberId.trim(),
    };
  }
}

/// Response model for retrieving active sessions.
class GetSessionsResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Member sessions returned by Stytch.
  final List<Map<String, dynamic>> memberSessions;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// GetSessionsResponse
  const GetSessionsResponse({
    required this.requestId,
    required this.memberSessions,
    required this.statusCode,
  });

  /// fromJson
  factory GetSessionsResponse.fromJson(Map<String, dynamic> json) {
    return GetSessionsResponse(
      requestId: json['request_id'] as String,
      memberSessions: (json['member_sessions'] as List<dynamic>)
          .map((session) => Map<String, dynamic>.from(session as Map))
          .toList(),
      statusCode: json['status_code'] as int,
    );
  }
}

/// Request model for authenticating a session.
class AuthenticateSessionRequest {
  /// Session token to authenticate.
  final String? sessionToken;

  /// Session JWT to authenticate.
  final String? sessionJwt;

  /// Requested session duration in minutes.
  final int? sessionDurationMinutes;

  /// Custom claims for the authenticated session.
  final Map<String, dynamic>? sessionCustomClaims;

  /// Optional authorization check.
  final Map<String, dynamic>? authorizationCheck;

  /// AuthenticateSessionRequest
  AuthenticateSessionRequest({
    this.sessionToken,
    this.sessionJwt,
    this.sessionDurationMinutes,
    this.sessionCustomClaims,
    this.authorizationCheck,
  }) {
    final hasToken = sessionToken != null && sessionToken!.trim().isNotEmpty;
    final hasJwt = sessionJwt != null && sessionJwt!.trim().isNotEmpty;
    if (hasToken == hasJwt) {
      throw ArgumentError('Provide exactly one session token or session JWT.');
    }
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      if (sessionToken != null) 'session_token': sessionToken!.trim(),
      if (sessionJwt != null) 'session_jwt': sessionJwt!.trim(),
      if (sessionDurationMinutes != null)
        'session_duration_minutes': sessionDurationMinutes,
      if (sessionCustomClaims != null)
        'session_custom_claims': sessionCustomClaims,
      if (authorizationCheck != null) 'authorization_check': authorizationCheck,
    };
  }
}

/// Response model for authenticating a session.
class AuthenticateSessionResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Member session returned by Stytch.
  final Map<String, dynamic> memberSession;

  /// Member payload returned by Stytch.
  final Map<String, dynamic> member;

  /// Organization payload returned by Stytch.
  final Map<String, dynamic> organization;

  /// Session token returned by Stytch.
  final String? sessionToken;

  /// Session JWT returned by Stytch.
  final String? sessionJwt;

  /// Authorization verdict returned when an authorization check is supplied.
  final Map<String, dynamic>? verdict;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// AuthenticateSessionResponse
  const AuthenticateSessionResponse({
    required this.requestId,
    required this.memberSession,
    required this.member,
    required this.organization,
    this.sessionToken,
    this.sessionJwt,
    this.verdict,
    required this.statusCode,
  });

  /// fromJson
  factory AuthenticateSessionResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticateSessionResponse(
      requestId: json['request_id'] as String,
      memberSession: Map<String, dynamic>.from(json['member_session'] as Map),
      member: Map<String, dynamic>.from(json['member'] as Map),
      organization: Map<String, dynamic>.from(json['organization'] as Map),
      sessionToken: json['session_token'] as String?,
      sessionJwt: json['session_jwt'] as String?,
      verdict: json['verdict'] != null
          ? Map<String, dynamic>.from(json['verdict'] as Map)
          : null,
      statusCode: json['status_code'] as int,
    );
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

/// Request model for authenticating a B2B impersonation token.
class AuthenticateImpersonationTokenRequest {
  /// Impersonation token generated from the Stytch dashboard.
  final String impersonationToken;

  /// AuthenticateImpersonationTokenRequest
  AuthenticateImpersonationTokenRequest({required this.impersonationToken}) {
    _validateRequired(impersonationToken, 'Impersonation token');
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {'impersonation_token': impersonationToken.trim()};
  }
}

/// Response model for authenticating a B2B impersonation token.
class AuthenticateImpersonationTokenResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Member ID returned by Stytch.
  final String memberId;

  /// Organization ID returned by Stytch.
  final String organizationId;

  /// Member payload returned by Stytch.
  final Map<String, dynamic> member;

  /// Session token returned by Stytch.
  final String? sessionToken;

  /// Session JWT returned by Stytch.
  final String? sessionJwt;

  /// Organization payload returned by Stytch.
  final Map<String, dynamic>? organization;

  /// Member session payload returned by Stytch.
  final Map<String, dynamic>? memberSession;

  /// Whether the member is fully authenticated.
  final bool memberAuthenticated;

  /// Intermediate session token when MFA is required.
  final String? intermediateSessionToken;

  /// MFA requirement payload.
  final Map<String, dynamic>? mfaRequired;

  /// Primary-auth requirement payload.
  final Map<String, dynamic>? primaryRequired;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// AuthenticateImpersonationTokenResponse
  const AuthenticateImpersonationTokenResponse({
    required this.requestId,
    required this.memberId,
    required this.organizationId,
    required this.member,
    this.sessionToken,
    this.sessionJwt,
    this.organization,
    this.memberSession,
    required this.memberAuthenticated,
    this.intermediateSessionToken,
    this.mfaRequired,
    this.primaryRequired,
    required this.statusCode,
  });

  /// fromJson
  factory AuthenticateImpersonationTokenResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AuthenticateImpersonationTokenResponse(
      requestId: json['request_id'] as String,
      memberId: json['member_id'] as String,
      organizationId: json['organization_id'] as String,
      member: Map<String, dynamic>.from(json['member'] as Map),
      sessionToken: json['session_token'] as String?,
      sessionJwt: json['session_jwt'] as String?,
      organization: json['organization'] != null
          ? Map<String, dynamic>.from(json['organization'] as Map)
          : null,
      memberSession: json['member_session'] != null
          ? Map<String, dynamic>.from(json['member_session'] as Map)
          : null,
      memberAuthenticated: json['member_authenticated'] as bool? ?? false,
      intermediateSessionToken: json['intermediate_session_token'] as String?,
      mfaRequired: json['mfa_required'] != null
          ? Map<String, dynamic>.from(json['mfa_required'] as Map)
          : null,
      primaryRequired: json['primary_required'] != null
          ? Map<String, dynamic>.from(json['primary_required'] as Map)
          : null,
      statusCode: json['status_code'] as int,
    );
  }
}

/// Request model for migrating an external OIDC session.
class MigrateSessionRequest {
  /// External session token for Stytch to pass to the configured UserInfo endpoint.
  final String sessionToken;

  /// Organization to migrate into.
  final String organizationId;

  /// Requested session duration in minutes.
  final int? sessionDurationMinutes;

  /// Custom claims for the resulting session.
  final Map<String, dynamic>? sessionCustomClaims;

  /// MigrateSessionRequest
  MigrateSessionRequest({
    required this.sessionToken,
    required this.organizationId,
    this.sessionDurationMinutes,
    this.sessionCustomClaims,
  }) {
    _validateRequired(sessionToken, 'Session token');
    _validateRequired(organizationId, 'Organization ID');
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'session_token': sessionToken.trim(),
      'organization_id': organizationId.trim(),
      if (sessionDurationMinutes != null)
        'session_duration_minutes': sessionDurationMinutes,
      if (sessionCustomClaims != null)
        'session_custom_claims': sessionCustomClaims,
    };
  }
}

/// Response model for migrating an external OIDC session.
class MigrateSessionResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Member ID returned by Stytch.
  final String memberId;

  /// Full session token returned by Stytch.
  final String sessionToken;

  /// Session JWT returned by Stytch.
  final String sessionJwt;

  /// Member payload returned by Stytch.
  final Map<String, dynamic> member;

  /// Organization payload returned by Stytch.
  final Map<String, dynamic> organization;

  /// Member session payload returned by Stytch.
  final Map<String, dynamic>? memberSession;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// MigrateSessionResponse
  const MigrateSessionResponse({
    required this.requestId,
    required this.memberId,
    required this.sessionToken,
    required this.sessionJwt,
    required this.member,
    required this.organization,
    this.memberSession,
    required this.statusCode,
  });

  /// fromJson
  factory MigrateSessionResponse.fromJson(Map<String, dynamic> json) {
    return MigrateSessionResponse(
      requestId: json['request_id'] as String,
      memberId: json['member_id'] as String,
      sessionToken: json['session_token'] as String,
      sessionJwt: json['session_jwt'] as String,
      member: Map<String, dynamic>.from(json['member'] as Map),
      organization: Map<String, dynamic>.from(json['organization'] as Map),
      memberSession: json['member_session'] != null
          ? Map<String, dynamic>.from(json['member_session'] as Map)
          : null,
      statusCode: json['status_code'] as int,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'member_id': memberId,
      'session_token': sessionToken,
      'session_jwt': sessionJwt,
      'member': member,
      'organization': organization,
      if (memberSession != null) 'member_session': memberSession,
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

/// Request model for creating an organization through discovery.
class CreateOrganizationViaDiscoveryRequest {
  /// Intermediate session token from a discovery authentication flow.
  final String intermediateSessionToken;

  /// Requested session duration in minutes.
  final int? sessionDurationMinutes;

  /// Custom claims for the resulting session.
  final Map<String, dynamic>? sessionCustomClaims;

  /// Organization display name.
  final String? organizationName;

  /// Organization URL slug.
  final String? organizationSlug;

  /// Organization external ID.
  final String? organizationExternalId;

  /// Organization logo URL.
  final String? organizationLogoUrl;

  /// Trusted metadata for the organization.
  final Map<String, dynamic>? trustedMetadata;

  /// SSO JIT provisioning setting.
  final String? ssoJitProvisioning;

  /// Allowed email domains.
  final List<String>? emailAllowedDomains;

  /// Email JIT provisioning setting.
  final String? emailJitProvisioning;

  /// Email invites setting.
  final String? emailInvites;

  /// Auth methods setting.
  final String? authMethods;

  /// Allowed auth methods.
  final List<String>? allowedAuthMethods;

  /// MFA policy setting.
  final String? mfaPolicy;

  /// RBAC implicit role assignments by email domain.
  final List<Map<String, dynamic>>? rbacEmailImplicitRoleAssignments;

  /// MFA methods setting.
  final String? mfaMethods;

  /// Allowed MFA methods.
  final List<String>? allowedMfaMethods;

  /// OAuth tenant JIT provisioning setting.
  final String? oauthTenantJitProvisioning;

  /// Allowed OAuth tenants map.
  final Map<String, dynamic>? allowedOauthTenants;

  /// First-party Connected Apps policy.
  final String? firstPartyConnectedAppsAllowedType;

  /// Allowed first-party Connected App IDs.
  final List<String>? allowedFirstPartyConnectedApps;

  /// Third-party Connected Apps policy.
  final String? thirdPartyConnectedAppsAllowedType;

  /// Allowed third-party Connected App IDs.
  final List<String>? allowedThirdPartyConnectedApps;

  /// Device telemetry ID.
  final String? telemetryId;

  /// CreateOrganizationViaDiscoveryRequest
  CreateOrganizationViaDiscoveryRequest({
    required this.intermediateSessionToken,
    this.sessionDurationMinutes,
    this.sessionCustomClaims,
    this.organizationName,
    this.organizationSlug,
    this.organizationExternalId,
    this.organizationLogoUrl,
    this.trustedMetadata,
    this.ssoJitProvisioning,
    this.emailAllowedDomains,
    this.emailJitProvisioning,
    this.emailInvites,
    this.authMethods,
    this.allowedAuthMethods,
    this.mfaPolicy,
    this.rbacEmailImplicitRoleAssignments,
    this.mfaMethods,
    this.allowedMfaMethods,
    this.oauthTenantJitProvisioning,
    this.allowedOauthTenants,
    this.firstPartyConnectedAppsAllowedType,
    this.allowedFirstPartyConnectedApps,
    this.thirdPartyConnectedAppsAllowedType,
    this.allowedThirdPartyConnectedApps,
    this.telemetryId,
  }) {
    _validateRequired(intermediateSessionToken, 'Intermediate session token');
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'intermediate_session_token': intermediateSessionToken.trim(),
      if (sessionDurationMinutes != null)
        'session_duration_minutes': sessionDurationMinutes,
      if (sessionCustomClaims != null)
        'session_custom_claims': sessionCustomClaims,
      if (organizationName != null) 'organization_name': organizationName,
      if (organizationSlug != null) 'organization_slug': organizationSlug,
      if (organizationExternalId != null)
        'organization_external_id': organizationExternalId,
      if (organizationLogoUrl != null)
        'organization_logo_url': organizationLogoUrl,
      if (trustedMetadata != null) 'trusted_metadata': trustedMetadata,
      if (ssoJitProvisioning != null)
        'sso_jit_provisioning': ssoJitProvisioning,
      if (emailAllowedDomains != null)
        'email_allowed_domains': emailAllowedDomains,
      if (emailJitProvisioning != null)
        'email_jit_provisioning': emailJitProvisioning,
      if (emailInvites != null) 'email_invites': emailInvites,
      if (authMethods != null) 'auth_methods': authMethods,
      if (allowedAuthMethods != null)
        'allowed_auth_methods': allowedAuthMethods,
      if (mfaPolicy != null) 'mfa_policy': mfaPolicy,
      if (rbacEmailImplicitRoleAssignments != null)
        'rbac_email_implicit_role_assignments':
            rbacEmailImplicitRoleAssignments,
      if (mfaMethods != null) 'mfa_methods': mfaMethods,
      if (allowedMfaMethods != null) 'allowed_mfa_methods': allowedMfaMethods,
      if (oauthTenantJitProvisioning != null)
        'oauth_tenant_jit_provisioning': oauthTenantJitProvisioning,
      if (allowedOauthTenants != null)
        'allowed_oauth_tenants': allowedOauthTenants,
      if (firstPartyConnectedAppsAllowedType != null)
        'first_party_connected_apps_allowed_type':
            firstPartyConnectedAppsAllowedType,
      if (allowedFirstPartyConnectedApps != null)
        'allowed_first_party_connected_apps': allowedFirstPartyConnectedApps,
      if (thirdPartyConnectedAppsAllowedType != null)
        'third_party_connected_apps_allowed_type':
            thirdPartyConnectedAppsAllowedType,
      if (allowedThirdPartyConnectedApps != null)
        'allowed_third_party_connected_apps': allowedThirdPartyConnectedApps,
      if (telemetryId != null) 'telemetry_id': telemetryId,
    };
  }
}

/// Request model for listing discovered organizations.
class ListDiscoveredOrganizationsRequest {
  /// Intermediate session token.
  final String? intermediateSessionToken;

  /// Member session token.
  final String? sessionToken;

  /// Member session JWT.
  final String? sessionJwt;

  /// ListDiscoveredOrganizationsRequest
  ListDiscoveredOrganizationsRequest({
    this.intermediateSessionToken,
    this.sessionToken,
    this.sessionJwt,
  }) {
    final provided = [
      intermediateSessionToken,
      sessionToken,
      sessionJwt,
    ].where((value) => value != null && value.trim().isNotEmpty).length;
    if (provided != 1) {
      throw ArgumentError(
        'Exactly one intermediate session token, session token, or session JWT is required.',
      );
    }
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      if (intermediateSessionToken != null)
        'intermediate_session_token': intermediateSessionToken!.trim(),
      if (sessionToken != null) 'session_token': sessionToken!.trim(),
      if (sessionJwt != null) 'session_jwt': sessionJwt!.trim(),
    };
  }
}

/// Response model for listing discovered organizations.
class ListDiscoveredOrganizationsResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Email address tied to the session or intermediate session.
  final String emailAddress;

  /// Discovered organizations returned by Stytch.
  final List<Map<String, dynamic>> discoveredOrganizations;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// Organization ID hint returned by Stytch.
  final String? organizationIdHint;

  /// ListDiscoveredOrganizationsResponse
  const ListDiscoveredOrganizationsResponse({
    required this.requestId,
    required this.emailAddress,
    required this.discoveredOrganizations,
    required this.statusCode,
    this.organizationIdHint,
  });

  /// fromJson
  factory ListDiscoveredOrganizationsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return ListDiscoveredOrganizationsResponse(
      requestId: json['request_id'] as String,
      emailAddress: json['email_address'] as String,
      discoveredOrganizations:
          (json['discovered_organizations'] as List<dynamic>)
              .map((item) => Map<String, dynamic>.from(item as Map))
              .toList(),
      statusCode: json['status_code'] as int,
      organizationIdHint: json['organization_id_hint'] as String?,
    );
  }
}

/// Request model for exchanging an intermediate session.
class ExchangeIntermediateSessionRequest {
  /// Intermediate session token.
  final String intermediateSessionToken;

  /// Organization to exchange into.
  final String organizationId;

  /// Requested session duration in minutes.
  final int? sessionDurationMinutes;

  /// Custom claims for the resulting session.
  final Map<String, dynamic>? sessionCustomClaims;

  /// Locale for MFA SMS copy, when MFA is required.
  final String? locale;

  /// Device telemetry ID.
  final String? telemetryId;

  /// ExchangeIntermediateSessionRequest
  ExchangeIntermediateSessionRequest({
    required this.intermediateSessionToken,
    required this.organizationId,
    this.sessionDurationMinutes,
    this.sessionCustomClaims,
    this.locale,
    this.telemetryId,
  }) {
    _validateRequired(intermediateSessionToken, 'Intermediate session token');
    _validateRequired(organizationId, 'Organization ID');
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'intermediate_session_token': intermediateSessionToken.trim(),
      'organization_id': organizationId.trim(),
      if (sessionDurationMinutes != null)
        'session_duration_minutes': sessionDurationMinutes,
      if (sessionCustomClaims != null)
        'session_custom_claims': sessionCustomClaims,
      if (locale != null) 'locale': locale,
      if (telemetryId != null) 'telemetry_id': telemetryId,
    };
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
