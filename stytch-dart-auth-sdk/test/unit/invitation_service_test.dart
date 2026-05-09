library test_unit_invitation_service_test;

import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() {
  group('InvitationService', () {
    test('sendInviteEmail posts to the Stytch invite endpoint', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = InvitationService(httpClient);

      final response = await service.sendInviteEmail(
        SendInviteEmailRequest(
          organizationId: 'organization-test-123',
          emailAddress: 'invitee@example.com',
          inviteRedirectUrl: 'https://example.com/invite/callback',
          invitedByMemberId: 'member-inviter',
          name: 'Invitee User',
          trustedMetadata: {'department': 'engineering'},
          untrustedMetadata: {'source': 'campaign'},
          inviteTemplateId: 'template_123',
          locale: 'en',
          roles: ['admin'],
          inviteExpirationMinutes: 60,
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/magic_links/email/invite'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'email_address': 'invitee@example.com',
        'invite_redirect_url': 'https://example.com/invite/callback',
        'invited_by_member_id': 'member-inviter',
        'name': 'Invitee User',
        'trusted_metadata': {'department': 'engineering'},
        'untrusted_metadata': {'source': 'campaign'},
        'invite_template_id': 'template_123',
        'locale': 'en',
        'roles': ['admin'],
        'invite_expiration_minutes': 60,
      });
      expect(response.requestId, equals('request-123'));
      expect(response.memberId, equals('member-123'));
      expect(response.statusCode, equals(200));
    });
  });
}

class _RecordingStytchHttpClient extends StytchHttpClient {
  _RecordingStytchHttpClient()
    : super(
        StytchConfig(
          apiKey: 'test-secret',
          projectId: 'project-test-123',
          environment: 'sandbox',
        ),
      );

  String? lastPath;
  Map<String, dynamic>? lastBody;

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    lastPath = path;
    lastBody = body;
    return {
      'request_id': 'request-123',
      'member_id': 'member-123',
      'member': {
        'member_id': 'member-123',
        'email_address': 'invitee@example.com',
      },
      'organization': {
        'organization_id': 'organization-test-123',
        'organization_name': 'Example',
      },
      'status_code': 200,
    };
  }
}
