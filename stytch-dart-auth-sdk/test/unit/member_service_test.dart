library test_unit_member_service_test;

import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() {
  group('MemberService', () {
    test('createMember posts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = MemberService(httpClient);

      final response = await service.createMember(
        'organization-test-123',
        CreateMemberRequest(
          emailAddress: 'member@example.com',
          name: 'Member User',
          externalId: 'external-123',
          mfaPhoneNumber: '+12025550123',
          mfaEnrolled: true,
          trustedMetadata: {'tier': 'admin'},
          untrustedMetadata: {'theme': 'dark'},
          roles: ['admin'],
          createMemberAsPending: true,
          isBreakglass: false,
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/organizations/organization-test-123/members'),
      );
      expect(httpClient.lastBody, {
        'email_address': 'member@example.com',
        'name': 'Member User',
        'external_id': 'external-123',
        'mfa_phone_number': '+12025550123',
        'mfa_enrolled': true,
        'trusted_metadata': {'tier': 'admin'},
        'untrusted_metadata': {'theme': 'dark'},
        'roles': ['admin'],
        'create_member_as_pending': true,
        'is_breakglass': false,
      });
      expect(response.memberId, equals('member-test-123'));
      expect(response.member['email_address'], equals('member@example.com'));
    });

    test('getMember gets by organization and member ID', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = MemberService(httpClient);

      await service.getMember('organization-test-123', 'member-test-123');

      expect(
        httpClient.lastPath,
        equals('/b2b/organizations/organization-test-123/member'),
      );
      expect(httpClient.lastQueryParameters, {'member_id': 'member-test-123'});
    });

    test('getMemberByEmail gets by organization and email address', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = MemberService(httpClient);

      await service.getMemberByEmail(
        'organization-test-123',
        'member@example.com',
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/organizations/organization-test-123/member'),
      );
      expect(httpClient.lastQueryParameters, {
        'email_address': 'member@example.com',
      });
    });

    test('updateMember puts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = MemberService(httpClient);

      await service.updateMember(
        'organization-test-123',
        'member-test-123',
        const UpdateMemberRequest(
          name: 'Updated Member',
          roles: ['viewer'],
          trustedMetadata: {'updated': true},
          preserveExistingSessions: true,
          defaultMfaMethod: 'totp',
          emailAddress: 'updated@example.com',
          unlinkEmail: true,
        ),
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/organizations/organization-test-123/members/member-test-123',
        ),
      );
      expect(httpClient.lastBody, {
        'name': 'Updated Member',
        'trusted_metadata': {'updated': true},
        'roles': ['viewer'],
        'preserve_existing_sessions': true,
        'default_mfa_method': 'totp',
        'email_address': 'updated@example.com',
        'unlink_email': true,
      });
    });

    test('reactivateMember puts to reactivate endpoint', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = MemberService(httpClient);

      await service.reactivateMember(
        'organization-test-123',
        'member-test-123',
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/organizations/organization-test-123/members/member-test-123/reactivate',
        ),
      );
    });

    test('searchMembers posts query and returns metadata', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = MemberService(httpClient);

      final response = await service.searchMembers(
        SearchMembersRequest(
          organizationIds: ['organization-test-123'],
          query: {
            'operator': 'OR',
            'operands': [
              {
                'filter_name': 'member_emails',
                'filter_value': ['member@example.com'],
              },
            ],
          },
          limit: 10,
          cursor: 'cursor-1',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/organizations/members/search'));
      expect(response.members.single['member_id'], equals('member-test-123'));
      expect(response.resultsMetadata.total, equals(1));
      expect(response.resultsMetadata.nextCursor, equals('cursor-2'));
    });

    test('unlinkRetiredMemberEmail posts retired email payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = MemberService(httpClient);

      await service.unlinkRetiredMemberEmail(
        'organization-test-123',
        'member-test-123',
        UnlinkRetiredMemberEmailRequest(emailId: 'email-test-123'),
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/organizations/organization-test-123/members/member-test-123/unlink_retired_email',
        ),
      );
      expect(httpClient.lastBody, {'email_id': 'email-test-123'});
    });

    test('deleteMember deletes by organization and member ID', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = MemberService(httpClient);

      final response = await service.deleteMember(
        'organization-test-123',
        'member-test-123',
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/organizations/organization-test-123/members/member-test-123',
        ),
      );
      expect(response.memberId, equals('member-test-123'));
    });

    test('deleteMemberPassword deletes password endpoint', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = MemberService(httpClient);

      await service.deleteMemberPassword(
        'organization-test-123',
        'password-test-123',
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/organizations/organization-test-123/members/passwords/password-test-123',
        ),
      );
    });

    test('deleteMemberMfaPhoneNumber deletes phone endpoint', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = MemberService(httpClient);

      await service.deleteMemberMfaPhoneNumber(
        'organization-test-123',
        'member-test-123',
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/organizations/organization-test-123/members/mfa_phone_numbers/member-test-123',
        ),
      );
    });

    test('deleteMemberMfaTotp deletes TOTP endpoint', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = MemberService(httpClient);

      await service.deleteMemberMfaTotp(
        'organization-test-123',
        'member-test-123',
      );

      expect(
        httpClient.lastPath,
        equals(
          '/b2b/organizations/organization-test-123/members/member-test-123/totp',
        ),
      );
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
  Map<String, String>? lastQueryParameters;

  @override
  Future<Map<String, dynamic>> get(
    String path, [
    Map<String, String>? queryParameters,
  ]) async {
    lastPath = path;
    lastQueryParameters = queryParameters;
    return _memberResponse();
  }

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    lastPath = path;
    lastBody = body;
    if (path == '/b2b/organizations/members/search') {
      return {
        'request_id': 'request-123',
        'members': [_memberJson()],
        'results_metadata': {'total': 1, 'next_cursor': 'cursor-2'},
        'organizations': {
          'organization-test-123': {'organization_id': 'organization-test-123'},
        },
        'status_code': 200,
      };
    }
    return _memberResponse();
  }

  @override
  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    lastPath = path;
    lastBody = body;
    return _memberResponse();
  }

  @override
  Future<Map<String, dynamic>> delete(String path) async {
    lastPath = path;
    if (path.endsWith('/member-test-123') &&
        !path.contains('mfa_phone_numbers')) {
      return {
        'request_id': 'request-123',
        'member_id': 'member-test-123',
        'status_code': 200,
      };
    }
    return _memberResponse();
  }
}

Map<String, dynamic> _memberResponse() {
  return {
    'request_id': 'request-123',
    'member_id': 'member-test-123',
    'member': _memberJson(),
    'organization': {'organization_id': 'organization-test-123'},
    'status_code': 200,
  };
}

Map<String, dynamic> _memberJson() {
  return {
    'organization_id': 'organization-test-123',
    'member_id': 'member-test-123',
    'email_address': 'member@example.com',
    'status': 'active',
    'name': 'Member User',
  };
}
