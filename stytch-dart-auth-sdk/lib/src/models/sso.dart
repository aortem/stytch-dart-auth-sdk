library sso_models;

/// Models for Stytch B2B SSO APIs.

void _validateRequired(String value, String fieldName) {
  if (value.trim().isEmpty) {
    throw ArgumentError('$fieldName cannot be empty.');
  }
}

/// Request model for creating a SAML connection.
class CreateSamlConnectionRequest {
  /// Human-readable connection name.
  final String? displayName;

  /// Optional Stytch identity provider hint.
  final String? identityProvider;

  /// CreateSamlConnectionRequest
  const CreateSamlConnectionRequest({this.displayName, this.identityProvider});

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      if (displayName != null) 'display_name': displayName,
      if (identityProvider != null) 'identity_provider': identityProvider,
    };
  }
}

/// Request model for updating a SAML connection.
class UpdateSamlConnectionRequest {
  /// IdP entity ID.
  final String? idpEntityId;

  /// Human-readable connection name.
  final String? displayName;

  /// Attribute mapping used to identify members.
  final Map<String, dynamic>? attributeMapping;

  /// PEM x509 certificate used to verify assertions.
  final String? x509Certificate;

  /// IdP SSO URL.
  final String? idpSsoUrl;

  /// Connection-level implicit role assignments.
  final List<Map<String, dynamic>>? samlConnectionImplicitRoleAssignments;

  /// Group-level implicit role assignments.
  final List<Map<String, dynamic>>? samlGroupImplicitRoleAssignments;

  /// Alternative audience URI.
  final String? alternativeAudienceUri;

  /// Optional Stytch identity provider hint.
  final String? identityProvider;

  /// PKCS1 RSA private key used for signing SAML requests.
  final String? signingPrivateKey;

  /// SAML NameID format.
  final String? nameidFormat;

  /// Alternative ACS URL.
  final String? alternativeAcsUrl;

  /// Whether IdP-initiated auth is disabled.
  final bool? idpInitiatedAuthDisabled;

  /// PKCS1 RSA private key used to decrypt encrypted SAML assertions.
  final String? samlEncryptionPrivateKey;

  /// Whether gateway callback is allowed.
  final bool? allowGatewayCallback;

  /// UpdateSamlConnectionRequest
  const UpdateSamlConnectionRequest({
    this.idpEntityId,
    this.displayName,
    this.attributeMapping,
    this.x509Certificate,
    this.idpSsoUrl,
    this.samlConnectionImplicitRoleAssignments,
    this.samlGroupImplicitRoleAssignments,
    this.alternativeAudienceUri,
    this.identityProvider,
    this.signingPrivateKey,
    this.nameidFormat,
    this.alternativeAcsUrl,
    this.idpInitiatedAuthDisabled,
    this.samlEncryptionPrivateKey,
    this.allowGatewayCallback,
  });

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      if (idpEntityId != null) 'idp_entity_id': idpEntityId,
      if (displayName != null) 'display_name': displayName,
      if (attributeMapping != null) 'attribute_mapping': attributeMapping,
      if (x509Certificate != null) 'x509_certificate': x509Certificate,
      if (idpSsoUrl != null) 'idp_sso_url': idpSsoUrl,
      if (samlConnectionImplicitRoleAssignments != null)
        'saml_connection_implicit_role_assignments':
            samlConnectionImplicitRoleAssignments,
      if (samlGroupImplicitRoleAssignments != null)
        'saml_group_implicit_role_assignments':
            samlGroupImplicitRoleAssignments,
      if (alternativeAudienceUri != null)
        'alternative_audience_uri': alternativeAudienceUri,
      if (identityProvider != null) 'identity_provider': identityProvider,
      if (signingPrivateKey != null) 'signing_private_key': signingPrivateKey,
      if (nameidFormat != null) 'nameid_format': nameidFormat,
      if (alternativeAcsUrl != null) 'alternative_acs_url': alternativeAcsUrl,
      if (idpInitiatedAuthDisabled != null)
        'idp_initiated_auth_disabled': idpInitiatedAuthDisabled,
      if (samlEncryptionPrivateKey != null)
        'saml_encryption_private_key': samlEncryptionPrivateKey,
      if (allowGatewayCallback != null)
        'allow_gateway_callback': allowGatewayCallback,
    };
  }
}

