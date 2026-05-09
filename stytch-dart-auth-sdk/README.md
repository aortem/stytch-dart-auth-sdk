# stytch_dart_auth_sdk

Dart SDK for Stytch B2B auth workflows.

This package provides typed service clients and models for user, session, organization, and invitation operations over the Stytch B2B API.

## Package Status

Implemented and exported from `lib/stytch_dart_auth_sdk.dart`:

- `StytchAuth` main entrypoint.
- Service clients: `AuthService`, `UserService`, `OrganizationService`, `InvitationService`.
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
- `startMfa`
- `completeMfa`
- `createSession`
- `validateSession`
- `revokeSession`
- `revokeAllUserSessions`
- `exchangeSession`

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
