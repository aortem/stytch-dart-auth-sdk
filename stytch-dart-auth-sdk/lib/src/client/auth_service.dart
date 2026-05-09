library auth_service;

/// Authentication API service for stytch B2B
import '../models/auth.dart';
import '../models/error.dart';
import 'stytch_client.dart';

/// Authentication service for stytch B2B API
class AuthService {
  /// StytchHttpClient
  final StytchHttpClient _httpClient;

  /// HTTP client for making API requests
  AuthService(
    /// HTTP client instance
    this._httpClient,
  );

  /// Login with email and password
  Future<AuthResponse> loginWithEmailPassword(
    EmailPasswordLoginRequest request,
  ) async {
    /// response
    final response = await _httpClient.post(
      '/b2b/auth/token/password',
      body: request.toJson(),
    );

    return AuthResponse.fromJson(response);
  }

  /// Authenticate a member with an email address and password.
  Future<AuthenticateMagicLinkResponse> authenticatePassword(
    PasswordAuthenticateRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/passwords/authenticate',
      body: request.toJson(),
    );

    return AuthenticateMagicLinkResponse.fromJson(response);
  }

  /// Authenticate an email and password in the discovery flow.
  Future<AuthenticateDiscoveryResponse> authenticateDiscoveryPassword(
    PasswordDiscoveryAuthenticateRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/passwords/discovery/authenticate',
      body: request.toJson(),
    );

    return AuthenticateDiscoveryResponse.fromJson(response);
  }

  /// Check password strength against the Stytch project policy.
  Future<PasswordStrengthCheckResponse> strengthCheckPassword(
    PasswordStrengthCheckRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/passwords/strength_check',
      body: request.toJson(),
    );

    return PasswordStrengthCheckResponse.fromJson(response);
  }

  /// Migrate an existing password hash to Stytch.
  Future<PasswordMigrateResponse> migratePassword(
    PasswordMigrateRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/passwords/migrate',
      body: request.toJson(),
    );

    return PasswordMigrateResponse.fromJson(response);
  }

  /// Start an organization password reset by email.
  Future<PasswordEmailResetStartResponse> startPasswordEmailReset(
    PasswordEmailResetStartRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/passwords/email/reset/start',
      body: request.toJson(),
    );

    return PasswordEmailResetStartResponse.fromJson(response);
  }

  /// Reset an organization password with an email reset token.
  Future<AuthenticateMagicLinkResponse> resetPasswordByEmail(
    PasswordEmailResetRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/passwords/email/reset',
      body: request.toJson(),
    );

    return AuthenticateMagicLinkResponse.fromJson(response);
  }

  /// Reset an organization password with the member's existing password.
  Future<AuthenticateMagicLinkResponse> resetPasswordByExistingPassword(
    PasswordExistingPasswordResetRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/passwords/existing_password/reset',
      body: request.toJson(),
    );

    return AuthenticateMagicLinkResponse.fromJson(response);
  }

  /// Reset an organization password with a recent member session.
  Future<AuthenticateMagicLinkResponse> resetPasswordBySession(
    PasswordSessionResetRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/passwords/session/reset',
      body: request.toJson(),
    );

    return AuthenticateMagicLinkResponse.fromJson(response);
  }

  /// Start a discovery password reset by email.
  Future<PasswordDiscoveryEmailResetStartResponse>
  startDiscoveryPasswordEmailReset(
    PasswordDiscoveryEmailResetStartRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/passwords/discovery/email/reset/start',
      body: request.toJson(),
    );

    return PasswordDiscoveryEmailResetStartResponse.fromJson(response);
  }

  /// Reset a discovery password with an email reset token.
  Future<AuthenticateDiscoveryResponse> resetDiscoveryPasswordByEmail(
    PasswordDiscoveryEmailResetRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/passwords/discovery/email/reset',
      body: request.toJson(),
    );

    return AuthenticateDiscoveryResponse.fromJson(response);
  }

  /// Require a password reset for an email address.
  Future<PasswordRequireResetByEmailResponse> requirePasswordResetByEmail(
    PasswordRequireResetByEmailRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/passwords/email/require_reset',
      body: request.toJson(),
    );

    return PasswordRequireResetByEmailResponse.fromJson(response);
  }

  /// Send an SMS OTP to a member for MFA.
  Future<MfaMemberResponse> otpSmsSend(OtpSmsSendRequest request) async {
    final response = await _httpClient.post(
      '/b2b/otps/sms/send',
      body: request.toJson(),
    );

    return MfaMemberResponse.fromJson(response);
  }

  /// Authenticate an SMS OTP for MFA.
  Future<AuthenticateMagicLinkResponse> authenticateOtpSms(
    OtpSmsAuthenticateRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/otps/sms/authenticate',
      body: request.toJson(),
    );

    return AuthenticateMagicLinkResponse.fromJson(response);
  }

  /// Create a TOTP registration for a member.
  Future<TotpCreateResponse> totpCreate(TotpCreateRequest request) async {
    final response = await _httpClient.post(
      '/b2b/totp',
      body: request.toJson(),
    );

    return TotpCreateResponse.fromJson(response);
  }

  /// Authenticate a TOTP code for MFA.
  Future<AuthenticateMagicLinkResponse> authenticateTotp(
    TotpAuthenticateRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/totp/authenticate',
      body: request.toJson(),
    );

    return AuthenticateMagicLinkResponse.fromJson(response);
  }

  /// Migrate an existing TOTP registration for a member.
  Future<TotpMigrateResponse> totpMigrate(TotpMigrateRequest request) async {
    final response = await _httpClient.post(
      '/b2b/totp/migrate',
      body: request.toJson(),
    );

    return TotpMigrateResponse.fromJson(response);
  }

  /// Get active recovery codes for a member.
  Future<RecoveryCodesResponse> recoveryCodesGet(
    RecoveryCodesGetRequest request,
  ) async {
    final response = await _httpClient.get(
      '/b2b/recovery_codes/${request.organizationId.trim()}/${request.memberId.trim()}',
    );

    return RecoveryCodesResponse.fromJson(response);
  }

  /// Recover a member session with a recovery code.
  Future<AuthenticateMagicLinkResponse> recoveryCodesRecover(
    RecoveryCodesRecoverRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/recovery_codes/recover',
      body: request.toJson(),
    );

    return AuthenticateMagicLinkResponse.fromJson(response);
  }

  /// Rotate active recovery codes for a member.
  Future<RecoveryCodesResponse> recoveryCodesRotate(
    RecoveryCodesRotateRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/recovery_codes/rotate',
      body: request.toJson(),
    );

    return RecoveryCodesResponse.fromJson(response);
  }

  /// Login with SSO token
  Future<AuthResponse> loginWithSso(SsoLoginRequest request) async {
    /// response
    final response = await _httpClient.post(
      '/b2b/auth/token/sso',
      body: request.toJson(),
    );

    return AuthResponse.fromJson(response);
  }

  /// Send a discovery Email Magic Link.
  Future<SendDiscoveryEmailResponse> sendDiscoveryEmail(
    SendDiscoveryEmailRequest request,
  ) async {
    /// response
    final response = await _httpClient.post(
      '/b2b/magic_links/email/discovery/send',
      body: request.toJson(),
    );

    return SendDiscoveryEmailResponse.fromJson(response);
  }

  /// Send a login or signup Email Magic Link to an organization member.
  Future<SendLoginSignupEmailResponse> sendLoginSignupEmail(
    SendLoginSignupEmailRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/magic_links/email/login_or_signup',
      body: request.toJson(),
    );

    return SendLoginSignupEmailResponse.fromJson(response);
  }

  /// Authenticate an organization Email Magic Link token.
  Future<AuthenticateMagicLinkResponse> authenticateMagicLink(
    AuthenticateMagicLinkRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/magic_links/authenticate',
      body: request.toJson(),
    );

    return AuthenticateMagicLinkResponse.fromJson(response);
  }

  /// Authenticate a discovery Email Magic Link token.
  Future<AuthenticateDiscoveryResponse> authenticateDiscoveryMagicLink(
    AuthenticateDiscoveryMagicLinkRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/magic_links/discovery/authenticate',
      body: request.toJson(),
    );

    return AuthenticateDiscoveryResponse.fromJson(response);
  }

  /// Send a login or signup Email OTP to an organization member.
  Future<SendLoginSignupEmailOtpResponse> sendLoginSignupEmailOtp(
    SendLoginSignupEmailOtpRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/otps/email/login_or_signup',
      body: request.toJson(),
    );

    return SendLoginSignupEmailOtpResponse.fromJson(response);
  }

  /// Authenticate an organization Email OTP.
  Future<AuthenticateEmailOtpResponse> authenticateEmailOtp(
    AuthenticateEmailOtpRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/otps/email/authenticate',
      body: request.toJson(),
    );

    return AuthenticateEmailOtpResponse.fromJson(response);
  }

  /// Send a discovery Email OTP.
  Future<SendDiscoveryEmailOtpResponse> sendDiscoveryEmailOtp(
    SendDiscoveryEmailOtpRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/otps/email/discovery/send',
      body: request.toJson(),
    );

    return SendDiscoveryEmailOtpResponse.fromJson(response);
  }

  /// Authenticate a discovery Email OTP.
  Future<AuthenticateDiscoveryResponse> authenticateDiscoveryEmailOtp(
    AuthenticateDiscoveryEmailOtpRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/otps/email/discovery/authenticate',
      body: request.toJson(),
    );

    return AuthenticateDiscoveryResponse.fromJson(response);
  }

  /// Create a new organization and member through the discovery flow.
  Future<ExchangeSessionResponse> createOrganizationViaDiscovery(
    CreateOrganizationViaDiscoveryRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/discovery/organizations/create',
      body: request.toJson(),
    );

    return ExchangeSessionResponse.fromJson(response);
  }

  /// List organizations connected to a session or intermediate session.
  Future<ListDiscoveredOrganizationsResponse> listDiscoveredOrganizations(
    ListDiscoveredOrganizationsRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/discovery/organizations',
      body: request.toJson(),
    );

    return ListDiscoveredOrganizationsResponse.fromJson(response);
  }

  /// Exchange an intermediate session into a target organization session.
  Future<ExchangeSessionResponse> exchangeIntermediateSession(
    ExchangeIntermediateSessionRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/discovery/intermediate_sessions/exchange',
      body: request.toJson(),
    );

    return ExchangeSessionResponse.fromJson(response);
  }

  /// Start a Google OAuth discovery flow.
  Future<OAuthDiscoveryStartResponse> oauthGoogleDiscoveryStart(
    OAuthDiscoveryStartRequest request,
  ) async {
    return _oauthDiscoveryStart('google', request);
  }

  /// Start a Microsoft OAuth discovery flow.
  Future<OAuthDiscoveryStartResponse> oauthMicrosoftDiscoveryStart(
    OAuthDiscoveryStartRequest request,
  ) async {
    return _oauthDiscoveryStart('microsoft', request);
  }

  Future<OAuthDiscoveryStartResponse> _oauthDiscoveryStart(
    String provider,
    OAuthDiscoveryStartRequest request,
  ) async {
    final response = await _httpClient.get(
      '/b2b/public/oauth/$provider/discovery/start',
      request.toQueryParameters(),
    );

    return OAuthDiscoveryStartResponse.fromJson(response);
  }

  /// Start MFA process
  Future<MfaResponse> startMfa(MfaRequest request) async {
    /// response
    final response = await _httpClient.post(
      '/b2b/auth/mfa/begin',
      body: request.toJson(),
    );

    return MfaResponse.fromJson(response);
  }

  /// Complete MFA authentication
  Future<AuthResponse> completeMfa(MfaRequest request) async {
    /// response
    final response = await _httpClient.post(
      '/b2b/auth/mfa/complete',
      body: request.toJson(),
    );

    return AuthResponse.fromJson(response);
  }

  /// Create a new session
  Future<CreateSessionResponse> createSession(
    CreateSessionRequest request,
  ) async {
    /// response
    final response = await _httpClient.post(
      '/b2b/sessions',
      body: request.toJson(),
    );

    return CreateSessionResponse.fromJson(response);
  }

  /// Validate a session token
  Future<ValidateSessionResponse> validateSession(
    ValidateSessionRequest request,
  ) async {
    /// response
    final response = await _httpClient.post(
      '/b2b/sessions/authenticate',
      body: request.toJson(),
    );

    return ValidateSessionResponse.fromJson(response);
  }

  /// Retrieve active sessions for a member.
  Future<GetSessionsResponse> getSession(GetSessionsRequest request) async {
    final response = await _httpClient.get(
      '/b2b/sessions',
      request.toQueryParameters(),
    );

    return GetSessionsResponse.fromJson(response);
  }

  /// Authenticate a session token or session JWT.
  Future<AuthenticateSessionResponse> authenticateSession(
    AuthenticateSessionRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/sessions/authenticate',
      body: request.toJson(),
    );

    return AuthenticateSessionResponse.fromJson(response);
  }

  /// Revoke a session by member session ID.
  Future<RevokeSessionResponse> revokeSession(String memberSessionId) async {
    return revokeSessionWithRequest(
      RevokeSessionRequest(memberSessionId: memberSessionId),
    );
  }

  /// Revoke a session by any Stytch-supported session identifier.
  Future<RevokeSessionResponse> revokeSessionWithRequest(
    RevokeSessionRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/sessions/revoke',
      body: request.toJson(),
    );

    return RevokeSessionResponse.fromJson(response);
  }

  /// Revoke all sessions for a user
  Future<void> revokeAllUserSessions(String userId) async {
    await _httpClient.delete('/b2b/users/$userId/sessions');
  }

  /// Exchange a session into another organization.
  Future<ExchangeSessionResponse> exchangeSession(
    ExchangeSessionRequest request,
  ) async {
    /// response
    final response = await _httpClient.post(
      '/b2b/sessions/exchange',
      body: request.toJson(),
    );

    return ExchangeSessionResponse.fromJson(response);
  }

  /// Authenticate a B2B impersonation token.
  Future<AuthenticateImpersonationTokenResponse> authenticateImpersonationToken(
    AuthenticateImpersonationTokenRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/impersonation/authenticate',
      body: request.toJson(),
    );

    return AuthenticateImpersonationTokenResponse.fromJson(response);
  }

  /// Migrate a session from an external OIDC-compliant provider.
  Future<MigrateSessionResponse> migrateSession(
    MigrateSessionRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/sessions/migrate',
      body: request.toJson(),
    );

    return MigrateSessionResponse.fromJson(response);
  }

  /// Get the JSON Web Key Set used to validate Stytch session JWTs.
  Future<JwksResponse> getJWKS() async {
    final response = await _httpClient.get(
      '/sessions/jwks/${_httpClient.config.projectId}',
    );

    return JwksResponse.fromJson(response);
  }
}
