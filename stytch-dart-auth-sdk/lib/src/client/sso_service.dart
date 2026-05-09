library sso_service;

import '../models/sso.dart';
import 'stytch_client.dart';

/// Single sign-on service for the Stytch B2B API.
class SsoService {
  /// HTTP client for making API requests.
  final StytchHttpClient _httpClient;

  /// SsoService
  SsoService(this._httpClient);

  /// Create a SAML connection.
  Future<SsoConnectionResponse> createSamlConnection(
    String organizationId,
    CreateSamlConnectionRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/sso/saml/$organizationId',
      body: request.toJson(),
    );
    return SsoConnectionResponse.fromJson(response);
  }

  /// Update a SAML connection.
  Future<SsoConnectionResponse> updateSamlConnection(
    String organizationId,
    String connectionId,
    UpdateSamlConnectionRequest request,
  ) async {
    final response = await _httpClient.put(
      '/b2b/sso/saml/$organizationId/connections/$connectionId',
      body: request.toJson(),
    );
    return SsoConnectionResponse.fromJson(response);
  }

  /// Update a SAML connection from an IdP metadata URL.
  Future<SsoConnectionResponse> updateSamlConnectionUrl(
    String organizationId,
    String connectionId,
    UpdateSamlConnectionUrlRequest request,
  ) async {
    final response = await _httpClient.put(
      '/b2b/sso/saml/$organizationId/connections/$connectionId/url',
      body: request.toJson(),
    );
    return SsoConnectionResponse.fromJson(response);
  }

  /// Delete a SAML verification certificate.
  Future<DeleteVerificationCertificateResponse> deleteVerificationCertificate(
    String organizationId,
    String connectionId,
    String certificateId,
  ) async {
    final response = await _httpClient.delete(
      '/b2b/sso/saml/$organizationId/connections/$connectionId/verification_certificates/$certificateId',
    );
    return DeleteVerificationCertificateResponse.fromJson(response);
  }

  /// Create an OIDC connection.
  Future<SsoConnectionResponse> createOidcConnection(
    String organizationId,
    CreateOidcConnectionRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/sso/oidc/$organizationId',
      body: request.toJson(),
    );
    return SsoConnectionResponse.fromJson(response);
  }

  /// Update an OIDC connection.
  Future<SsoConnectionResponse> updateOidcConnection(
    String organizationId,
    String connectionId,
    UpdateOidcConnectionRequest request,
  ) async {
    final response = await _httpClient.put(
      '/b2b/sso/oidc/$organizationId/connections/$connectionId',
      body: request.toJson(),
    );
    return SsoConnectionResponse.fromJson(response);
  }

  /// Retrieve saved OIDC access tokens for a member.
  Future<GetOidcAccessTokenResponse> getOidcAccessToken(
    String organizationId,
    String memberId,
  ) async {
    final response = await _httpClient.get(
      '/b2b/organizations/$organizationId/members/$memberId/oidc_providers',
    );
    return GetOidcAccessTokenResponse.fromJson(response);
  }

  /// Create an External SSO connection.
  Future<SsoConnectionResponse> createExternalConnection(
    String organizationId,
    CreateExternalConnectionRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/sso/external/$organizationId',
      body: request.toJson(),
    );
    return SsoConnectionResponse.fromJson(response);
  }

  /// Update an External SSO connection.
  Future<SsoConnectionResponse> updateExternalConnection(
    String organizationId,
    String connectionId,
    UpdateExternalConnectionRequest request,
  ) async {
    final response = await _httpClient.put(
      '/b2b/sso/external/$organizationId/connections/$connectionId',
      body: request.toJson(),
    );
    return SsoConnectionResponse.fromJson(response);
  }

  /// Retrieve all SSO connections for an organization.
  Future<GetSsoConnectionsResponse> getSsoConnections(
    String organizationId,
  ) async {
    final response = await _httpClient.get('/b2b/sso/$organizationId');
    return GetSsoConnectionsResponse.fromJson(response);
  }

  /// Delete an SSO connection.
  Future<DeleteSsoConnectionResponse> deleteSsoConnection(
    String organizationId,
    String connectionId,
  ) async {
    final response = await _httpClient.delete(
      '/b2b/sso/$organizationId/connections/$connectionId',
    );
    return DeleteSsoConnectionResponse.fromJson(response);
  }

  /// Start an SSO authentication flow.
  Future<SsoAuthenticateStartResponse> ssoAuthenticateStart(
    SsoAuthenticateStartRequest request,
  ) async {
    final response = await _httpClient.get(
      '/public/sso/start',
      request.toQueryParameters(),
    );
    return SsoAuthenticateStartResponse.fromJson(response);
  }

  /// Complete an SSO authentication flow.
  Future<SsoAuthenticateResponse> ssoAuthenticate(
    SsoAuthenticateRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/sso/authenticate',
      body: request.toJson(),
    );
    return SsoAuthenticateResponse.fromJson(response);
  }
}