/// Request model for updating a SAML connection by metadata URL.
class UpdateSamlConnectionUrlRequest {
  /// IdP metadata URL.
  final String metadataUrl;

  /// UpdateSamlConnectionUrlRequest
  UpdateSamlConnectionUrlRequest({required this.metadataUrl}) {
    _validateRequired(metadataUrl, 'Metadata URL');
  }

  /// dynamic>
  Map<String, dynamic> toJson() => {'metadata_url': metadataUrl.trim()};
}

/// Request model for creating an OIDC connection.
class CreateOidcConnectionRequest {
  /// Human-readable connection name.
  final String? displayName;

  /// Optional Stytch identity provider hint.
  final String? identityProvider;

  /// CreateOidcConnectionRequest
  const CreateOidcConnectionRequest({this.displayName, this.identityProvider});

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      if (displayName != null) 'display_name': displayName,
      if (identityProvider != null) 'identity_provider': identityProvider,
    };
  }
}

/// Request model for updating an OIDC connection.
class UpdateOidcConnectionRequest {
  /// Human-readable connection name.
  final String? displayName;

  /// OAuth client ID.
  final String? clientId;

  /// OAuth client secret.
  final String? clientSecret;

  /// Issuer URL.
  final String? issuer;

  /// Authorization URL.
  final String? authorizationUrl;

  /// Token URL.
  final String? tokenUrl;

  /// UserInfo URL.
  final String? userinfoUrl;

  /// JWKS URL.
  final String? jwksUrl;

  /// Optional Stytch identity provider hint.
  final String? identityProvider;

  /// Space-separated custom scopes.
  final String? customScopes;

  /// Attribute mapping saved to member Trusted Metadata.
  final Map<String, dynamic>? attributeMapping;

  /// UpdateOidcConnectionRequest
  const UpdateOidcConnectionRequest({
    this.displayName,
    this.clientId,
    this.clientSecret,
    this.issuer,
    this.authorizationUrl,
    this.tokenUrl,
    this.userinfoUrl,
    this.jwksUrl,
    this.identityProvider,
    this.customScopes,
    this.attributeMapping,
  });

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      if (displayName != null) 'display_name': displayName,
      if (clientId != null) 'client_id': clientId,
      if (clientSecret != null) 'client_secret': clientSecret,
      if (issuer != null) 'issuer': issuer,
      if (authorizationUrl != null) 'authorization_url': authorizationUrl,
      if (tokenUrl != null) 'token_url': tokenUrl,
      if (userinfoUrl != null) 'userinfo_url': userinfoUrl,
      if (jwksUrl != null) 'jwks_url': jwksUrl,
      if (identityProvider != null) 'identity_provider': identityProvider,
      if (customScopes != null) 'custom_scopes': customScopes,
      if (attributeMapping != null) 'attribute_mapping': attributeMapping,
    };
  }
}

/// Request model for creating an External SSO connection.
class CreateExternalConnectionRequest {
  /// Organization that owns the underlying SSO connection.
  final String externalOrganizationId;

  /// Underlying SSO connection ID.
  final String externalConnectionId;

  /// Human-readable connection name.
  final String? displayName;

  /// Connection-level implicit role assignments.
  final List<Map<String, dynamic>>? connectionImplicitRoleAssignments;

  /// Group-level implicit role assignments.
  final List<Map<String, dynamic>>? groupImplicitRoleAssignments;

