/// Authentication API service for stytch B2B
import '../models/auth.dart';
import '../models/error.dart';
import 'stytch_client.dart';

/// Authentication service for stytch B2B API
class AuthService {
  final StytchHttpClient _httpClient;

  AuthService(this._httpClient);

  /// Login with email and password
  Future<AuthResponse> loginWithEmailPassword(
    EmailPasswordLoginRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/auth/token/password',
      body: request.toJson(),
    );

    return AuthResponse.fromJson(response);
  }

  /// Login with SSO token
  Future<AuthResponse> loginWithSso(
    SsoLoginRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/auth/token/sso',
      body: request.toJson(),
    );

    return AuthResponse.fromJson(response);
  }

  /// Start MFA process
  Future<MfaResponse> startMfa(
    MfaRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/auth/mfa/begin',
      body: request.toJson(),
    );

    return MfaResponse.fromJson(response);
  }

  /// Complete MFA authentication
  Future<AuthResponse> completeMfa(
    MfaRequest request,
  ) async {
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
    final response = await _httpClient.post(
      '/b2b/sessions/authenticate',
      body: request.toJson(),
    );

    return ValidateSessionResponse.fromJson(response);
  }

  /// Revoke a session
  Future<void> revokeSession(String sessionId) async {
    await _httpClient.delete('/b2b/sessions/$sessionId');
  }

  /// Revoke all sessions for a user
  Future<void> revokeAllUserSessions(String userId) async {
    await _httpClient.delete('/b2b/users/$userId/sessions');
  }

  /// Exchange a session for a new one
  Future<CreateSessionResponse> exchangeSession(
    String sessionToken,
    Map<String, dynamic>? attributes,
  ) async {
    final response = await _httpClient.post(
      '/b2b/sessions/exchange',
      body: {
        'session_token': sessionToken,
        if (attributes != null) 'attributes': attributes,
      },
    );

    return CreateSessionResponse.fromJson(response);
  }
}