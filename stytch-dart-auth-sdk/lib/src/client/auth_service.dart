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
}
