library member_service;

import '../models/member.dart';
import 'stytch_client.dart';

/// Member management service for the Stytch B2B API.
class MemberService {
  /// HTTP client for making API requests.
  final StytchHttpClient _httpClient;

  /// MemberService
  MemberService(this._httpClient);

  /// Create a member in an organization.
  Future<MemberResponse> createMember(
    String organizationId,
    CreateMemberRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/organizations/$organizationId/members',
      body: request.toJson(),
    );
    return MemberResponse.fromJson(response);
  }

  /// Get a member by organization and member ID.
  Future<MemberResponse> getMember(
    String organizationId,
    String memberId,
  ) async {
    final response = await _httpClient.get(
      '/b2b/organizations/$organizationId/member',
      {'member_id': memberId},
    );
    return MemberResponse.fromJson(response);
  }

  /// Get a member by organization and email address.
  Future<MemberResponse> getMemberByEmail(
    String organizationId,
    String emailAddress,
  ) async {
    final response = await _httpClient.get(
      '/b2b/organizations/$organizationId/member',
      {'email_address': emailAddress},
    );
    return MemberResponse.fromJson(response);
  }

  /// Retrieve a member's saved HubSpot OAuth access token registrations.
  Future<OAuthProviderAccessTokenResponse> getHubspotAccessToken(
    String organizationId,
    String memberId, {
    bool? includeRefreshToken,
  }) async {
    final response = await _httpClient.get(
      '/b2b/organizations/$organizationId/members/$memberId/oauth_providers/hubspot',
      _includeRefreshTokenQuery(includeRefreshToken),
    );
    return OAuthProviderAccessTokenResponse.fromJson(response);
  }

  /// Retrieve a member's saved Slack OAuth access token registrations.
  Future<OAuthProviderAccessTokenResponse> getSlackAccessToken(
    String organizationId,
    String memberId,
  ) async {
    final response = await _httpClient.get(
      '/b2b/organizations/$organizationId/members/$memberId/oauth_providers/slack',
    );
    return OAuthProviderAccessTokenResponse.fromJson(response);
  }

  /// Retrieve a member's saved GitHub OAuth access token registrations.
  Future<OAuthProviderAccessTokenResponse> getGithubAccessToken(
    String organizationId,
    String memberId, {
    bool? includeRefreshToken,
  }) async {
    final response = await _httpClient.get(
      '/b2b/organizations/$organizationId/members/$memberId/oauth_providers/github',
      _includeRefreshTokenQuery(includeRefreshToken),
    );
    return OAuthProviderAccessTokenResponse.fromJson(response);
  }

  /// Update a member.
  Future<MemberResponse> updateMember(
    String organizationId,
    String memberId,
    UpdateMemberRequest request,
  ) async {
    final response = await _httpClient.put(
      '/b2b/organizations/$organizationId/members/$memberId',
      body: request.toJson(),
    );
    return MemberResponse.fromJson(response);
  }

  /// Reactivate a deleted member.
  Future<MemberResponse> reactivateMember(
    String organizationId,
    String memberId,
  ) async {
    final response = await _httpClient.put(
      '/b2b/organizations/$organizationId/members/$memberId/reactivate',
    );
    return MemberResponse.fromJson(response);
  }

  /// Search members across organizations.
  Future<SearchMembersResponse> searchMembers(
    SearchMembersRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/organizations/members/search',
      body: request.toJson(),
    );
    return SearchMembersResponse.fromJson(response);
  }

  /// Unlink a retired member email.
  Future<MemberResponse> unlinkRetiredMemberEmail(
    String organizationId,
    String memberId,
    UnlinkRetiredMemberEmailRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/organizations/$organizationId/members/$memberId/unlink_retired_email',
      body: request.toJson(),
    );
    return MemberResponse.fromJson(response);
  }

  /// Delete a member.
  Future<DeleteMemberResponse> deleteMember(
    String organizationId,
    String memberId,
  ) async {
    final response = await _httpClient.delete(
      '/b2b/organizations/$organizationId/members/$memberId',
    );
    return DeleteMemberResponse.fromJson(response);
  }

  /// Delete a member password.
  Future<MemberResponse> deleteMemberPassword(
    String organizationId,
    String memberPasswordId,
  ) async {
    final response = await _httpClient.delete(
      '/b2b/organizations/$organizationId/members/passwords/$memberPasswordId',
    );
    return MemberResponse.fromJson(response);
  }

  /// Delete a member MFA phone number.
  Future<MemberResponse> deleteMemberMfaPhoneNumber(
    String organizationId,
    String memberId,
  ) async {
    final response = await _httpClient.delete(
      '/b2b/organizations/$organizationId/members/mfa_phone_numbers/$memberId',
    );
    return MemberResponse.fromJson(response);
  }

  /// Delete a member MFA TOTP registration.
  Future<MemberResponse> deleteMemberMfaTotp(
    String organizationId,
    String memberId,
  ) async {
    final response = await _httpClient.delete(
      '/b2b/organizations/$organizationId/members/$memberId/totp',
    );
    return MemberResponse.fromJson(response);
  }

  Map<String, String>? _includeRefreshTokenQuery(bool? includeRefreshToken) {
    if (includeRefreshToken == null) {
      return null;
    }
    return {'include_refresh_token': includeRefreshToken.toString()};
  }
}
