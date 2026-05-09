# stytch_dart_auth_sdk

Dart SDK for Stytch B2B auth workflows.

This package provides typed service clients and models for user, session, organization, and invitation operations over the Stytch B2B API.

## Package Status

Implemented and exported from `lib/stytch_dart_auth_sdk.dart`:

- `StytchAuth` main entrypoint.
- Service clients: `AuthService`, `UserService`, `OrganizationService`,
  `InvitationService`, `MemberService`, `RbacService`, `SsoService`.
- Typed request/response models under `lib/src/models/`.
- Error model and exception mapping (`StytchException`, `StytchAuthException`, etc).
- Firebase-style compatibility helpers under `lib/src/auth/` (primarily for the Flutter example app).

Important: parts of the Firebase compatibility API are currently placeholders/mocks. Use the Stytch service clients for production flows.

## Docs Index

- [CHANGELOG](CHANGELOG.md)
- [Contributing Guide](../CONTRIBUTING.md)
- [Local Dev Tools](local_dev_tools/README.md)
- [Repository README](../README.md)

## Installation

```yaml
dependencies:
  stytch_dart_auth_sdk: ^0.0.2
```

Then run:

```bash
dart pub get
```

## Initialization

### Direct configuration

```dart
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

final stytch = StytchAuth(
  apiKey: 'YOUR_STYTCH_API_KEY',
  projectId: 'YOUR_STYTCH_PROJECT_ID',
  environment: 'sandbox', // sandbox | development | production
);
```

### Environment variables

Supported environment variables:

- `STYTCH_API_KEY` (required)
- `STYTCH_PROJECT_ID` (required)
- `STYTCH_ENVIRONMENT` (optional)
- `STYTCH_BASE_URL` (optional)
- `STYTCH_TIMEOUT` in seconds (optional)

```dart
final stytch = StytchAuth.fromEnvironmentVariables();
```

## Basic Usage

```dart
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

Future<void> main() async {
  final stytch = StytchAuth(
    apiKey: 'YOUR_STYTCH_API_KEY',
    projectId: 'YOUR_STYTCH_PROJECT_ID',
    environment: 'sandbox',
  );

  final created = await stytch.user.createUser(
    const CreateUserRequest(
      email: 'alice@example.com',
      name: 'Alice',
      password: 'strong-password',
    ),
  );

  final login = await stytch.auth.loginWithEmailPassword(
    const EmailPasswordLoginRequest(
      email: 'alice@example.com',
      password: 'strong-password',
    ),
  );

  final validation = await stytch.auth.validateSession(
    ValidateSessionRequest(sessionToken: login.sessionToken),
  );

  print('User ID: ${created.userId}');
  print('Session valid: ${validation.valid}');
}
```

## API Surface Overview

### AuthService

- `loginWithEmailPassword`
- `loginWithSso`
- `sendDiscoveryEmail`
- `sendLoginSignupEmail`
- `authenticateMagicLink`
- `authenticateDiscoveryMagicLink`
- `sendLoginSignupEmailOtp`
- `authenticateEmailOtp`
- `sendDiscoveryEmailOtp`
- `authenticateDiscoveryEmailOtp`
- `oauthGoogleDiscoveryStart`
- `oauthMicrosoftDiscoveryStart`
- `startMfa`
- `completeMfa`
- `createSession`
- `validateSession`
- `getSession`
- `authenticateSession`
- `revokeSession`
- `revokeSessionWithRequest`
- `revokeAllUserSessions`
- `exchangeSession`
- `migrateSession`
- `getJWKS`

`getSession`, `authenticateSession`, and `migrateSession` wrap Stytch's current
B2B session endpoints: `GET /v1/b2b/sessions`,
`POST /v1/b2b/sessions/authenticate`, and
`POST /v1/b2b/sessions/migrate`.
`exchangeSession` wraps Stytch's `POST /v1/b2b/sessions/exchange` endpoint
with `ExchangeSessionRequest` and `ExchangeSessionResponse`.
`revokeSession` revokes by member session ID through
`POST /v1/b2b/sessions/revoke`; use `revokeSessionWithRequest` to revoke by
session token, session JWT, or all sessions for a member.
`getJWKS` wraps `GET /v1/sessions/jwks/{project_id}` for validating Stytch
session JWTs.

