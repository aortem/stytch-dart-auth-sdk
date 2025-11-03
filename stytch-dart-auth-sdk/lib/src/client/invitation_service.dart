/// Invitation management API service for stytch B2B
import '../models/invitation.dart';
import '../models/error.dart';
import 'stytch_client.dart';

/// Invitation service for stytch B2B API
class InvitationService {
  final StytchHttpClient _httpClient;

  InvitationService(this._httpClient);

  /// Send an invitation to join an organization
  Future<SendInvitationResponse> sendInvitation(
    SendInvitationRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/invitations',
      body: request.toJson(),
    );

    return SendInvitationResponse.fromJson(response);
  }

  /// Get invitation by ID
  Future<Invitation> getInvitation(String invitationId) async {
    final response = await _httpClient.get('/b2b/invitations/$invitationId');
    return Invitation.fromJson(response);
  }

  /// List invitations
  Future<List<Invitation>> listInvitations({
    int limit = 100,
    String? cursor,
    String? organizationId,
  }) async {
    final queryParams = <String, String>{
      'limit': limit.toString(),
      if (cursor != null) 'cursor': cursor,
      if (organizationId != null) 'organization_id': organizationId,
    };

    final response = await _httpClient.get('/b2b/invitations', queryParams);
    final invitationsJson = response['invitations'] as List<dynamic>;
    return invitationsJson
        .map((invJson) => Invitation.fromJson(invJson as Map<String, dynamic>))
        .toList();
  }

  /// Cancel an invitation
  Future<void> cancelInvitation(
    CancelInvitationRequest request,
  ) async {
    await _httpClient.post(
      '/b2b/invitations/${request.invitationId}/cancel',
    );
  }

  /// Accept an invitation
  Future<AcceptInvitationResponse> acceptInvitation(
    AcceptInvitationRequest request,
  ) async {
    final response = await _httpClient.post(
      '/b2b/invitations/accept',
      body: request.toJson(),
    );

    return AcceptInvitationResponse.fromJson(response);
  }

  /// Send bulk invitations
  Future<List<SendInvitationResponse>> sendBulkInvitations(
    List<SendInvitationRequest> requests,
  ) async {
    final response = await _httpClient.post(
      '/b2b/invitations/bulk',
      body: {
        'invitations': requests.map((req) => req.toJson()).toList(),
      },
    );

    final invitationsJson = response['invitations'] as List<dynamic>;
    return invitationsJson
        .map((invJson) => SendInvitationResponse.fromJson(invJson as Map<String, dynamic>))
        .toList();
  }

  /// Get pending invitations for email
  Future<List<Invitation>> getPendingInvitationsForEmail(
    String email,
  ) async {
    final queryParams = <String, String>{
      'email': email,
      'status': 'pending',
    };

    final response = await _httpClient.get('/b2b/invitations', queryParams);
    final invitationsJson = response['invitations'] as List<dynamic>;
    return invitationsJson
        .map((invJson) => Invitation.fromJson(invJson as Map<String, dynamic>))
        .toList();
  }

  /// Resend invitation
  Future<SendInvitationResponse> resendInvitation(
    String invitationId,
  ) async {
    final response = await _httpClient.post(
      '/b2b/invitations/$invitationId/resend',
    );

    return SendInvitationResponse.fromJson(response);
  }
}