  /// CreateExternalConnectionRequest
  CreateExternalConnectionRequest({
    required this.externalOrganizationId,
    required this.externalConnectionId,
    this.displayName,
    this.connectionImplicitRoleAssignments,
    this.groupImplicitRoleAssignments,
  }) {
    _validateRequired(externalOrganizationId, 'External organization ID');
    _validateRequired(externalConnectionId, 'External connection ID');
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'external_organization_id': externalOrganizationId.trim(),
      'external_connection_id': externalConnectionId.trim(),
      if (displayName != null) 'display_name': displayName,
      if (connectionImplicitRoleAssignments != null)
        'connection_implicit_role_assignments':
            connectionImplicitRoleAssignments,
      if (groupImplicitRoleAssignments != null)
        'group_implicit_role_assignments': groupImplicitRoleAssignments,
    };
  }
}

/// Request model for updating an External SSO connection.
class UpdateExternalConnectionRequest {
  /// Human-readable connection name.
  final String? displayName;

  /// Connection-level implicit role assignments.
  final List<Map<String, dynamic>>? externalConnectionImplicitRoleAssignments;

  /// Group-level implicit role assignments.
  final List<Map<String, dynamic>>? externalGroupImplicitRoleAssignments;

  /// UpdateExternalConnectionRequest
  const UpdateExternalConnectionRequest({
    this.displayName,
    this.externalConnectionImplicitRoleAssignments,
    this.externalGroupImplicitRoleAssignments,
  });

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      if (displayName != null) 'display_name': displayName,
      if (externalConnectionImplicitRoleAssignments != null)
        'external_connection_implicit_role_assignments':
            externalConnectionImplicitRoleAssignments,
      if (externalGroupImplicitRoleAssignments != null)
        'external_group_implicit_role_assignments':
            externalGroupImplicitRoleAssignments,
    };
  }
}

/// Response model for SSO connection create/update endpoints.
class SsoConnectionResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// Connection payload returned by Stytch.
  final Map<String, dynamic> connection;

  /// Optional OIDC metadata warning.
  final String? warning;

  /// SsoConnectionResponse
  const SsoConnectionResponse({
    required this.requestId,
    required this.statusCode,
    required this.connection,
    this.warning,
  });

  /// fromJson
  factory SsoConnectionResponse.fromJson(Map<String, dynamic> json) {
    return SsoConnectionResponse(
      requestId: json['request_id'] as String,
      statusCode: json['status_code'] as int,
      connection: Map<String, dynamic>.from(json['connection'] as Map),
      warning: json['warning'] as String?,
    );
  }
}

/// Response model for deleting a SAML verification certificate.
class DeleteVerificationCertificateResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Deleted certificate ID.
  final String certificateId;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// DeleteVerificationCertificateResponse
  const DeleteVerificationCertificateResponse({
    required this.requestId,
    required this.certificateId,
    required this.statusCode,
  });

  /// fromJson
  factory DeleteVerificationCertificateResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return DeleteVerificationCertificateResponse(
      requestId: json['request_id'] as String,
      certificateId: json['certificate_id'] as String,
      statusCode: json['status_code'] as int,
    );
  }
}

/// Response model for retrieving SSO connections.
class GetSsoConnectionsResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// SAML connections.
  final List<Map<String, dynamic>> samlConnections;

  /// OIDC connections.
  final List<Map<String, dynamic>> oidcConnections;

  /// External connections.
  final List<Map<String, dynamic>> externalConnections;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// GetSsoConnectionsResponse
  const GetSsoConnectionsResponse({
    required this.requestId,
    required this.samlConnections,
    required this.oidcConnections,
    required this.externalConnections,
    required this.statusCode,
  });

  /// fromJson
  factory GetSsoConnectionsResponse.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> mapList(String key) {
      return (json[key] as List<dynamic>? ?? <dynamic>[])
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    }

    return GetSsoConnectionsResponse(
      requestId: json['request_id'] as String,
      samlConnections: mapList('saml_connections'),
      oidcConnections: mapList('oidc_connections'),
      externalConnections: mapList('external_connections'),
      statusCode: json['status_code'] as int,
    );
  }
}