### Email Magic Links

Use `sendLoginSignupEmail` for organization-scoped login/signup links and
`authenticateMagicLink` to exchange the link token for a member session.
Discovery links continue to use `sendDiscoveryEmail` and
`authenticateDiscoveryMagicLink`.

```dart
await stytch.auth.sendLoginSignupEmail(
  SendLoginSignupEmailRequest(
    organizationId: 'organization-test-123',
    emailAddress: 'member@example.com',
    loginRedirectUrl: 'https://example.com/login',
    signupRedirectUrl: 'https://example.com/signup',
  ),
);

final authenticated = await stytch.auth.authenticateMagicLink(
  AuthenticateMagicLinkRequest(
    magicLinksToken: 'token-from-redirect',
    sessionDurationMinutes: 60,
  ),
);

print('Member authenticated: ${authenticated.memberAuthenticated}');
```

### Email OTPs

Use `sendLoginSignupEmailOtp` and `authenticateEmailOtp` for organization
login/signup OTPs. Use `sendDiscoveryEmailOtp` and
`authenticateDiscoveryEmailOtp` for discovery flows.

```dart
await stytch.auth.sendLoginSignupEmailOtp(
  SendLoginSignupEmailOtpRequest(
    organizationId: 'organization-test-123',
    emailAddress: 'member@example.com',
  ),
);

final otp = await stytch.auth.authenticateEmailOtp(
  AuthenticateEmailOtpRequest(
    organizationId: 'organization-test-123',
    emailAddress: 'member@example.com',
    code: '123456',
    sessionDurationMinutes: 60,
  ),
);

print('Member authenticated: ${otp.memberAuthenticated}');
```

### OAuth Discovery

`oauthGoogleDiscoveryStart` and `oauthMicrosoftDiscoveryStart` wrap Stytch's
public OAuth discovery start endpoints and return the provider redirect URL.

```dart
final start = await stytch.auth.oauthGoogleDiscoveryStart(
  OAuthDiscoveryStartRequest(
    publicToken: 'public-token-test-...',
    discoveryRedirectUrl: 'https://example.com/authenticate',
  ),
);

print('Redirect to: ${start.redirectUrl}');
```

### Discovery Email Magic Link

Use `sendDiscoveryEmail` to send a Stytch B2B discovery Email Magic Link to a
member. The method wraps Stytch's
`POST /v1/b2b/magic_links/email/discovery/send` endpoint.

```dart
final response = await stytch.auth.sendDiscoveryEmail(
  SendDiscoveryEmailRequest(
    emailAddress: 'member@example.com',
    discoveryRedirectUrl: 'https://example.com/discovery/callback',
    loginTemplateId: 'template_123',
    locale: 'en',
    discoveryExpirationMinutes: 60,
  ),
);

print('Request ID: ${response.requestId}');
print('Status: ${response.statusCode}');
```

### UserService

- `createUser`
- `getUser`
- `getCurrentUser`
- `updateUser`
- `deleteUser`
- `listUsers`
- `searchUsers`
- `setMfaEnabled`
- `getUserOrganizations`
- `removeFromOrganization`
- `deleteAuthenticationFactor`

### OrganizationService

- `createOrganization`
- `getOrganization`
- `getOrganizationBySlug`
- `updateOrganization`
- `deleteOrganization`
- `listOrganizations`
- `searchOrganizations`
- `getOrganizationMembers`
- `addUserToOrganization`
- `removeUserFromOrganization`
- `updateOrganizationMember`

