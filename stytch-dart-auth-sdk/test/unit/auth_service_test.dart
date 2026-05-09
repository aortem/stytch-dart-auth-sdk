library test_unit_auth_service_test;

import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() {
  group('AuthService', () {
    test('authenticatePassword posts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.authenticatePassword(
        PasswordAuthenticateRequest(
          organizationId: 'organization-test-123',
          emailAddress: 'member@example.com',
          password: 'correct-password',
          sessionToken: 'session-token',
          sessionDurationMinutes: 60,
          sessionCustomClaims: {'tier': 'gold'},
          locale: 'en',
          intermediateSessionToken: 'intermediate-token',
          telemetryId: 'telemetry-123',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/passwords/authenticate'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'email_address': 'member@example.com',
        'password': 'correct-password',
        'session_token': 'session-token',
        'session_duration_minutes': 60,
        'session_custom_claims': {'tier': 'gold'},
        'locale': 'en',
        'intermediate_session_token': 'intermediate-token',
        'telemetry_id': 'telemetry-123',
      });
      expect(response.requestId, equals('request-123'));
      expect(response.memberId, equals('member-123'));
      expect(response.organizationId, equals('organization-test-123'));
      expect(response.sessionToken, equals('session-token'));
      expect(response.memberAuthenticated, isTrue);
      expect(response.statusCode, equals(200));
    });

    test(
      'authenticateDiscoveryPassword posts discovery password payload',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = AuthService(httpClient);

        final response = await service.authenticateDiscoveryPassword(
          PasswordDiscoveryAuthenticateRequest(
            emailAddress: 'prospect@example.com',
            password: 'correct-password',
          ),
        );

        expect(
          httpClient.lastPath,
          equals('/b2b/passwords/discovery/authenticate'),
        );
        expect(httpClient.lastBody, {
          'email_address': 'prospect@example.com',
          'password': 'correct-password',
        });
        expect(response.requestId, equals('request-123'));
        expect(response.emailAddress, equals('prospect@example.com'));
        expect(response.intermediateSessionToken, equals('intermediate-token'));
        expect(response.discoveredOrganizations.single['membership'], {
          'type': 'active_member',
        });
      },
    );

    test('strengthCheckPassword posts strength check payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.strengthCheckPassword(
        PasswordStrengthCheckRequest(
          password: 'correct-password',
          emailAddress: 'member@example.com',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/passwords/strength_check'));
      expect(httpClient.lastBody, {
        'password': 'correct-password',
        'email_address': 'member@example.com',
      });
      expect(response.requestId, equals('request-123'));
      expect(response.validPassword, isTrue);
      expect(response.score, equals(4));
      expect(response.breachedPassword, isFalse);
      expect(response.strengthPolicy, equals('zxcvbn'));
      expect(response.breachDetectionOnCreate, isTrue);
      expect(response.zxcvbnFeedback?['suggestions'], ['Keep it memorable']);
      expect(response.statusCode, equals(200));
    });

    test('migratePassword posts current password migrate payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.migratePassword(
        PasswordMigrateRequest(
          emailAddress: 'member@example.com',
          hash: r'$2a$10$abcdefghijklmnopqrstuu',
          hashType: 'bcrypt',
          organizationId: 'organization-test-123',
          trustedMetadata: {'source': 'legacy'},
          roles: ['admin'],
          preserveExistingSessions: true,
          externalId: 'external-member-123',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/passwords/migrate'));
      expect(httpClient.lastBody, {
        'email_address': 'member@example.com',
        'hash': r'$2a$10$abcdefghijklmnopqrstuu',
        'hash_type': 'bcrypt',
        'organization_id': 'organization-test-123',
        'trusted_metadata': {'source': 'legacy'},
        'roles': ['admin'],
        'preserve_existing_sessions': true,
        'external_id': 'external-member-123',
      });
      expect(response.requestId, equals('request-123'));
      expect(response.memberId, equals('member-123'));
      expect(response.memberCreated, isTrue);
      expect(response.organization['organization_id'], 'organization-test-123');
      expect(response.statusCode, equals(200));
    });

    test('startPasswordEmailReset posts reset start payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.startPasswordEmailReset(
        PasswordEmailResetStartRequest(
          organizationId: 'organization-test-123',
          emailAddress: 'member@example.com',
          resetPasswordRedirectUrl: 'https://example.com/reset',
          resetPasswordExpirationMinutes: 30,
          codeChallenge: 'code-challenge',
          loginRedirectUrl: 'https://example.com/login',
          locale: 'en',
          resetPasswordTemplateId: 'reset-template',
          verifyEmailTemplateId: 'verify-template',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/passwords/email/reset/start'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'email_address': 'member@example.com',
        'reset_password_redirect_url': 'https://example.com/reset',
        'reset_password_expiration_minutes': 30,
        'code_challenge': 'code-challenge',
        'login_redirect_url': 'https://example.com/login',
        'locale': 'en',
        'reset_password_template_id': 'reset-template',
        'verify_email_template_id': 'verify-template',
      });
      expect(response.requestId, equals('request-123'));
      expect(response.memberId, equals('member-123'));
      expect(response.memberEmailId, equals('email-123'));
      expect(response.member['email_address'], 'member@example.com');
    });

    test('resetPasswordByEmail posts email reset payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.resetPasswordByEmail(
        PasswordEmailResetRequest(
          passwordResetToken: 'password-reset-token',
          password: 'new-password',
          sessionJwt: 'session-jwt',
          sessionDurationMinutes: 60,
          codeVerifier: 'code-verifier',
          sessionCustomClaims: {'tier': 'gold'},
          locale: 'en',
          intermediateSessionToken: 'intermediate-token',
          telemetryId: 'telemetry-123',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/passwords/email/reset'));
      expect(httpClient.lastBody, {
        'password_reset_token': 'password-reset-token',
        'password': 'new-password',
        'session_jwt': 'session-jwt',
        'session_duration_minutes': 60,
        'code_verifier': 'code-verifier',
        'session_custom_claims': {'tier': 'gold'},
        'locale': 'en',
        'intermediate_session_token': 'intermediate-token',
        'telemetry_id': 'telemetry-123',
      });
      expect(response.memberId, equals('member-123'));
      expect(response.sessionToken, equals('session-token'));
      expect(response.memberAuthenticated, isTrue);
    });

    test(
      'resetPasswordByExistingPassword posts existing reset payload',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = AuthService(httpClient);

        final response = await service.resetPasswordByExistingPassword(
          PasswordExistingPasswordResetRequest(
            emailAddress: 'member@example.com',
            existingPassword: 'old-password',
            newPassword: 'new-password',
            organizationId: 'organization-test-123',
            sessionToken: 'session-token',
            sessionDurationMinutes: 60,
            sessionCustomClaims: {'tier': 'gold'},
            locale: 'en',
            telemetryId: 'telemetry-123',
          ),
        );

        expect(
          httpClient.lastPath,
          equals('/b2b/passwords/existing_password/reset'),
        );
        expect(httpClient.lastBody, {
          'email_address': 'member@example.com',
          'existing_password': 'old-password',
          'new_password': 'new-password',
          'organization_id': 'organization-test-123',
          'session_token': 'session-token',
          'session_duration_minutes': 60,
          'session_custom_claims': {'tier': 'gold'},
          'locale': 'en',
          'telemetry_id': 'telemetry-123',
        });
        expect(response.memberId, equals('member-123'));
        expect(response.sessionJwt, equals('session-jwt'));
        expect(response.statusCode, equals(200));
      },
    );

    test('resetPasswordBySession posts session reset payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.resetPasswordBySession(
        PasswordSessionResetRequest(
          organizationId: 'organization-test-123',
          password: 'new-password',
          sessionToken: 'session-token',
          sessionDurationMinutes: 60,
          sessionCustomClaims: {'tier': 'gold'},
          locale: 'en',
          telemetryId: 'telemetry-123',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/passwords/session/reset'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'password': 'new-password',
        'session_token': 'session-token',
        'session_duration_minutes': 60,
        'session_custom_claims': {'tier': 'gold'},
        'locale': 'en',
        'telemetry_id': 'telemetry-123',
      });
      expect(response.memberId, equals('member-123'));
      expect(
        response.memberSession?['member_session_id'],
        'member-session-123',
      );
    });

    test(
      'startDiscoveryPasswordEmailReset posts discovery reset start payload',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = AuthService(httpClient);

        final response = await service.startDiscoveryPasswordEmailReset(
          PasswordDiscoveryEmailResetStartRequest(
            emailAddress: 'prospect@example.com',
            resetPasswordRedirectUrl: 'https://example.com/reset',
            discoveryRedirectUrl: 'https://example.com/discovery',
            resetPasswordTemplateId: 'reset-template',
            resetPasswordExpirationMinutes: 30,
            pkceCodeChallenge: 'pkce-challenge',
            locale: 'en',
          ),
        );

        expect(
          httpClient.lastPath,
          equals('/b2b/passwords/discovery/email/reset/start'),
        );
        expect(httpClient.lastBody, {
          'email_address': 'prospect@example.com',
          'reset_password_redirect_url': 'https://example.com/reset',
          'discovery_redirect_url': 'https://example.com/discovery',
          'reset_password_template_id': 'reset-template',
          'reset_password_expiration_minutes': 30,
          'pkce_code_challenge': 'pkce-challenge',
          'locale': 'en',
        });
        expect(response.requestId, equals('request-123'));
        expect(response.statusCode, equals(200));
      },
    );

    test(
      'resetDiscoveryPasswordByEmail posts discovery reset payload',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = AuthService(httpClient);

        final response = await service.resetDiscoveryPasswordByEmail(
          PasswordDiscoveryEmailResetRequest(
            passwordResetToken: 'password-reset-token',
            password: 'new-password',
            pkceCodeVerifier: 'pkce-verifier',
          ),
        );

        expect(
          httpClient.lastPath,
          equals('/b2b/passwords/discovery/email/reset'),
        );
        expect(httpClient.lastBody, {
          'password_reset_token': 'password-reset-token',
          'password': 'new-password',
          'pkce_code_verifier': 'pkce-verifier',
        });
        expect(response.emailAddress, equals('prospect@example.com'));
        expect(response.intermediateSessionToken, equals('intermediate-token'));
        expect(response.statusCode, equals(200));
      },
    );

    test('requirePasswordResetByEmail posts require reset payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.requirePasswordResetByEmail(
        PasswordRequireResetByEmailRequest(
          emailAddress: 'member@example.com',
          organizationId: 'organization-test-123',
          memberId: 'member-123',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/passwords/email/require_reset'));
      expect(httpClient.lastBody, {
        'email_address': 'member@example.com',
        'organization_id': 'organization-test-123',
        'member_id': 'member-123',
      });
      expect(response.requestId, equals('request-123'));
      expect(response.memberId, equals('member-123'));
      expect(response.member?['email_address'], 'member@example.com');
      expect(
        response.organization?['organization_id'],
        'organization-test-123',
      );
    });

    test('otpSmsSend posts current SMS OTP send payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.otpSmsSend(
        OtpSmsSendRequest(
          organizationId: 'organization-test-123',
          memberId: 'member-123',
          mfaPhoneNumber: '+15551234567',
          locale: 'en',
          intermediateSessionToken: 'intermediate-token',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/otps/sms/send'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'member_id': 'member-123',
        'mfa_phone_number': '+15551234567',
        'locale': 'en',
        'intermediate_session_token': 'intermediate-token',
      });
      expect(response.requestId, equals('request-123'));
      expect(response.memberId, equals('member-123'));
      expect(response.organization['organization_id'], 'organization-test-123');
    });

    test(
      'authenticateOtpSms posts current SMS OTP authenticate payload',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = AuthService(httpClient);

        final response = await service.authenticateOtpSms(
          OtpSmsAuthenticateRequest(
            organizationId: 'organization-test-123',
            memberId: 'member-123',
            code: '123456',
            intermediateSessionToken: 'intermediate-token',
            sessionDurationMinutes: 60,
            sessionCustomClaims: {'tier': 'gold'},
            setMfaEnrollment: 'enroll',
            setDefaultMfa: true,
            telemetryId: 'telemetry-123',
          ),
        );

        expect(httpClient.lastPath, equals('/b2b/otps/sms/authenticate'));
        expect(httpClient.lastBody, {
          'organization_id': 'organization-test-123',
          'member_id': 'member-123',
          'code': '123456',
          'intermediate_session_token': 'intermediate-token',
          'session_duration_minutes': 60,
          'session_custom_claims': {'tier': 'gold'},
          'set_mfa_enrollment': 'enroll',
          'set_default_mfa': true,
          'telemetry_id': 'telemetry-123',
        });
        expect(response.memberId, equals('member-123'));
        expect(response.sessionToken, equals('session-token'));
        expect(response.memberDevice?['visitor_id'], 'visitor-123');
        expect(response.statusCode, equals(200));
      },
    );

    test('totpCreate posts current TOTP create payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.totpCreate(
        TotpCreateRequest(
          organizationId: 'organization-test-123',
          memberId: 'member-123',
          expirationMinutes: 60,
          sessionToken: 'session-token',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/totp'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'member_id': 'member-123',
        'expiration_minutes': 60,
        'session_token': 'session-token',
      });
      expect(response.totpRegistrationId, equals('totp-registration-123'));
      expect(response.secret, equals('totp-secret'));
      expect(response.qrCode, equals('base64-qr-code'));
      expect(response.recoveryCodes, ['code-1', 'code-2']);
    });

    test('authenticateTotp posts current TOTP authenticate payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.authenticateTotp(
        TotpAuthenticateRequest(
          organizationId: 'organization-test-123',
          memberId: 'member-123',
          code: '123456',
          sessionJwt: 'session-jwt',
          sessionDurationMinutes: 60,
          sessionCustomClaims: {'tier': 'gold'},
          setMfaEnrollment: 'enroll',
          setDefaultMfa: true,
          telemetryId: 'telemetry-123',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/totp/authenticate'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'member_id': 'member-123',
        'code': '123456',
        'session_jwt': 'session-jwt',
        'session_duration_minutes': 60,
        'session_custom_claims': {'tier': 'gold'},
        'set_mfa_enrollment': 'enroll',
        'set_default_mfa': true,
        'telemetry_id': 'telemetry-123',
      });
      expect(response.memberId, equals('member-123'));
      expect(response.sessionJwt, equals('session-jwt'));
      expect(
        response.memberSession?['member_session_id'],
        'member-session-123',
      );
    });

    test('totpMigrate posts current TOTP migrate payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.totpMigrate(
        TotpMigrateRequest(
          organizationId: 'organization-test-123',
          memberId: 'member-123',
          secret: 'totp-secret',
          recoveryCodes: ['code-1', 'code-2'],
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/totp/migrate'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'member_id': 'member-123',
        'secret': 'totp-secret',
        'recovery_codes': ['code-1', 'code-2'],
      });
      expect(response.totpRegistrationId, equals('totp-registration-123'));
      expect(response.recoveryCodes, ['code-1', 'code-2']);
      expect(response.organization['organization_id'], 'organization-test-123');
    });

    test('recoveryCodesGet gets current recovery code path', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.recoveryCodesGet(
        RecoveryCodesGetRequest(
          organizationId: 'organization-test-123',
          memberId: 'member-123',
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/recovery_codes/organization-test-123/member-123'),
      );
      expect(response.memberId, equals('member-123'));
      expect(response.recoveryCodes, ['code-1', 'code-2']);
      expect(response.statusCode, equals(200));
    });

    test('recoveryCodesRecover posts current recover payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.recoveryCodesRecover(
        RecoveryCodesRecoverRequest(
          organizationId: 'organization-test-123',
          memberId: 'member-123',
          recoveryCode: 'code-1',
          intermediateSessionToken: 'intermediate-token',
          sessionDurationMinutes: 60,
          sessionCustomClaims: {'tier': 'gold'},
          telemetryId: 'telemetry-123',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/recovery_codes/recover'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'member_id': 'member-123',
        'recovery_code': 'code-1',
        'intermediate_session_token': 'intermediate-token',
        'session_duration_minutes': 60,
        'session_custom_claims': {'tier': 'gold'},
        'telemetry_id': 'telemetry-123',
      });
      expect(response.memberId, equals('member-123'));
      expect(response.recoveryCodesRemaining, equals(1));
      expect(response.sessionToken, equals('session-token'));
    });

    test('recoveryCodesRotate posts current rotate payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.recoveryCodesRotate(
        RecoveryCodesRotateRequest(
          organizationId: 'organization-test-123',
          memberId: 'member-123',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/recovery_codes/rotate'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'member_id': 'member-123',
      });
      expect(response.memberId, equals('member-123'));
      expect(response.recoveryCodes, ['code-1', 'code-2']);
      expect(response.organization['organization_id'], 'organization-test-123');
    });

    test(
      'getSession gets active member sessions with query parameters',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = AuthService(httpClient);

        final response = await service.getSession(
          GetSessionsRequest(
            organizationId: 'organization-test-123',
            memberId: 'member-123',
          ),
        );

        expect(httpClient.lastPath, equals('/b2b/sessions'));
        expect(httpClient.lastQueryParameters, {
          'organization_id': 'organization-test-123',
          'member_id': 'member-123',
        });
        expect(response.requestId, equals('request-123'));
        expect(
          response.memberSessions.single['member_session_id'],
          'session-1',
        );
        expect(response.statusCode, equals(200));
      },
    );

    test(
      'authenticateSession posts token payload and parses verdict',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = AuthService(httpClient);

        final response = await service.authenticateSession(
          AuthenticateSessionRequest(
            sessionToken: 'session-token',
            sessionDurationMinutes: 60,
            sessionCustomClaims: {'tier': 'gold'},
            authorizationCheck: {
              'organization_id': 'organization-test-123',
              'resource_id': 'project',
              'action': 'read',
            },
          ),
        );

        expect(httpClient.lastPath, equals('/b2b/sessions/authenticate'));
        expect(httpClient.lastBody, {
          'session_token': 'session-token',
          'session_duration_minutes': 60,
          'session_custom_claims': {'tier': 'gold'},
          'authorization_check': {
            'organization_id': 'organization-test-123',
            'resource_id': 'project',
            'action': 'read',
          },
        });
        expect(response.requestId, equals('request-123'));
        expect(response.memberSession['member_session_id'], 'session-test-123');
        expect(response.member['member_id'], 'member-123');
        expect(
          response.organization['organization_id'],
          'organization-test-123',
        );
        expect(response.sessionToken, equals('session-token'));
        expect(response.sessionJwt, equals('session-jwt'));
        expect(response.verdict?['authorized'], isTrue);
        expect(response.statusCode, equals(200));
      },
    );

    test('exchangeSession posts current Stytch exchange payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.exchangeSession(
        ExchangeSessionRequest(
          organizationId: 'organization-test-123',
          sessionToken: 'session-token',
          sessionDurationMinutes: 60,
          sessionCustomClaims: {'tier': 'gold'},
          locale: 'en',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/sessions/exchange'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'session_token': 'session-token',
        'session_duration_minutes': 60,
        'session_custom_claims': {'tier': 'gold'},
        'locale': 'en',
      });
      expect(response.requestId, equals('request-123'));
      expect(response.memberId, equals('member-123'));
      expect(response.sessionToken, equals('new-session-token'));
      expect(response.memberAuthenticated, isTrue);
      expect(response.statusCode, equals(200));
    });

    test('migrateSession posts current Stytch migrate payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.migrateSession(
        MigrateSessionRequest(
          sessionToken: 'external-session-token',
          organizationId: 'organization-test-123',
          sessionDurationMinutes: 60,
          sessionCustomClaims: {'source': 'legacy'},
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/sessions/migrate'));
      expect(httpClient.lastBody, {
        'session_token': 'external-session-token',
        'organization_id': 'organization-test-123',
        'session_duration_minutes': 60,
        'session_custom_claims': {'source': 'legacy'},
      });
      expect(response.requestId, equals('request-123'));
      expect(response.memberId, equals('member-123'));
      expect(response.sessionToken, equals('migrated-session-token'));
      expect(response.sessionJwt, equals('migrated-session-jwt'));
      expect(response.memberSession?['member_session_id'], 'session-test-123');
      expect(response.statusCode, equals(200));
    });

    test(
      'authenticateImpersonationToken posts current Stytch payload',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = AuthService(httpClient);

        final response = await service.authenticateImpersonationToken(
          AuthenticateImpersonationTokenRequest(
            impersonationToken: 'impersonation-token',
          ),
        );

        expect(httpClient.lastPath, equals('/b2b/impersonation/authenticate'));
        expect(httpClient.lastBody, {
          'impersonation_token': 'impersonation-token',
        });
        expect(response.memberId, equals('member-123'));
        expect(response.organizationId, equals('organization-test-123'));
        expect(response.memberAuthenticated, isTrue);
        expect(
          response.memberSession?['member_session_id'],
          'session-test-123',
        );
      },
    );

    test('revokeSession posts to the Stytch revoke endpoint', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.revokeSession('session-test-123');

      expect(httpClient.lastPath, equals('/b2b/sessions/revoke'));
      expect(httpClient.lastBody, {'member_session_id': 'session-test-123'});
      expect(response.requestId, equals('request-123'));
      expect(response.statusCode, equals(200));
    });

    test('revokeSessionWithRequest supports token-based revocation', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      await service.revokeSessionWithRequest(
        RevokeSessionRequest(sessionToken: 'session-token'),
      );

      expect(httpClient.lastPath, equals('/b2b/sessions/revoke'));
      expect(httpClient.lastBody, {'session_token': 'session-token'});
    });

    test('sendDiscoveryEmail posts to the Stytch discovery endpoint', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.sendDiscoveryEmail(
        SendDiscoveryEmailRequest(
          emailAddress: 'prospect@example.com',
          discoveryRedirectUrl: 'https://example.com/discovery/callback',
          pkceCodeChallenge: 'challenge',
          loginTemplateId: 'template_123',
          locale: 'en',
          discoveryExpirationMinutes: 60,
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/magic_links/email/discovery/send'),
      );
      expect(httpClient.lastBody, {
        'email_address': 'prospect@example.com',
        'discovery_redirect_url': 'https://example.com/discovery/callback',
        'pkce_code_challenge': 'challenge',
        'login_template_id': 'template_123',
        'locale': 'en',
        'discovery_expiration_minutes': 60,
      });
      expect(response.requestId, equals('request-123'));
      expect(response.statusCode, equals(200));
    });

    test('sendLoginSignupEmail posts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.sendLoginSignupEmail(
        SendLoginSignupEmailRequest(
          organizationId: 'organization-test-123',
          emailAddress: 'member@example.com',
          loginRedirectUrl: 'https://example.com/login',
          signupRedirectUrl: 'https://example.com/signup',
          pkceCodeChallenge: 'challenge',
          loginTemplateId: 'login-template',
          signupTemplateId: 'signup-template',
          locale: 'en',
          loginExpirationMinutes: 60,
          signupExpirationMinutes: 60,
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/magic_links/email/login_or_signup'),
      );
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'email_address': 'member@example.com',
        'login_redirect_url': 'https://example.com/login',
        'signup_redirect_url': 'https://example.com/signup',
        'pkce_code_challenge': 'challenge',
        'login_template_id': 'login-template',
        'signup_template_id': 'signup-template',
        'locale': 'en',
        'login_expiration_minutes': 60,
        'signup_expiration_minutes': 60,
      });
      expect(response.memberId, equals('member-123'));
      expect(response.memberCreated, isTrue);
    });

    test('authenticateMagicLink posts token payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.authenticateMagicLink(
        AuthenticateMagicLinkRequest(
          magicLinksToken: 'magic-link-token',
          sessionDurationMinutes: 60,
          sessionCustomClaims: {'tier': 'gold'},
          pkceCodeVerifier: 'verifier',
          locale: 'en',
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/magic_links/authenticate'));
      expect(httpClient.lastBody, {
        'magic_links_token': 'magic-link-token',
        'session_duration_minutes': 60,
        'session_custom_claims': {'tier': 'gold'},
        'pkce_code_verifier': 'verifier',
        'locale': 'en',
      });
      expect(response.memberAuthenticated, isTrue);
      expect(response.sessionToken, equals('session-token'));
    });

    test('authenticateDiscoveryMagicLink posts token payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.authenticateDiscoveryMagicLink(
        AuthenticateDiscoveryMagicLinkRequest(
          discoveryMagicLinksToken: 'discovery-token',
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/magic_links/discovery/authenticate'),
      );
      expect(httpClient.lastBody, {
        'discovery_magic_links_token': 'discovery-token',
      });
      expect(response.intermediateSessionToken, equals('intermediate-token'));
      expect(response.discoveredOrganizations, hasLength(1));
    });

    test('sendLoginSignupEmailOtp posts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.sendLoginSignupEmailOtp(
        SendLoginSignupEmailOtpRequest(
          organizationId: 'organization-test-123',
          emailAddress: 'member@example.com',
          loginTemplateId: 'login-template',
          signupTemplateId: 'signup-template',
          locale: 'en',
          loginExpirationMinutes: 10,
          signupExpirationMinutes: 10,
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/otps/email/login_or_signup'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'email_address': 'member@example.com',
        'login_template_id': 'login-template',
        'signup_template_id': 'signup-template',
        'locale': 'en',
        'login_expiration_minutes': 10,
        'signup_expiration_minutes': 10,
      });
      expect(response.memberId, equals('member-123'));
    });

    test('authenticateEmailOtp posts code payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.authenticateEmailOtp(
        AuthenticateEmailOtpRequest(
          organizationId: 'organization-test-123',
          emailAddress: 'member@example.com',
          code: '123456',
          sessionDurationMinutes: 60,
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/otps/email/authenticate'));
      expect(httpClient.lastBody, {
        'organization_id': 'organization-test-123',
        'email_address': 'member@example.com',
        'code': '123456',
        'session_duration_minutes': 60,
      });
      expect(response.memberAuthenticated, isTrue);
    });

    test('sendDiscoveryEmailOtp posts discovery OTP payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.sendDiscoveryEmailOtp(
        SendDiscoveryEmailOtpRequest(
          emailAddress: 'prospect@example.com',
          loginTemplateId: 'login-template',
          locale: 'en',
          discoveryExpirationMinutes: 10,
        ),
      );

      expect(httpClient.lastPath, equals('/b2b/otps/email/discovery/send'));
      expect(httpClient.lastBody, {
        'email_address': 'prospect@example.com',
        'login_template_id': 'login-template',
        'locale': 'en',
        'discovery_expiration_minutes': 10,
      });
      expect(response.statusCode, equals(200));
    });

    test(
      'authenticateDiscoveryEmailOtp posts discovery code payload',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = AuthService(httpClient);

        final response = await service.authenticateDiscoveryEmailOtp(
          AuthenticateDiscoveryEmailOtpRequest(
            emailAddress: 'prospect@example.com',
            code: '123456',
          ),
        );

        expect(
          httpClient.lastPath,
          equals('/b2b/otps/email/discovery/authenticate'),
        );
        expect(httpClient.lastBody, {
          'email_address': 'prospect@example.com',
          'code': '123456',
        });
        expect(response.emailAddress, equals('prospect@example.com'));
      },
    );

    test(
      'createOrganizationViaDiscovery posts current Stytch payload',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = AuthService(httpClient);

        final response = await service.createOrganizationViaDiscovery(
          CreateOrganizationViaDiscoveryRequest(
            intermediateSessionToken: 'intermediate-token',
            sessionDurationMinutes: 60,
            sessionCustomClaims: {'tier': 'founder'},
            organizationName: 'Example Org',
            organizationSlug: 'example-org',
            organizationExternalId: 'external-org-123',
            organizationLogoUrl: 'https://example.com/logo.png',
            trustedMetadata: {'crm_id': 'crm-123'},
            ssoJitProvisioning: 'NOT_ALLOWED',
            emailAllowedDomains: ['example.com'],
            emailJitProvisioning: 'RESTRICTED',
            emailInvites: 'ALL_ALLOWED',
            authMethods: 'RESTRICTED',
            allowedAuthMethods: ['magic_link', 'email_otp'],
            mfaPolicy: 'OPTIONAL',
            rbacEmailImplicitRoleAssignments: [
              {'domain': 'example.com', 'role_id': 'admin'},
            ],
            mfaMethods: 'RESTRICTED',
            allowedMfaMethods: ['sms_otp'],
            oauthTenantJitProvisioning: 'RESTRICTED',
            allowedOauthTenants: {
              'slack': ['T123'],
            },
            firstPartyConnectedAppsAllowedType: 'RESTRICTED',
            allowedFirstPartyConnectedApps: ['client-123'],
            thirdPartyConnectedAppsAllowedType: 'NOT_ALLOWED',
            allowedThirdPartyConnectedApps: ['client-456'],
            telemetryId: 'telemetry-123',
          ),
        );

        expect(
          httpClient.lastPath,
          equals('/b2b/discovery/organizations/create'),
        );
        expect(httpClient.lastBody, {
          'intermediate_session_token': 'intermediate-token',
          'session_duration_minutes': 60,
          'session_custom_claims': {'tier': 'founder'},
          'organization_name': 'Example Org',
          'organization_slug': 'example-org',
          'organization_external_id': 'external-org-123',
          'organization_logo_url': 'https://example.com/logo.png',
          'trusted_metadata': {'crm_id': 'crm-123'},
          'sso_jit_provisioning': 'NOT_ALLOWED',
          'email_allowed_domains': ['example.com'],
          'email_jit_provisioning': 'RESTRICTED',
          'email_invites': 'ALL_ALLOWED',
          'auth_methods': 'RESTRICTED',
          'allowed_auth_methods': ['magic_link', 'email_otp'],
          'mfa_policy': 'OPTIONAL',
          'rbac_email_implicit_role_assignments': [
            {'domain': 'example.com', 'role_id': 'admin'},
          ],
          'mfa_methods': 'RESTRICTED',
          'allowed_mfa_methods': ['sms_otp'],
          'oauth_tenant_jit_provisioning': 'RESTRICTED',
          'allowed_oauth_tenants': {
            'slack': ['T123'],
          },
          'first_party_connected_apps_allowed_type': 'RESTRICTED',
          'allowed_first_party_connected_apps': ['client-123'],
          'third_party_connected_apps_allowed_type': 'NOT_ALLOWED',
          'allowed_third_party_connected_apps': ['client-456'],
          'telemetry_id': 'telemetry-123',
        });
        expect(response.memberId, equals('member-123'));
        expect(response.memberAuthenticated, isTrue);
        expect(
          response.organization?['organization_slug'],
          equals('example-org'),
        );
      },
    );

    test(
      'listDiscoveredOrganizations posts exactly one session token',
      () async {
        final httpClient = _RecordingStytchHttpClient();
        final service = AuthService(httpClient);

        final response = await service.listDiscoveredOrganizations(
          ListDiscoveredOrganizationsRequest(
            intermediateSessionToken: 'intermediate-token',
          ),
        );

        expect(httpClient.lastPath, equals('/b2b/discovery/organizations'));
        expect(httpClient.lastBody, {
          'intermediate_session_token': 'intermediate-token',
        });
        expect(response.emailAddress, equals('prospect@example.com'));
        expect(response.discoveredOrganizations, hasLength(1));
        expect(response.organizationIdHint, equals('organization-test-123'));
      },
    );

    test('listDiscoveredOrganizations rejects missing or duplicate tokens', () {
      expect(
        () => ListDiscoveredOrganizationsRequest(),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => ListDiscoveredOrganizationsRequest(
          intermediateSessionToken: 'intermediate-token',
          sessionToken: 'session-token',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('exchangeIntermediateSession posts current Stytch payload', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.exchangeIntermediateSession(
        ExchangeIntermediateSessionRequest(
          intermediateSessionToken: 'intermediate-token',
          organizationId: 'organization-test-123',
          sessionDurationMinutes: 60,
          sessionCustomClaims: {'tier': 'gold'},
          locale: 'en',
          telemetryId: 'telemetry-123',
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/discovery/intermediate_sessions/exchange'),
      );
      expect(httpClient.lastBody, {
        'intermediate_session_token': 'intermediate-token',
        'organization_id': 'organization-test-123',
        'session_duration_minutes': 60,
        'session_custom_claims': {'tier': 'gold'},
        'locale': 'en',
        'telemetry_id': 'telemetry-123',
      });
      expect(response.memberId, equals('member-123'));
      expect(response.sessionToken, equals('new-session-token'));
      expect(response.memberAuthenticated, isTrue);
      expect(response.memberSession?['member_session_id'], 'session-test-123');
    });

    test('oauth discovery start builds provider query parameters', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.oauthGoogleDiscoveryStart(
        OAuthDiscoveryStartRequest(
          publicToken: 'public-token',
          discoveryRedirectUrl: 'https://example.com/authenticate',
          customScopes: 'openid email profile',
          pkceCodeChallenge: 'challenge',
          providerParams: {'login_hint': 'member@example.com'},
        ),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/public/oauth/google/discovery/start'),
      );
      expect(httpClient.lastQueryParameters, {
        'public_token': 'public-token',
        'discovery_redirect_url': 'https://example.com/authenticate',
        'custom_scopes': 'openid email profile',
        'pkce_code_challenge': 'challenge',
        'provider_login_hint': 'member@example.com',
      });
      expect(response.redirectUrl, startsWith('https://accounts.google.com'));
    });

    test('oauthMicrosoftDiscoveryStart uses Microsoft provider path', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      await service.oauthMicrosoftDiscoveryStart(
        OAuthDiscoveryStartRequest(publicToken: 'public-token'),
      );

      expect(
        httpClient.lastPath,
        equals('/b2b/public/oauth/microsoft/discovery/start'),
      );
    });

    test('getJWKS gets project JWKS', () async {
      final httpClient = _RecordingStytchHttpClient();
      final service = AuthService(httpClient);

      final response = await service.getJWKS();

      expect(httpClient.lastPath, equals('/sessions/jwks/project-test-123'));
      expect(response.keys.single['kid'], equals('key-1'));
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
    if (path == '/b2b/recovery_codes/organization-test-123/member-123') {
      return _recoveryCodesResponse();
    }
    if (path == '/b2b/sessions') {
      return {
        'request_id': 'request-123',
        'member_sessions': [
          {'member_session_id': 'session-1', 'member_id': 'member-123'},
        ],
        'status_code': 200,
      };
    }
    if (path.contains('/oauth/google/')) {
      return {
        'request_id': 'request-123',
        'redirect_url': 'https://accounts.google.com/oauth',
        'status_code': 302,
      };
    }
    if (path.contains('/oauth/microsoft/')) {
      return {
        'request_id': 'request-123',
        'redirect_url': 'https://login.microsoftonline.com/oauth',
        'status_code': 302,
      };
    }
    if (path == '/sessions/jwks/project-test-123') {
      return {
        'request_id': 'request-123',
        'status_code': 200,
        'keys': [
          {'kid': 'key-1', 'kty': 'RSA', 'alg': 'RS256'},
        ],
      };
    }
    return {'request_id': 'request-123', 'status_code': 200};
  }

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    lastPath = path;
    lastBody = body;
    if (path == '/b2b/passwords/authenticate' ||
        path == '/b2b/passwords/email/reset' ||
        path == '/b2b/passwords/existing_password/reset' ||
        path == '/b2b/passwords/session/reset') {
      return _passwordSessionResponse();
    }
    if (path == '/b2b/passwords/discovery/authenticate' ||
        path == '/b2b/passwords/discovery/email/reset') {
      return {
        'request_id': 'request-123',
        'intermediate_session_token': 'intermediate-token',
        'email_address': body?['email_address'] ?? 'prospect@example.com',
        'discovered_organizations': [
          {
            'organization': {'organization_id': 'organization-test-123'},
            'membership': {'type': 'active_member'},
          },
        ],
        'status_code': 200,
      };
    }
    if (path == '/b2b/passwords/strength_check') {
      return {
        'request_id': 'request-123',
        'valid_password': true,
        'score': 4,
        'breached_password': false,
        'strength_policy': 'zxcvbn',
        'breach_detection_on_create': true,
        'zxcvbn_feedback': {
          'warning': '',
          'suggestions': ['Keep it memorable'],
        },
        'status_code': 200,
      };
    }
    if (path == '/b2b/passwords/migrate') {
      return {
        'request_id': 'request-123',
        'member_id': 'member-123',
        'member_created': true,
        'member': {
          'member_id': 'member-123',
          'email_address': 'member@example.com',
        },
        'organization': {'organization_id': 'organization-test-123'},
        'status_code': 200,
      };
    }
    if (path == '/b2b/passwords/email/reset/start') {
      return {
        'request_id': 'request-123',
        'member_id': 'member-123',
        'member_email_id': 'email-123',
        'member': {
          'member_id': 'member-123',
          'email_address': 'member@example.com',
        },
        'status_code': 200,
      };
    }
    if (path == '/b2b/passwords/discovery/email/reset/start') {
      return {'request_id': 'request-123', 'status_code': 200};
    }
    if (path == '/b2b/passwords/email/require_reset') {
      return {
        'request_id': 'request-123',
        'status_code': 200,
        'member_id': 'member-123',
        'member': {
          'member_id': 'member-123',
          'email_address': 'member@example.com',
        },
        'organization': {'organization_id': 'organization-test-123'},
      };
    }
    if (path == '/b2b/otps/sms/send') {
      return _mfaMemberResponse();
    }
    if (path == '/b2b/otps/sms/authenticate' ||
        path == '/b2b/totp/authenticate') {
      return _mfaSessionResponse();
    }
    if (path == '/b2b/totp') {
      return {
        ..._mfaMemberResponse(),
        'totp_registration_id': 'totp-registration-123',
        'secret': 'totp-secret',
        'qr_code': 'base64-qr-code',
        'recovery_codes': ['code-1', 'code-2'],
      };
    }
    if (path == '/b2b/totp/migrate') {
      return {
        ..._mfaMemberResponse(),
        'totp_registration_id': 'totp-registration-123',
        'recovery_codes': ['code-1', 'code-2'],
      };
    }
    if (path == '/b2b/recovery_codes/recover') {
      return {..._mfaSessionResponse(), 'recovery_codes_remaining': 1};
    }
    if (path == '/b2b/recovery_codes/rotate') {
      return _recoveryCodesResponse();
    }
    if (path == '/b2b/sessions/authenticate') {
      return {
        'request_id': 'request-123',
        'member_session': {'member_session_id': 'session-test-123'},
        'session_token': 'session-token',
        'session_jwt': 'session-jwt',
        'member': {
          'member_id': 'member-123',
          'email_address': 'member@example.com',
        },
        'organization': {'organization_id': 'organization-test-123'},
        'status_code': 200,
        'verdict': {
          'authorized': true,
          'granting_roles': ['admin'],
        },
      };
    }
    if (path == '/b2b/sessions/exchange') {
      return {
        'request_id': 'request-123',
        'member_id': 'member-123',
        'session_token': 'new-session-token',
        'session_jwt': 'session-jwt',
        'member': {
          'member_id': 'member-123',
          'email_address': 'member@example.com',
        },
        'organization': {'organization_id': 'organization-test-123'},
        'member_authenticated': true,
        'member_session': {'member_session_id': 'session-test-123'},
        'status_code': 200,
      };
    }
    if (path == '/b2b/discovery/organizations/create') {
      return _sessionExchangeResponse(
        sessionToken: 'created-session-token',
        organizationSlug: 'example-org',
      );
    }
    if (path == '/b2b/discovery/organizations') {
      return {
        'request_id': 'request-123',
        'email_address': 'prospect@example.com',
        'discovered_organizations': [
          {
            'member_authenticated': true,
            'organization': {'organization_id': 'organization-test-123'},
            'membership': {'type': 'eligible_to_join_by_email_domain'},
          },
        ],
        'organization_id_hint': 'organization-test-123',
        'status_code': 200,
      };
    }
    if (path == '/b2b/discovery/intermediate_sessions/exchange') {
      return _sessionExchangeResponse(sessionToken: 'new-session-token');
    }
    if (path == '/b2b/sessions/migrate') {
      return {
        'request_id': 'request-123',
        'member_id': 'member-123',
        'session_token': 'migrated-session-token',
        'session_jwt': 'migrated-session-jwt',
        'member': {
          'member_id': 'member-123',
          'email_address': 'member@example.com',
        },
        'organization': {'organization_id': 'organization-test-123'},
        'member_session': {'member_session_id': 'session-test-123'},
        'status_code': 200,
      };
    }
    if (path == '/b2b/impersonation/authenticate') {
      return {
        'request_id': 'request-123',
        'member_id': 'member-123',
        'organization_id': 'organization-test-123',
        'member': {
          'member_id': 'member-123',
          'email_address': 'member@example.com',
        },
        'session_token': 'session-token',
        'session_jwt': 'session-jwt',
        'organization': {'organization_id': 'organization-test-123'},
        'member_session': {'member_session_id': 'session-test-123'},
        'member_authenticated': true,
        'status_code': 200,
      };
    }
    if (path == '/b2b/magic_links/email/login_or_signup' ||
        path == '/b2b/otps/email/login_or_signup') {
      return {
        'request_id': 'request-123',
        'member_id': 'member-123',
        'member_created': true,
        'member': {
          'member_id': 'member-123',
          'email_address': 'member@example.com',
        },
        'status_code': 200,
      };
    }
    if (path == '/b2b/magic_links/authenticate' ||
        path == '/b2b/otps/email/authenticate') {
      return {
        'request_id': 'request-123',
        'member_id': 'member-123',
        'organization_id': 'organization-test-123',
        'method_id': 'email-test-123',
        'session_token': 'session-token',
        'session_jwt': 'session-jwt',
        'member_authenticated': true,
        'member': {
          'member_id': 'member-123',
          'email_address': 'member@example.com',
        },
        'organization': {'organization_id': 'organization-test-123'},
        'member_session': {'member_session_id': 'member-session-123'},
        'status_code': 200,
      };
    }
    if (path == '/b2b/magic_links/discovery/authenticate' ||
        path == '/b2b/otps/email/discovery/authenticate') {
      return {
        'request_id': 'request-123',
        'intermediate_session_token': 'intermediate-token',
        'email_address': body?['email_address'] ?? 'prospect@example.com',
        'discovered_organizations': [
          {
            'organization': {'organization_id': 'organization-test-123'},
            'membership': {'type': 'active_member'},
          },
        ],
        'status_code': 200,
      };
    }
    return {'request_id': 'request-123', 'status_code': 200};
  }
}

Map<String, dynamic> _passwordSessionResponse() {
  return {
    'request_id': 'request-123',
    'member_id': 'member-123',
    'organization_id': 'organization-test-123',
    'method_id': 'password-test-123',
    'session_token': 'session-token',
    'session_jwt': 'session-jwt',
    'member_authenticated': true,
    'member': {
      'member_id': 'member-123',
      'email_address': 'member@example.com',
    },
    'organization': {'organization_id': 'organization-test-123'},
    'member_session': {'member_session_id': 'member-session-123'},
    'status_code': 200,
  };
}

Map<String, dynamic> _mfaMemberResponse() {
  return {
    'request_id': 'request-123',
    'member_id': 'member-123',
    'member': {
      'member_id': 'member-123',
      'email_address': 'member@example.com',
    },
    'organization': {'organization_id': 'organization-test-123'},
    'status_code': 200,
  };
}

Map<String, dynamic> _mfaSessionResponse() {
  return {
    ..._mfaMemberResponse(),
    'organization_id': 'organization-test-123',
    'session_token': 'session-token',
    'session_jwt': 'session-jwt',
    'member_authenticated': true,
    'member_session': {'member_session_id': 'member-session-123'},
    'member_device': {'visitor_id': 'visitor-123'},
  };
}

Map<String, dynamic> _recoveryCodesResponse() {
  return {
    ..._mfaMemberResponse(),
    'recovery_codes': ['code-1', 'code-2'],
  };
}

Map<String, dynamic> _sessionExchangeResponse({
  required String sessionToken,
  String organizationSlug = 'organization-slug',
}) {
  return {
    'request_id': 'request-123',
    'member_id': 'member-123',
    'session_token': sessionToken,
    'session_jwt': 'session-jwt',
    'member': {
      'member_id': 'member-123',
      'email_address': 'member@example.com',
    },
    'organization': {
      'organization_id': 'organization-test-123',
      'organization_slug': organizationSlug,
    },
    'member_authenticated': true,
    'intermediate_session_token': '',
    'member_session': {'member_session_id': 'session-test-123'},
    'status_code': 200,
  };
}