/// Response model for deleting an SSO connection.
class DeleteSsoConnectionResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Deleted connection ID.
  final String connectionId;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// DeleteSsoConnectionResponse
  const DeleteSsoConnectionResponse({
    required this.requestId,
    required this.connectionId,
    required this.statusCode,
  });

  /// fromJson
  factory DeleteSsoConnectionResponse.fromJson(Map<String, dynamic> json) {
    return DeleteSsoConnectionResponse(
      requestId: json['request_id'] as String,
      connectionId: json['connection_id'] as String,
      statusCode: json['status_code'] as int,
    );
  }
}

/// Request model for starting an SSO authentication flow.
class SsoAuthenticateStartRequest {
  /// Public token from the Stytch dashboard.
  final String publicToken;

  /// SSO connection ID to use.
  final String? connectionId;

  /// Organization ID or external ID whose default SSO connection should be used.
  final String? organizationId;

  /// PKCE code challenge.
  final String? pkceCodeChallenge;

  /// Login redirect URL.
  final String? loginRedirectUrl;

  /// Signup redirect URL.
  final String? signupRedirectUrl;

  /// Plus-separated custom scopes.
  final String? customScopes;

  /// SsoAuthenticateStartRequest
  SsoAuthenticateStartRequest({
    required this.publicToken,
    this.connectionId,
    this.organizationId,
    this.pkceCodeChallenge,
    this.loginRedirectUrl,
    this.signupRedirectUrl,
    this.customScopes,
  }) {
    _validateRequired(publicToken, 'Public token');
    final hasConnection =
        connectionId != null && connectionId!.trim().isNotEmpty;
    final hasOrganization =
        organizationId != null && organizationId!.trim().isNotEmpty;
    if (hasConnection == hasOrganization) {
      throw ArgumentError(
        'Provide exactly one connection ID or organization ID.',
      );
    }
  }

  /// String>
  Map<String, String> toQueryParameters() {
    return {
      'public_token': publicToken.trim(),
      if (connectionId != null) 'connection_id': connectionId!.trim(),
      if (organizationId != null) 'organization_id': organizationId!.trim(),
      if (pkceCodeChallenge != null) 'pkce_code_challenge': pkceCodeChallenge!,
      if (loginRedirectUrl != null) 'login_redirect_url': loginRedirectUrl!,
      if (signupRedirectUrl != null) 'signup_redirect_url': signupRedirectUrl!,
      if (customScopes != null) 'custom_scopes': customScopes!,
    };
  }
}

/// Response model for starting an SSO authentication flow.
class SsoAuthenticateStartResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Provider redirect URL.
  final String redirectUrl;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// SsoAuthenticateStartResponse
  const SsoAuthenticateStartResponse({
    required this.requestId,
    required this.redirectUrl,
    required this.statusCode,
  });

  /// fromJson
  factory SsoAuthenticateStartResponse.fromJson(Map<String, dynamic> json) {
    return SsoAuthenticateStartResponse(
      requestId: json['request_id'] as String,
      redirectUrl: json['redirect_url'] as String,
      statusCode: json['status_code'] as int,
    );
  }
}

/// Request model for completing an SSO authentication flow.
class SsoAuthenticateRequest {
  /// SSO token returned to the redirect URL.
  final String ssoToken;

  /// PKCE code verifier.
  final String? pkceCodeVerifier;

  /// Existing session token to link.
  final String? sessionToken;

  /// Existing session JWT to link.
  final String? sessionJwt;

  /// Requested session duration in minutes.
  final int? sessionDurationMinutes;

  /// Custom claims for the resulting session.
  final Map<String, dynamic>? sessionCustomClaims;

  /// Locale for MFA SMS copy.
  final String? locale;

  /// Intermediate session token.
  final String? intermediateSessionToken;

  /// Fingerprint telemetry ID.
  final String? telemetryId;