Organization methods use Stytch's current B2B wire fields, including
`organization_name`, `organization_slug`, `email_allowed_domains`, and the
`organization` response envelope, while exposing the existing Dart property
names such as `name`, `slug`, and `allowedDomains`.

### InvitationService

- `sendInviteEmail`
- `sendInvitation`
- `getInvitation`
- `listInvitations`
- `cancelInvitation`
- `acceptInvitation`
- `sendBulkInvitations`
- `getPendingInvitationsForEmail`
- `resendInvitation`

### Invite Email Magic Link

Use `sendInviteEmail` to send a Stytch B2B invite Email Magic Link to a new
organization member. The method wraps Stytch's
`POST /v1/b2b/magic_links/email/invite` endpoint.

```dart
final response = await stytch.invitation.sendInviteEmail(
  SendInviteEmailRequest(
    organizationId: 'organization-test-123',
    emailAddress: 'new-member@example.com',
    inviteRedirectUrl: 'https://example.com/invite/callback',
    name: 'New Member',
    roles: ['viewer'],
    locale: 'en',
  ),
);

print('Request ID: ${response.requestId}');
print('Member ID: ${response.memberId}');
print('Status: ${response.statusCode}');
```

### MemberService

- `createMember`
- `getMember`
- `getMemberByEmail`
- `updateMember`
- `reactivateMember`
- `searchMembers`
- `unlinkRetiredMemberEmail`
- `deleteMember`
- `deleteMemberPassword`
- `deleteMemberMfaPhoneNumber`
- `deleteMemberMfaTotp`

Member methods wrap Stytch's current B2B organization member endpoints,
including `GET /v1/b2b/organizations/{organization_id}/member` with
`member_id` or `email_address` query parameters.

```dart
final member = await stytch.member.getMember(
  'organization-test-123',
  'member-test-123',
);

final search = await stytch.member.searchMembers(
  SearchMembersRequest(
    organizationIds: ['organization-test-123'],
    query: {
      'operator': 'AND',
      'operands': [
        {
          'filter_name': 'member_emails',
          'filter_value': ['member@example.com'],
        },
      ],
    },
  ),
);

print('Member ID: ${member.memberId}');
print('Matched members: ${search.members.length}');
```

### RbacService

- `getRbacPolicy`

`getRbacPolicy` wraps Stytch's `GET /v1/b2b/rbac/policy` endpoint.

### SsoService

- `createSamlConnection`
- `updateSamlConnection`
- `updateSamlConnectionUrl`
- `deleteVerificationCertificate`
- `createOidcConnection`
- `updateOidcConnection`
- `getOidcAccessToken`
- `createExternalConnection`
- `updateExternalConnection`
- `getSsoConnections`
- `deleteSsoConnection`
- `ssoAuthenticateStart`
- `ssoAuthenticate`

SSO methods wrap Stytch's current B2B SAML, OIDC, External, and shared SSO
endpoints without provider-specific shortcuts.

## Example App

Flutter sample app location:

- `example/stytch-dart-auth-sdk-flutter-mobile-app/`

Run it with:

```bash
cd example/stytch-dart-auth-sdk-flutter-mobile-app
flutter pub get
flutter run
```

## Development

From this package directory:

```bash
dart pub get
dart analyze
dart test
```

## Testing

Run all tests:

```bash
dart test
```

Run only unit tests:

```bash
dart test test/unit/
```

Run integration tests:

```bash
dart test test/integration/
```

Run a single test file:

```bash
dart test test/unit/stytch_working_test.dart
```

Current note: many compatibility and integration tests are still placeholders, so a green test run is currently a smoke/structure signal more than full behavioral coverage.

## CI Status

- The top-level pipeline currently runs validation, Flutter example analysis, and release orchestration.
- The unit-test stage in `.gitlab-ci.yml` is currently commented out.
- `tools/pipelines/backend/child-ci-unit-tests-pre-dev.yml` exists but is not wired in and still has stale paths.

## License

BSD 3-Clause. See [LICENSE](LICENSE).
