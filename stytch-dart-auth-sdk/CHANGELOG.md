# Changelog

## [0.0.2]
### Added
* Added `AuthService.sendDiscoveryEmail` with typed `SendDiscoveryEmailRequest` and `SendDiscoveryEmailResponse` models for Stytch B2B discovery Email Magic Links.
* Added unit coverage for discovery email request/response serialization, validation, and endpoint routing.
* Added `InvitationService.sendInviteEmail` with typed `SendInviteEmailRequest` and `SendInviteEmailResponse` models for Stytch B2B invite Email Magic Links.
* Added unit coverage for invite email request/response serialization, validation, and endpoint routing.
* Added typed Stytch B2B session exchange and revoke responses with focused endpoint routing coverage.
* Added typed organization search and delete responses with pagination metadata coverage.
* Added `MemberService` with typed create, get, update, reactivate, search, retired-email unlink, delete, password delete, MFA phone delete, and TOTP delete coverage for Stytch B2B organization members.
* Added `RbacService.getRbacPolicy` with typed RBAC policy response coverage.
* Added typed Email Magic Link login/signup, authenticate, and discovery authenticate coverage.
* Added typed Email OTP login/signup, authenticate, discovery send, and discovery authenticate coverage.
* Added Google and Microsoft OAuth discovery start helpers.
* Added `AuthService.getJWKS` for Stytch session JWT key retrieval.
* Added typed get, authenticate, and migrate session helpers with focused B2B endpoint routing coverage.

### Changed
* Updated the package version to `0.0.2`.
* Trimmed unused runtime dependencies and refreshed the testing dependency baseline to the current workspace release.
* Updated package and docs version markers to align README, Antora, and the example app with `0.0.2`.
* Added explicit license metadata and publish exclusions for docs/deployment artifacts.
* Aligned organization request and response wire fields with the current Stytch B2B API while preserving the existing Dart property names.

### Fixed
* Removed the stale `test/flutter_test_config.dart` hook so the package test suite runs with `dart test` instead of attempting a Flutter-specific test runner.
* Kept the CI validation and release parser alignment in place for the current backend pipeline layout.
* Fixed `getOrganization` response parsing to unwrap Stytch's `organization` response envelope.
* Fixed `revokeSession` to call `POST /v1/b2b/sessions/revoke` instead of the unsupported delete-by-path route.

## [0.0.1]
### Added
* Added the core Stytch B2B SDK surface with a unified entrypoint in `lib/stytch_dart_auth_sdk.dart`.
* Added `StytchAuth` initialization flows (direct config, environment-variable bootstrap, and global helpers) in `lib/src/stytch_auth.dart`.
* Added a typed HTTP client and configuration layer in `lib/src/client/stytch_client.dart` with environment-aware base URLs and structured API error mapping.
* Added first-class client services for authentication, users, organizations, and invitations:
  * `lib/src/client/auth_service.dart`
  * `lib/src/client/user_service.dart`
  * `lib/src/client/organization_service.dart`
  * `lib/src/client/invitation_service.dart`
* Added typed request/response models for auth, user, organization, invitation, and error payloads under `lib/src/models/`.
* Added Firebase-compatibility support modules under `lib/src/auth/` (`firebase_compatibility.dart`, credentials, action code, persistence, multi-factor, storage, auth/id-token streams) to support Flutter-oriented integration scenarios.
* Added broader automated test coverage across auth compatibility, model serialization, and SDK entrypoints (unit and integration test updates in `test/`).
* Added expanded example app scaffolding under `example/`, including renamed Stytch-branded mobile sample app structure.

### Changed
* Promoted package version from `0.0.1-pre` to stable `0.0.1` in `pubspec.yaml`.
* Updated package metadata and runtime/tooling baselines:
  * Updated Dart SDK constraint to `^3.11.0`
  * Added `license: BSD-3`
  * Refreshed dependency versions for `ds_standard_features` and `ds_tools_testing`
  * Added `lints` and `flutter_lints` in dev dependencies
* Refactored sample app naming and paths from `cognito-*` to `stytch-*` conventions across example projects and CI references.
* Updated CI/CD pipeline wiring:
  * Reorganized child pipeline includes into `tools/pipelines/backend/` and `tools/pipelines/frontend/`
  * Added explicit `release` stage and improved merge-request debug output
  * Added formatting validation job (`dart format --set-exit-if-changed`)
  * Expanded branch/commit validation rules to include `docs` prefixes and semver-style release branch names
* Updated docs and repo metadata to reflect Stytch SDK structure and usage.

### Fixed
* Fixed SDK/package import and export path issues affecting SDK consumers and tests.
* Fixed Dart analysis/format issues across the SDK and test suites.
* Fixed sample app path references and CI analyze paths after repo/folder renaming.
* Fixed commit validation and branch naming checks in local hooks and CI setup.

## [0.0.1-pre]
- Initial pre-release version of the Stytch Dart Auth SDK.