  /// SsoAuthenticateRequest
  SsoAuthenticateRequest({
    required this.ssoToken,
    this.pkceCodeVerifier,
    this.sessionToken,
    this.sessionJwt,
    this.sessionDurationMinutes,
    this.sessionCustomClaims,
    this.locale,
    this.intermediateSessionToken,
    this.telemetryId,
  }) {
    _validateRequired(ssoToken, 'SSO token');
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'sso_token': ssoToken.trim(),
      if (pkceCodeVerifier != null) 'pkce_code_verifier': pkceCodeVerifier,
      if (sessionToken != null) 'session_token': sessionToken,
      if (sessionJwt != null) 'session_jwt': sessionJwt,
      if (sessionDurationMinutes != null)
        'session_duration_minutes': sessionDurationMinutes,
      if (sessionCustomClaims != null)
        'session_custom_claims': sessionCustomClaims,
      if (locale != null) 'locale': locale,
      if (intermediateSessionToken != null)
        'intermediate_session_token': intermediateSessionToken,
      if (telemetryId != null) 'telemetry_id': telemetryId,
    };
  }
}

/// Response model for completing an SSO authentication flow.
class SsoAuthenticateResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Member ID returned by Stytch.
  final String memberId;

  /// Organization ID returned by Stytch.
  final String organizationId;

  /// Member payload.
  final Map<String, dynamic> member;

  /// Session token returned by Stytch.
  final String? sessionToken;

  /// Session JWT returned by Stytch.
  final String? sessionJwt;

  /// Deprecated reset-session flag.
  final bool? resetSession;

  /// Organization payload.
  final Map<String, dynamic>? organization;

  /// Intermediate session token for MFA.
  final String? intermediateSessionToken;

  /// Whether the member is fully authenticated.
  final bool memberAuthenticated;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// Member session payload.
  final Map<String, dynamic>? memberSession;

  /// MFA requirement payload.
  final Map<String, dynamic>? mfaRequired;

  /// Primary-auth requirement payload.
  final Map<String, dynamic>? primaryRequired;

  /// Member device payload.
  final Map<String, dynamic>? memberDevice;

  /// SsoAuthenticateResponse
  const SsoAuthenticateResponse({
    required this.requestId,
    required this.memberId,
    required this.organizationId,
    required this.member,
    this.sessionToken,
    this.sessionJwt,
    this.resetSession,
    this.organization,
    this.intermediateSessionToken,
    required this.memberAuthenticated,
    required this.statusCode,
    this.memberSession,
    this.mfaRequired,
    this.primaryRequired,
    this.memberDevice,
  });

  /// fromJson
  factory SsoAuthenticateResponse.fromJson(Map<String, dynamic> json) {
    return SsoAuthenticateResponse(
      requestId: json['request_id'] as String,
      memberId: json['member_id'] as String,
      organizationId: json['organization_id'] as String,
      member: Map<String, dynamic>.from(json['member'] as Map),
      sessionToken: json['session_token'] as String?,
      sessionJwt: json['session_jwt'] as String?,
      resetSession: json['reset_session'] as bool?,
      organization: json['organization'] != null
          ? Map<String, dynamic>.from(json['organization'] as Map)
          : null,
      intermediateSessionToken: json['intermediate_session_token'] as String?,
      memberAuthenticated: json['member_authenticated'] as bool,
      statusCode: json['status_code'] as int,
      memberSession: json['member_session'] != null
          ? Map<String, dynamic>.from(json['member_session'] as Map)
          : null,
      mfaRequired: json['mfa_required'] != null
          ? Map<String, dynamic>.from(json['mfa_required'] as Map)
          : null,
      primaryRequired: json['primary_required'] != null
          ? Map<String, dynamic>.from(json['primary_required'] as Map)
          : null,
      memberDevice: json['member_device'] != null
          ? Map<String, dynamic>.from(json['member_device'] as Map)
          : null,
    );
  }
}

/// Response model for OIDC provider registrations.
class GetOidcAccessTokenResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// OIDC provider registrations.
  final List<Map<String, dynamic>> registrations;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// GetOidcAccessTokenResponse
  const GetOidcAccessTokenResponse({
    required this.requestId,
    required this.registrations,
    required this.statusCode,
  });

  /// fromJson
  factory GetOidcAccessTokenResponse.fromJson(Map<String, dynamic> json) {
    return GetOidcAccessTokenResponse(
      requestId: json['request_id'] as String,
      registrations: (json['registrations'] as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(),
      statusCode: json['status_code'] as int,
    );
  }
}
